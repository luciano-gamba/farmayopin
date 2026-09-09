import 'package:farmayopin/pages/admin/nuevo_producto.dart';
import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  const FloatingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, 
      children: [
        // BOTÓN : Rojo con un signo de más
        FloatingActionButton(
          heroTag: 'btn_agregar_producto',
          onPressed: () {
            // Acción para el botón de agregar producto
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NuevoProducto(),
              ),
            );
          },
          backgroundColor: const Color(0xFFDC0000),
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        const SizedBox(height: 12), // Espacio de separación entre ambos botones
      ],
    );
  }
}
