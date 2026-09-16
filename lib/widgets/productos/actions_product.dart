import 'package:farmayopin/models/producto.dart';
import 'package:farmayopin/pages/admin/editar_producto.dart';
import 'package:farmayopin/pages/cliente/listar_productos.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
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
  final PocketBaseService pocketBaseService = PocketBaseService();
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
    pocketBaseService.agregarItem(widget.producto, cantidad);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$cantidad unidad${cantidad == 1 ? '' : 'es'} agregada${cantidad == 1 ? '' : 's'} al carrito',
        ),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ListarProductos()),
    );
  }

  void _editarProducto() {
    // Acá irá la navegación hacia editar producto.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => EditarProducto(producto: widget.producto)),
    );
  }

  void _historicoProducto() {
    // Acá irá la navegacion hacia historico de producto.
  }

  @override
  Widget build(BuildContext context) {
    if (widget.esAdmin) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: _historicoProducto,
            icon: const Icon(Icons.access_time_outlined, color: Colors.white),
            label: const Text(
              'Ver Historico',
              style: TextStyle(color: Colors.white),
              ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
            ),
          ),
          
          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: _editarProducto,
            icon: const Icon(Icons.edit),
            label: const Text('Editar producto',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Cantidad',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
          onPressed: widget.producto.stock > 0 ? _agregarAlCarrito : null,
          icon: const Icon(Icons.shopping_cart),
          label: const Text('Agregar al carrito'),
           style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
