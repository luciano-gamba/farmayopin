import 'package:farmayopin/pages/cliente/listar_productos.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

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

    return FutureBuilder<(List<RecordModel>, double, String)>(
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
            child: SizedBox(
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
                  'Buscar productos',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }

        final items = snapshot.data!.$1;
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
                ...items.map((item) {
                  final nombre = item.data['nombre'] ?? 'Producto';
                  final precio = item.data['precioUnitario'] ?? 0;
                  final cantidad = item.data['cantidad'] ?? 1;
                  int cantidadDialogo = item.data['cantidad'] ?? 1;
                  var stock = 100;

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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // Usamos StatefulBuilder para actualizar los botones en tiempo real
                                  return StatefulBuilder(
                                    builder: (context, setDialogState) {
                                      return AlertDialog(
                                        title: Text(nombre),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: cantidadDialogo > 1
                                                  ? () async {
                                                      // Llamamos a tu función personalizada de resta
                                                      await pocketBaseService
                                                          .restarCantidadItem(
                                                            item.id,
                                                            1,
                                                          );
                                                      // Actualizamos el número dentro del diálogo
                                                      setDialogState(() {
                                                        cantidadDialogo--;
                                                      });
                                                      // Actualizamos la pantalla de fondo (refresca el FutureBuilder)
                                                      setState(() {});
                                                    }
                                                  : null,
                                              icon: const Icon(Icons.remove),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 8,
                                                  ),
                                              child: Text(
                                                '$cantidadDialogo',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: cantidadDialogo < stock
                                                  ? () async {
                                                      // Llamamos a tu función personalizada de suma
                                                      stock =
                                                          await pocketBaseService
                                                              .sumarCantidadItem(
                                                                item.id,
                                                                1,
                                                              );
                                                      // Actualizamos el número dentro del diálogo
                                                      setDialogState(() {
                                                        cantidadDialogo++;
                                                      });
                                                      // Actualizamos la pantalla de fondo (refresca el FutureBuilder)
                                                      setState(() {});
                                                    }
                                                  : null,
                                              icon: const Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Cerrar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
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
                    onPressed: () async {
                      if (!snapshot.hasError &&
                          snapshot.hasData &&
                          snapshot.data!.$3.isNotEmpty) {
                        try {
                          await pocketBaseService.pagarCarrito(
                            snapshot.data!.$3,
                          );

                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pago realizado con éxito'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListarProductos(),
                            ),
                          );
                        } catch (error) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Error al procesar el pago: $error',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'No hay productos en el carrito o los datos son inválidos.',
                            ),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
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
