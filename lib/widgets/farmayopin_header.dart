// lib/widgets/farmayopin_header.dart
import 'package:farmayopin/pages/cliente/listar_productos.dart';
import 'package:farmayopin/widgets/glass_card.dart';
import 'package:flutter/material.dart';

class FarmayopinHeader extends StatelessWidget {
  final VoidCallback? onVolver;

  const FarmayopinHeader({
    super.key,
    this.onVolver,
  });

  @override
  Widget build(BuildContext context) {
    final header = GlassCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'farmayopin',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFDC0000),
              fontSize: 48,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'tu salud primero, siempre',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
    
    if(onVolver == null) {
      return header;
    }

    return GestureDetector(
      onTap: onVolver,
      child: header,
    );
  }
}
