import 'package:farmayopin/models/producto.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:farmayopin/widgets/productos/buscador_productos.dart';
import 'package:farmayopin/widgets/productos/categorias_productos.dart';
import 'package:farmayopin/widgets/productos/producto_card.dart';
import 'package:flutter/material.dart';

class ListaProductos extends StatefulWidget {
  const ListaProductos({super.key});

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  final PocketBaseService pocketBaseService = PocketBaseService();

  List<Producto> productos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    try {
      final resultado = await pocketBaseService.obtenerProductos();

      setState(() {
        productos = resultado;
        cargando = false;
      });
    } catch (e) {
      print('Error al obtener productos: $e');

      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BuscadorProductos(),
            

            Expanded(
              child: cargando
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        return ProductoCard(
                          producto: productos[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

