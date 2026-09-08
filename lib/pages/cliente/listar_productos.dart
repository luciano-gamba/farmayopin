import 'package:farmayopin/widgets/floating_buttons.dart';
import 'package:farmayopin/widgets/productos/productos_screen.dart'; // Ajusta la ruta
import 'package:flutter/material.dart';

class ListarProductos extends StatelessWidget {
  const ListarProductos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 1. Agregamos la imagen de fondo desde tus assets
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/farmacia2.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        // 2. Agregamos el padding para separarlo del techo
        child: const Padding(
          padding: EdgeInsets.only(
            top: 40.0,
          ), // <-- Modifica este número para dar más o menos espacio
          child: ProductosScreen(),
        ),
      ),
      floatingActionButton: floatingButtons(),
    );
  }
}
