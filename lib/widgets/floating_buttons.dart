import 'package:farmayopin/pages/cliente/historico_cliente.dart';
import 'package:farmayopin/pages/cliente/ver_carrito.dart';
import 'package:farmayopin/widgets/historialCliente/purchase_history_cliente.dart';
import 'package:flutter/material.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Hace que los botones se queden abajo
      children: [
        // BOTÓN 1: Gris oscuro con Reloj
        FloatingActionButton(
          heroTag: 'btn_reloj', // Evita el error de pantalla negra
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HistoricoCliente()),
            );
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const VerCarrito()),
            );
          },
          backgroundColor: const Color(0xFFDC0000), // Tu color rojo
          shape: const CircleBorder(),
          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        ),
      ],
    );
  }
}
