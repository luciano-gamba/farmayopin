import 'package:farmayopin/pages/cliente/listar_productos.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

// 1. Convertimos la pantalla en StatefulWidget
class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  final PocketBaseService pocketBaseService = PocketBaseService();

  @override
  Widget build(BuildContext context) {
    final anchoPantalla = MediaQuery.of(context).size.width;

    return FutureBuilder<(List<RecordModel>, double)>(
      // Cada vez que se llama a setState, el FutureBuilder vuelve a consultar al servicio
      future: pocketBaseService.obtenerCarrito(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5A5A5A)),
          );
        }

        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.$1.isEmpty) {
          return Container(
            width: anchoPantalla * 0.85,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.80),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFFD9D9D9)),
            ),
            child: Text(
              'Tu carrito está vacío.',
              style: TextStyle(fontFamily: 'Inter', fontSize: 16),
            ),
          );
        }

        final productos = snapshot.data!.$1;
        final precioTotal = snapshot.data!.$2;

        return Center(
          child: Container(
            width: anchoPantalla * 0.85,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.80),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFFD9D9D9)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 14,
              children: [
                // Sección del Precio Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '\$',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 28,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      precioTotal.toStringAsFixed(0),
                      style: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 48,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Lista de Tarjetas de Productos
                ...productos.map((item) {
                  final nombre = item.data['nombre'] ?? 'Producto';
                  final precio = item.data['precioUnitario'] ?? 0;
                  final cantidad = item.data['cantidad'] ?? 1;

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              print('Se tocó el producto: $nombre');
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  nombre,
                                  style: const TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '\$$precio (x$cantidad)',
                                  style: const TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Tu botón modificado para refrescar en tiempo real
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xFF757575),
                            size: 20,
                          ),
                          onPressed: () async {
                            // 2. Agregamos el await para esperar a que PocketBase termine la edición
                            await pocketBaseService.restarCantidadItem(
                              item.id,
                              item.getIntValue('cantidad'),
                            );

                            // 3. Notificamos a Flutter que los datos cambiaron para que redibuje la pantalla
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  );
                }),

                // Botón: Buscar más productos
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListarProductos(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A5A5A),
                      foregroundColor: const Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Buscar más productos',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                // Botón: Finalizar compra
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListarProductos(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC0000),
                      foregroundColor: const Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Finalizar compra',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
