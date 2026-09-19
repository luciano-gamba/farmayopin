import 'package:farmayopin/widgets/glass_card.dart';
import 'package:flutter/material.dart';

class HistoryHeaderCliente extends StatelessWidget {
  const HistoryHeaderCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.access_time_outlined),
          const Text(
            ' Histórico de Compras',
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
