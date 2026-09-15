// Aca ira la conexion con pocketbase
import 'dart:io';

import 'package:farmayopin/models/producto.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class PocketBaseService {
  static final PocketBaseService _instance = PocketBaseService._internal();

  factory PocketBaseService() {
    return _instance;
  }

  PocketBaseService._internal();

  //final pb = PocketBase('http://10.0.2.2:8090');
  final pb = PocketBase('http://127.0.0.1:8090');

  // =========================
  // AUTENTICACIÓN
  // =========================

  // Registrar usuario
  Future<RecordModel> registrarUsuario({
    required String email,
    required String nombre,
    required String password,
  }) async {
    final body = <String, dynamic>{
      'email': email,
      'emailVisibility': false,
      'name': nombre,
      'password': password,
      'passwordConfirm': password,
    };

    final record = await pb.collection('usuarios').create(body: body);

    return record;
  }

  Future<RecordModel> iniciarSesion({
    required String email,
    required String password,
  }) async {
    final authData = await pb
        .collection('usuarios')
        .authWithPassword(email, password);

    return authData.record;
  }

  Future<void> cerrarSesion() async {
    pb.authStore.clear();
  }

  Future<void> solicitarRecuperacionPassword(String email) async {
    await pb.collection('usuarios').requestPasswordReset(email);
  }

  bool get esAdmin {
    final usuario = pb.authStore.record;

    if (usuario == null) {
      return false;
    }

    return usuario.getStringValue('role') == 'admin';
  }

  // =========================
  // PRODUCTOS
  // =========================

  Future<List<Producto>> obtenerProductos() async {
    final registros = await pb.collection('productos').getFullList();

    return registros.map((registro) {
      final nombreImagen = registro.get<String>('imagenProducto');

      final urlImagen = nombreImagen.isNotEmpty
          ? pb.files.getUrl(registro, nombreImagen).toString()
          : '';

      return Producto(
        id: registro.id,
        nombre: registro.get<String>('nombre'),
        precio: registro.get<double>('precio'),
        stock: registro.get<int>('stock'),
        descripcion: registro.get<String?>('descripcion'),
        imagen: urlImagen,
      );
    }).toList();
  }

  Future<RecordModel> nuevoProducto({
    required String nombre,
    required double precio,
    required int stock,
    required File imagenProducto,
    String? descripcion,
  }) async {
    final body = <String, dynamic>{
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'stock': stock,
    };

    final record = await pb
        .collection('productos')
        .create(
          body: body,
          files: [
            await http.MultipartFile.fromPath(
              'imagenProducto',
              imagenProducto.path,
            ),
          ],
        );

    return record;
  }

  Future<void> revisarServicio() async {
    print('Sesión válida: ${pb.authStore.isValid}');
    print('Usuario autenticado: ${pb.authStore.record}');
  }

  // =========================
  // ORDENES / ITEMS
  // =========================
  Future<void> sumarTotalOrden(String miOrdenId, double sumando) async {
    try {
      final record = await pb.collection('ordenes').getOne(miOrdenId);
      final double importeTotal = record.getDoubleValue("importeTotal");
      final nuevoImporteTotal = importeTotal + sumando;

      await pb
          .collection('ordenes')
          .update(miOrdenId, body: {'importeTotal': nuevoImporteTotal});

      print("Importe total recalculado: $nuevoImporteTotal");
    } catch (e) {
      print("Error al sumar al total: $e");
    }
  }

  Future<void> restarTotalOrden(String miOrdenId, double sustraendo) async {
    try {
      final record = await pb.collection('ordenes').getOne(miOrdenId);
      final double importeTotal = record.getDoubleValue("importeTotal");
      final nuevoImporteTotal = importeTotal - sustraendo;

      await pb
          .collection('ordenes')
          .update(miOrdenId, body: {'importeTotal': nuevoImporteTotal});

      print("Importe total recalculado: $nuevoImporteTotal");
    } catch (e) {
      print("Error al restar al total: $e");
    }
  }

  Future<void> restarCantidadItem(String idItem, int sustraendo) async {
    try {
      final item = await pb.collection('items').getOne(idItem);
      final minuendo = item.getIntValue('cantidad');
      if (minuendo <= sustraendo) {
        await pb.collection('items').delete(idItem);
      } else {
        await pb
            .collection('items')
            .update(idItem, body: {'cantidad': minuendo - sustraendo});
      }
    } catch (e) {
      print("Error al res al total: $e");
    }
  }

  Future<void> agregarItem(Producto producto, int cantidad) async {
    final usuario = pb.authStore.record!;
    final String miOrdenId = usuario.get<String>("miOrden");
    try {
      if (miOrdenId.isEmpty) {
        final nuevaOrden = await pb
            .collection('ordenes')
            .create(body: {'miUsuario': usuario.id});

        await pb
            .collection('usuarios')
            .update(usuario.id, body: {'miOrden': nuevaOrden.id});

        await pb.collection('usuarios').authRefresh();

        final nuevoItem = await pb
            .collection('items')
            .create(
              body: {
                'miOrden': nuevaOrden.id,
                'miProducto': producto.id,
                'cantidad': cantidad,
                'precioUnitario': producto.precio,
                'nombre': producto.nombre,
              },
            );
        await pb
            .collection('ordenes')
            .update(nuevaOrden.id, body: {'+misItems': nuevoItem.id});

        await sumarTotalOrden(nuevaOrden.id, producto.precio * cantidad);
        print("Nueva orden creada y primer producto agregado.");
      } else {
        final itemsExistentes = await pb
            .collection('items')
            .getList(
              page: 1,
              perPage: 1,
              filter: 'miOrden = "$miOrdenId" && miProducto = "${producto.id}"',
            );

        if (itemsExistentes.items.isNotEmpty) {
          final item = itemsExistentes.items.first;
          var nuevaCantidad = item.get<int>('cantidad') + cantidad;

          if (nuevaCantidad > producto.stock) {
            nuevaCantidad = producto.stock;
          }

          await pb
              .collection('items')
              .update(item.id, body: {'cantidad': nuevaCantidad});
        } else {
          final nuevoItem = await pb
              .collection('items')
              .create(
                body: {
                  'miOrden': miOrdenId,
                  'miProducto': producto.id,
                  'cantidad': cantidad,
                  'precioUnitario': producto.precio,
                  'nombre': producto.nombre,
                },
              );
          await pb
              .collection('ordenes')
              .update(miOrdenId, body: {'+misItems': nuevoItem.id});
        }
        await sumarTotalOrden(miOrdenId, producto.precio * cantidad);
        print("Producto añadido a la orden existente.");
      }
    } catch (e) {
      print("Error al gestionar la orden: $e");
    }
  }

  Future<(List<RecordModel>, double)> obtenerCarrito() async {
    final usuario = pb.authStore.record!;
    final String miOrdenId = usuario.get<String>("miOrden");

    final record = await pb
        .collection('ordenes')
        .getOne(miOrdenId, expand: 'misItems');

    final List<RecordModel> items = record.getListValue('expand.misItems');

    double total = record.getDoubleValue('importeTotal');

    return (items, total);
  }
}
