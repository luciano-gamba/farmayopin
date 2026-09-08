import 'package:flutter/material.dart';

class floatingButtons extends StatelessWidget {
  const floatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Hace que los botones se queden abajo
      children: [
        // BOTÓN 1: Gris oscuro con Reloj
        FloatingActionButton(
          heroTag: 'btn_reloj', // Evita el error de pantalla negra
          onPressed: () {
            // Acción para el botón del reloj
          },
          backgroundColor: const Color(0xFF1E1E1E), // Tu color gris oscuro
          shape: const CircleBorder(),
          child: const Icon(Icons.access_time_outlined, color: Colors.white),
        ),

        const SizedBox(height: 12), // Espacio de separación entre ambos botones
        // BOTÓN 2: Rojo con Carrito
        FloatingActionButton(
          heroTag: 'btn_carrito', // Evita el error de pantalla negra
          onPressed: () {
            // Acción para el botón del carrito
          },
          backgroundColor: const Color(0xFFDC0000), // Tu color rojo
          shape: const CircleBorder(),
          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        ),
      ],
    );
  }
}
