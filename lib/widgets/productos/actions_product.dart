import 'package:farmayopin/models/producto.dart';
import 'package:flutter/material.dart';

class AccionesProducto extends StatefulWidget {
  final Producto producto;
  final bool esAdmin;

  const AccionesProducto({
    super.key,
    required this.producto,
    required this.esAdmin,
  });

  @override
  State<AccionesProducto> createState() => _AccionesProductoState();
}

class _AccionesProductoState extends State<AccionesProducto> {
  int cantidad = 1;

  void _aumentarCantidad() {
    if (cantidad < widget.producto.stock) {
      setState(() {
        cantidad++;
      });
    }
  }

  void _disminuirCantidad() {
    if (cantidad > 1) {
      setState(() {
        cantidad--;
      });
    }
  }

  void _agregarAlCarrito() {
    // Acá irá posteriormente la lógica para agregar al carrito.

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$cantidad unidad${cantidad == 1 ? '' : 'es'} agregada${cantidad == 1 ? '' : 's'} al carrito',
        ),
      ),
    );
  }

  void _editarProducto() {
    // Acá irá la navegación hacia editar producto.
  }

  void _eliminarProducto() {
    // Acá irá posteriormente la confirmación y eliminación.
  }

  @override
  Widget build(BuildContext context) {
    if (widget.esAdmin) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: _editarProducto,
            icon: const Icon(Icons.edit),
            label: const Text('Editar producto'),
          ),

          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: _eliminarProducto,
            icon: const Icon(Icons.delete),
            label: const Text('Eliminar producto'),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Cantidad',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: cantidad > 1 ? _disminuirCantidad : null,
              icon: const Icon(Icons.remove),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: Text(
                '$cantidad',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            IconButton(
              onPressed: cantidad < widget.producto.stock
                  ? _aumentarCantidad
                  : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        const SizedBox(height: 12),

        ElevatedButton.icon(
          onPressed: widget.producto.stock > 0
              ? _agregarAlCarrito
              : null,
          icon: const Icon(Icons.shopping_cart),
          label: const Text('Agregar al carrito'),
        ),
      ],
    );
  }
}
