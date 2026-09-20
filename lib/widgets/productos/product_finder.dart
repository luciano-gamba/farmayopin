import 'package:farmayopin/models/producto.dart';
import 'package:farmayopin/pages/cliente/ver_producto.dart';
import 'package:farmayopin/pages/noRol/ingresar.dart';
import 'package:farmayopin/services/database_service.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart'; // Asegúrate de tener esta importación

class BuscadorProductos extends StatefulWidget {
  const BuscadorProductos({super.key});

  @override
  State<BuscadorProductos> createState() => _BuscadorProductosState();
}

class _BuscadorProductosState extends State<BuscadorProductos> {
  // Controladores y servicios
  final TextEditingController _searchController = TextEditingController();
  final PocketBaseService _pbService = PocketBaseService();
  final AppDatabase dbLocal = AppDatabase();

  // Lista para guardar los productos encontrados
  List<RecordModel> _productos = [];
  bool _cargando = false;

  // Función para buscar productos en PocketBase
  Future<void> _buscarProductos(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _productos = [];
      });
      return;
    }

    setState(() {
      _cargando = true;
    });

    try {
      // 1. Obtenemos la instancia de PocketBase desde tu servicio
      final pb = _pbService.pb; // Ajusta esto según cómo se llame el objeto PocketBase en tu servicio

      // 2. Buscamos en la colección 'productos'.
      // Modifica 'nombre' por el campo real de tu base de datos (ej. 'descripcion', 'marca')
      final result = await pb
          .collection('productos')
          .getList(page: 1, perPage: 20, filter: 'nombre ~ "$query"');

      setState(() {
        _productos = result.items;
        _cargando = false;
      });
    } catch (e) {
      setState(() {
        _cargando = false;
      });
      // Opcional: Mostrar un mensaje de error si la búsqueda falla
      debugPrint('Error al buscar: $e');
    }
  }

  Future<void> _cerrarSesion(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      await _pbService.cerrarSesion();
      await dbLocal.vaciarCacheUsuario();
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Ingresar()),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.95,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: _buscarProductos,
                  decoration: InputDecoration(
                    hintText: 'Buscar producto...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.80),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // Botón para borrar el texto escrito
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _buscarProductos('');
                            },
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _cerrarSesion(context),
                child: ClipOval(
                  child: Image.asset(
                    'images/perfil_default.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Lista de resultados desplegable
        if (_cargando)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),

        if (!_cargando && _productos.isNotEmpty)
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: const EdgeInsets.only(top: 8),
            constraints: const BoxConstraints(
              maxHeight: 300,
            ), // Límite de altura
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.80),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _productos.length,
              itemBuilder: (context, index) {
                final producto = _productos[index];
                // Ajusta 'nombre' y 'precio' a los campos de tu colección
                return ListTile(
                  title: Text(producto.data['nombre'] ?? 'Sin nombre'),
                  subtitle: Text('\$${producto.data['precio'] ?? '0'}'),
                  leading: const Icon(Icons.medication), // Icono de ejemplo
                  onTap: () async {
                    final String id = producto.id;
                    final String nombre =
                        producto.data['nombre'] ?? 'Sin nombre';
                    final num precioNum = producto.data['precio'] ?? 0;
                    final double precio = precioNum.toDouble();

                    // Convertimos el stock a número entero
                    final num stockNum = producto.data['stock'] ?? 0;
                    final int stock = stockNum.toInt();

                    final String? descripcion = producto.data['descripcion'];

                    final productoAEnviar = Producto(
                      id: id,
                      nombre: nombre,
                      precio: precio,
                      stock: stock,
                      descripcion: descripcion,
                      imagen: await PocketBaseService().obtenerImagen(
                        producto.data['id'],
                      ),
                    );

                    // 3. Navegamos a la pantalla VerProducto pasando el objeto correcto
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VerProducto(producto: productoAEnviar),
                      ),
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
