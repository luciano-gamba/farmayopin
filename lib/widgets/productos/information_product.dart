import 'dart:io';

import 'package:farmayopin/models/producto.dart';
import 'package:farmayopin/services/cache_service.dart';
import 'package:flutter/material.dart';

class InformacionProducto extends StatelessWidget {
  final Producto producto;

  const InformacionProducto({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Imagen
        SizedBox(
          width: double.infinity,
          height: 250,
          child: FutureBuilder<File>(
            future: CacheService.descargarImagen(producto.imagen),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Icon(Icons.broken_image, size: 50));
              }

              return Image.file(snapshot.data!, fit: BoxFit.contain);
            },
          ),
        ),

        const SizedBox(height: 16),

        // Nombre
        Text(
          producto.nombre,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        // Precio
        Text(
          '\$${producto.precio.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 8),

        // Stock
        Text(
          '${producto.stock} unidades disponibles',
          style: TextStyle(
            fontSize: 14,
            color: producto.stock > 0 ? Colors.green : Colors.red,
          ),
        ),

        const SizedBox(height: 16),

        // Descripción
        if (producto.descripcion != null &&
            producto.descripcion!.trim().isNotEmpty)
          Text(
            producto.descripcion!,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
      ],
    );
  }
}
