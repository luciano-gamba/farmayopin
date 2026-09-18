// Aca ira la conexion con pocketbase
import 'dart:io';

import 'package:farmayopin/models/item.dart';
import 'package:farmayopin/models/producto.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class PocketBaseService {
  static final PocketBaseService _instance = PocketBaseService._internal();

  factory PocketBaseService() {
    return _instance;
  }

  PocketBaseService._internal();

  final pb = PocketBase('http://10.0.2.2:8090');
  //final pb = PocketBase('http://127.0.0.1:8090');

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

    await pb.collection('usuarios').create(body: body);

    final authData = await pb
        .collection('usuarios')
        .authWithPassword(email, password);

    return authData.record;
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

  Future<Producto> editarProducto({
    required String id,
    String? nombre,
    double? precio,
    int? stock,
    File? imagenProducto,
    String? descripcion,
  }) async {
    final body = <String, dynamic>{};

    if (nombre != null) body['nombre'] = nombre;
    if (descripcion != null) body['descripcion'] = descripcion;
    if (precio != null) body['precio'] = precio;
    if (stock != null) body['stock'] = stock;

    final files = imagenProducto != null
        ? [
            await http.MultipartFile.fromPath(
              'imagenProducto',
              imagenProducto.path,
            ),
          ]
        : <http.MultipartFile>[];

    final record = await pb
        .collection('productos')
        .update(id, body: body, files: files);
    
    final nombreImagen = record.get<String>('imagenProducto');

    final urlImagen = nombreImagen.isNotEmpty
        ? pb.files.getURL(record, nombreImagen).toString()
        : '';
    return Producto(
      id: record.id,
      nombre: record.get<String>('nombre'),
      precio: record.get<double>('precio'),
      stock: record.get<int>('stock'),
      descripcion: record.get<String?>('descripcion'),
      imagen: urlImagen,
    );
    
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
      final cantidadVieja = item.getIntValue('cantidad');
      if (cantidadVieja <= sustraendo) {
        await restarTotalOrden(
          item.get('miOrden'),
          item.getDoubleValue('precioUnitario') * cantidadVieja,
        );
        await pb.collection('items').delete(idItem);
      } else {
        await restarTotalOrden(
          item.get('miOrden'),
          item.getDoubleValue('precioUnitario') * sustraendo,
        );
        await pb
            .collection('items')
            .update(idItem, body: {'cantidad': cantidadVieja - sustraendo});
      }
    } catch (e) {
      print("Error al restar al total: $e");
    }
  }

  Future<int> sumarCantidadItem(String idItem, int sumando) async {
    try {
      final item = await pb
          .collection('items')
          .getOne(idItem, expand: 'miProducto');
      final cantidadVieja = item.getIntValue('cantidad');
      final prod = item.get<RecordModel>('expand.miProducto');
      if (cantidadVieja < prod.getDoubleValue('stock')) {
        await sumarTotalOrden(
          item.get('miOrden'),
          item.getDoubleValue('precioUnitario') * sumando,
        );
        await pb
            .collection('items')
            .update(idItem, body: {'cantidad': cantidadVieja + sumando});
      }
      return prod.getIntValue('stock');
    } catch (e) {
      return 1;
    }
  }

  Future<void> agregarItem(Producto producto, int cantidad) async {
    final usuario = pb.authStore.record!;
    final String miOrdenId = usuario.getStringValue('miOrden');

    try {
      // CASO 1: El usuario no tiene una orden activa (Carrito vacío)
      if (miOrdenId.isEmpty) {
        int cantidadNueva = cantidad > producto.stock
            ? producto.stock
            : cantidad;
        final nuevaOrden = await pb
            .collection('ordenes')
            .create(body: {'miUsuario': usuario.id});

        // 2. Vincular la orden al usuario y refrescar sesión
        await pb
            .collection('usuarios')
            .update(usuario.id, body: {'miOrden': nuevaOrden.id});
        await pb.collection('usuarios').authRefresh();

        // 3. Crear el ítem del producto
        final nuevoItem = await pb
            .collection('items')
            .create(
              body: {
                'miOrden': nuevaOrden.id,
                'miProducto': producto.id,
                'cantidad': cantidadNueva,
                'precioUnitario': producto.precio,
                'nombre': producto.nombre,
              },
            );

        // 4. Vincular el ítem a la orden y sumar el total correcto
        await pb
            .collection('ordenes')
            .update(nuevaOrden.id, body: {'+misItems': nuevoItem.id});

        await sumarTotalOrden(nuevaOrden.id, producto.precio * cantidadNueva);
        print("Nueva orden creada y primer producto agregado.");
      }
      // CASO 2: El usuario ya tiene una orden activa
      else {
        // Buscar si el producto ya está en esta orden
        final itemsExistentes = await pb
            .collection('items')
            .getList(
              page: 1,
              perPage: 1,
              filter: 'miOrden = "$miOrdenId" && miProducto = "${producto.id}"',
            );

        // Sub-caso A: El producto YA existe en el carrito
        if (itemsExistentes.items.isNotEmpty) {
          final item = itemsExistentes.items.first;
          final viejaCantidad = item.getIntValue('cantidad');

          var nuevaCantidad = viejaCantidad + cantidad;

          // Validar límite de stock
          if (nuevaCantidad > producto.stock) {
            nuevaCantidad = producto.stock;
          }

          // Calcular cuántas unidades REALES se están sumando en este intento
          final int cantidadAgregadaReal = nuevaCantidad - viejaCantidad;

          // Si no se añadieron unidades nuevas (porque ya estaba al máximo de stock)
          if (cantidadAgregadaReal <= 0) {
            print("No se agregaron más unidades: Alcanzó el límite de stock.");
            return;
          }

          // Actualizar la cantidad en la base de datos
          await pb
              .collection('items')
              .update(item.id, body: {'cantidad': nuevaCantidad});

          // Sumar al total de la orden solo el equivalente a las unidades reales agregadas
          await sumarTotalOrden(
            miOrdenId,
            producto.precio * cantidadAgregadaReal,
          );
        }
        // Sub-caso B: El producto NO existe en el carrito
        else {
          int cantidadNueva = cantidad > producto.stock
              ? producto.stock
              : cantidad;

          if (cantidadNueva <= 0) {
            print("No hay stock disponible para este producto.");
            return;
          }

          final nuevoItem = await pb
              .collection('items')
              .create(
                body: {
                  'miOrden': miOrdenId,
                  'miProducto': producto.id,
                  'cantidad': cantidadNueva,
                  'precioUnitario': producto.precio,
                  'nombre': producto.nombre,
                },
              );

          await pb
              .collection('ordenes')
              .update(miOrdenId, body: {'+misItems': nuevoItem.id});

          await sumarTotalOrden(miOrdenId, producto.precio * cantidadNueva);
        }

        print("Producto añadido a la orden existente.");
      }
    } catch (e) {
      print("Error al gestionar la orden: $e");
    }
  }

  Future<(List<RecordModel>, double, String)> obtenerCarrito() async {
    final usuario = pb.authStore.record!;
    final String miOrdenId = usuario.getStringValue("miOrden");

    final record = await pb
        .collection('ordenes')
        .getOne(miOrdenId, expand: 'misItems');

    final List<RecordModel> items = record.getListValue('expand.misItems');

    double total = record.getDoubleValue('importeTotal');

    return (items, total, miOrdenId);
  }

  Future<void> pagarCarrito(String idOrden) async {
    try {
      final orden = await pb
          .collection('ordenes')
          .getOne(idOrden, expand: 'misItems');
      final List<RecordModel> items = orden.getListValue('expand.misItems');
      for (var item in items) {
        final producto = await pb
            .collection('productos')
            .getOne(item.getStringValue('miProducto'));
        final stock = producto.getIntValue('stock');
        final cantidad = item.getIntValue('cantidad');
        if (stock >= cantidad) {
          await pb
              .collection('productos')
              .update(
                producto.id,
                body: {'stock': stock - cantidad, '+miHistorial': item.id},
              );
          await pb
              .collection('items')
              .update(
                item.id,
                body: {
                  'fechaCompletada': DateTime.now().toIso8601String(),
                  'miUsuario': orden.getStringValue('miUsuario'),
                },
              );
        } else {
          restarCantidadItem(
            item.id,
            cantidad,
          ); //Elimina el item de la orden para prevenir errores
        }
      }
      await pb
          .collection('ordenes')
          .update(
            idOrden,
            body: {'fechaCompletada': DateTime.now().toIso8601String()},
          );
      await pb
          .collection('usuarios')
          .update(
            orden.getStringValue('miUsuario'),
            body: {'+misOrdenes': orden.id, 'miOrden-': orden.id},
          );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Item>> obtenerItemsProducto({
    required String idProducto,
  }) async {
    final registros = await pb.collection('productos').getOne(idProducto, expand: 'miHistorial.miUsuario');

    final List<RecordModel> historial = registros.getListValue('expand.miHistorial');

    return historial.map((registro) {
      final usuario = registro.get<RecordModel>('expand.miUsuario');
      
      // print('Item: ${registro.data}');

      // print('Usuario: ${usuario.data}');
      // print('Email: ${usuario.getStringValue('email')}');

      return Item(
        idProducto: registro.getStringValue('miProducto'),
        idOrden: registro.getStringValue('miOrden'),
        nombreProducto: registro.getStringValue('nombre'),
        precio: registro.get<double>('precioUnitario'),
        cantidad: registro.get<int>('cantidad'),
        emailUsuario: usuario.getStringValue('email'),
        fechaCompletada: DateTime.parse(
          registro.get<String>('fechaCompletada'),
        ),
      );
    }).toList();
  }
}
