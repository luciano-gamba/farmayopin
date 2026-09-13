import 'package:flutter/material.dart';

class CategoriasProductos extends StatelessWidget {
  final String categoriaSeleccionada;
  final Function(String) onCategoriaSeleccionada;

  const CategoriasProductos({
    super.key,
    required this.categoriaSeleccionada,
    required this.onCategoriaSeleccionada,
  });

  @override
  Widget build(BuildContext context) {
    final categorias = ['Salud', 'Bebés', 'Higiene', 'Perfumes', 'Analgésicos'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categorias.map((categoria) {
          return ChoiceChip(
            label: Text(categoria),
            selected: categoria == categoriaSeleccionada,
            onSelected: (_) {
              onCategoriaSeleccionada(categoria);
            },
          );
        }).toList(),
      ),
    );
  }
}
