import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerField extends StatelessWidget {
  final File? imagen;
  final VoidCallback onSeleccionar;

  const ImagePickerField({
    super.key,
    required this.imagen,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Imagen',
          style: TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 8),

        GestureDetector(
          onTap: onSeleccionar,
          child: Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD9D9D9)),
            ),
            child: imagen != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(imagen!, fit: BoxFit.contain),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: Color(0xFF777777),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Seleccionar imagen',
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
