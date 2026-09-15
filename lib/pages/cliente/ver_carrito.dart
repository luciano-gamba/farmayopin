import 'package:farmayopin/pages/cliente/listar_productos.dart';
import 'package:farmayopin/widgets/carrito_screen.dart';
import 'package:farmayopin/widgets/farmayopin_header.dart';
import 'package:farmayopin/widgets/main_layout.dart';
import 'package:flutter/material.dart';

class VerCarrito extends StatelessWidget {
  const VerCarrito({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FarmayopinHeader(
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
          CarritoScreen(),
        ],
      ),
    );
  }
}
