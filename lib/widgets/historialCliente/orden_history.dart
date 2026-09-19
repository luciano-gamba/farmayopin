import 'package:farmayopin/models/orden.dart';
import 'package:flutter/material.dart';

class OrdenHistory extends StatelessWidget {
  final Orden orden;
  final bool expandido;
  final VoidCallback onTap;

  const OrdenHistory({
    super.key,
    required this.orden,
    required this.expandido,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    '${orden.fechaCompletada.day}'
                    '/${orden.fechaCompletada.month}/'
                    '${orden.fechaCompletada.year} - '
                    '${orden.fechaCompletada.hour}:'
                    '${orden.fechaCompletada.minute.toString().padLeft(2, '0')}',
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
          Divider(),
          if (expandido) ...[
            ...orden.misItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Text(
                      item.nombreProducto,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      ': \$${item.precio} (x${item.cantidad})',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }),
            //const SizedBox(height: 8),

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
                  '\$${orden.importeTotal.toStringAsFixed(2)}',
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
