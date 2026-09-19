import 'package:farmayopin/pages/cliente/listar_productos.dart';
import 'package:farmayopin/widgets/farmayopin_header.dart';
import 'package:farmayopin/widgets/historialCliente/purchase_history_cliente.dart';
import 'package:farmayopin/widgets/main_layout.dart';

import 'package:flutter/material.dart';

class HistoricoCliente extends StatelessWidget {
  const HistoricoCliente({super.key});
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FarmayopinHeader(
            onVolver: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListarProductos(),
                ),
              );
            },
          ),

          SizedBox(height: 20),

          PurchaseHistoryCliente(),
        ],
      ),
    );
  }
}
