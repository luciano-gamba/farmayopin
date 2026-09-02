// lib/widgets/farmayopin_header.dart
import 'package:farmayopin/widgets/glass_card.dart';
import 'package:flutter/material.dart';

class FarmayopinHeader extends StatelessWidget {
  const FarmayopinHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
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
  }
}
