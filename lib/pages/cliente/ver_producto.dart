import 'package:farmayopin/models/producto.dart';
import 'package:farmayopin/pages/cliente/listar_productos.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:farmayopin/widgets/farmayopin_header.dart';
import 'package:farmayopin/widgets/main_layout.dart';
import 'package:farmayopin/widgets/productos/actions_product.dart';
import 'package:farmayopin/widgets/productos/information_product.dart';
import 'package:flutter/material.dart';

class VerProducto extends StatefulWidget {
  final Producto producto;

  const VerProducto({super.key, required this.producto});
  @override
  State<VerProducto> createState() => _VerProductoState();
}

class _VerProductoState extends State<VerProducto> {
  int cantidad = 1;

  @override
  Widget build(BuildContext context) {
    final producto = widget.producto;

    return MainLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FarmayopinHeader(
            onVolver: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ListarProductos()),
              );
            },
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.80),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InformacionProducto(producto: producto),

                  const SizedBox(height: 24),

                  AccionesProducto(
                    producto: producto,
                    esAdmin: PocketBaseService().esAdmin,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
