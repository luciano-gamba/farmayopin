import 'package:farmayopin/widgets/farmayopin_header.dart';
import 'package:farmayopin/widgets/formlogin.dart';
import 'package:farmayopin/widgets/main_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [FarmayopinHeader(), SizedBox(height: 20), FormLogIn()],
      ),
    );
  }
}
