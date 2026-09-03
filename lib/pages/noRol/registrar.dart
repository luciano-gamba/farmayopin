import 'package:farmayopin/widgets/farmayopin_header.dart';
import 'package:farmayopin/widgets/formregister.dart';
import 'package:farmayopin/widgets/main_layout.dart';
import 'package:flutter/material.dart';

class Registrar extends StatelessWidget {
  const Registrar({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          FarmayopinHeader(),
          SizedBox(height: 20),
          FormRegister(),
        ],
      ),
    );
  }
}
