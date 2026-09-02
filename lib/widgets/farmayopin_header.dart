import 'package:flutter/material.dart';

class FarmayopinHeader extends StatelessWidget implements PreferredSizeWidget {
  const FarmayopinHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(121);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 121,
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'farmayopin',
            style: TextStyle(
              color: const Color(0xFFDC0000),
              fontSize: 48,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),

          Text(
            'tu salud primero, siempre',
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
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
