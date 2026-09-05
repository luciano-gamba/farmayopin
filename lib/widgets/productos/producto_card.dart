import 'dart:io';

import 'package:farmayopin/models/producto.dart';
import 'package:farmayopin/services/cache_service.dart';
import 'package:flutter/material.dart';

class ProductoCard extends StatelessWidget{
  final Producto producto;

  const ProductoCard({
    super.key,
    required this.producto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<File>(
                future: CacheService.descargarImagen(producto.imagen),
                builder: (context, snapshot) {
                  print(
                    'FutureBuilder: estado=${snapshot.connectionState}, '
                    'error=${snapshot.error}',
                  );

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Icon(Icons.broken_image));
                  }

                  return Image.file(snapshot.data!, fit: BoxFit.contain);
                },
              ),
            ),

            const SizedBox(height: 8),

            Text(producto.nombre, maxLines: 2, overflow: TextOverflow.ellipsis),

            Text(
              '\$${producto.precio}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            if (producto.descripcion != null)
              Text(
                producto.descripcion!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}