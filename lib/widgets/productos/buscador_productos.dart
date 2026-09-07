
import 'package:farmayopin/pages/noRol/home.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:flutter/material.dart';

class BuscadorProductos extends StatelessWidget{
  const BuscadorProductos({super.key});

  Future<void> _cerrarSesion(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      final pbService = PocketBaseService();

      await pbService.cerrarSesion();

      if(context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded( 
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar producto...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),
        
        GestureDetector(
          onTap: () => _cerrarSesion(context),
          child: ClipOval(
            child: Image.asset(
              'images/perfil_default.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ]
    );
  }
}
