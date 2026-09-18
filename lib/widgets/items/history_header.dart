import 'package:farmayopin/widgets/glass_card.dart';
import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget {
  final String nombreProducto;

  const HistoryHeader({super.key, required this.nombreProducto});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsetsGeometry.symmetric(
        horizontal: 24,
        vertical: 18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Histórial del Producto:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          
          const SizedBox(height: 6,),

          Text(
            nombreProducto,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFDC0000),
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
