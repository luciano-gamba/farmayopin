import 'package:farmayopin/models/item.dart';
import 'package:flutter/material.dart';

class ItemHistory extends StatelessWidget {
  final Item item;
  final bool expandido;
  final VoidCallback onTap;

  const ItemHistory({
    super.key,
    required this.item,
    required this.expandido,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final total = item.precio * item.cantidad;

    return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.80),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8),
              child: Row(
                children: [
                Expanded(
                  child: Text(
                     '${item.fechaCompletada.day}'
                    '/${item.fechaCompletada.month}/'
                    '${item.fechaCompletada.year} - '
                    '${item.fechaCompletada.hour}:'
                    '${item.fechaCompletada.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  expandido
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20,
                ),
              ],
            ),
            ),

            if (expandido) ...[
              const SizedBox(height: 12),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Email: ',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    TextSpan(text: item.emailUsuario,
                    style: TextStyle(fontSize: 20),
                  ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Precio unitario: ',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    TextSpan(text: '\$${item.precio.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                  ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Cantidad: ',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    TextSpan(text: 'x${item.cantidad}',
                    style: TextStyle(fontSize: 20),
                  ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 248, 248),
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
    );
  }
}
