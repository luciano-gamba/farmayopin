import 'package:farmayopin/models/producto.dart';
import 'package:farmayopin/widgets/farmayopin_header.dart';
import 'package:farmayopin/widgets/main_layout.dart';
import 'package:farmayopin/widgets/items/purchase_history.dart';
import 'package:flutter/material.dart';

class HistoricoProducto extends StatelessWidget {
  final Producto producto;

  const HistoricoProducto(
    {super.key,
    required this.producto}
  );
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FarmayopinHeader(
            onVolver: () {
              Navigator.pop(context);
            },
          ),

          SizedBox(height: 20),

          PurchaseHistory(producto: producto),
        ],
      ),
    );
  }
}