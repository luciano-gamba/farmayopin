import 'package:farmayopin/models/producto.dart';
import 'package:farmayopin/pages/cliente/listar_productos.dart';
import 'package:farmayopin/widgets/farmayopin_header.dart';
import 'package:farmayopin/widgets/main_layout.dart';
import 'package:farmayopin/widgets/productos/form_product.dart';
import 'package:flutter/material.dart';

class EditarProducto extends StatelessWidget {
  final Producto producto;

  const EditarProducto(
    {super.key,
    required this.producto}
    );

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [FarmayopinHeader(
          onVolver: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ListarProductos(),
              ),
            );
          },
        ),

        SizedBox(height: 20),
        
        FormProduct(producto: producto),
        ],
      ),
    );
  }
}
