// Aca ira la conexion con pocketbase
import 'dart:io';

import 'package:farmayopin/models/producto.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class PocketBaseService {
  final pb = PocketBase('http://10.0.2.2:8090');
  
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

    final record = await pb.collection('users').create(
      body: body,
    );

    return record;
  }

  Future<RecordModel> iniciarSesion({
    required String email,
    required String password,
  }) async {
    final authData = await pb.collection('users').authWithPassword(email, password);

    return authData.record;
  }

  Future<void> cerrarSesion() async{
    pb.authStore.clear();
  }

  Future<void> solicitarRecuperacionPassword(String email) async {
    await pb.collection('users').requestPasswordReset(email);
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

    final record = await pb.collection('productos').create(
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
}


