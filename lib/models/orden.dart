import 'package:farmayopin/models/item.dart';

class Orden {
  final String id;
  final DateTime fechaCompletada;
  final double importeTotal;
  List<Item> misItems;

  Orden({
    required this.id,
    required this.fechaCompletada,
    required this.importeTotal,
    List<Item>? misItems, // Permitimos que sea nulo en el constructor para manejarlo limpiamente
  }) : misItems =
           misItems ?? []; // Si es nulo, se inicializa como una lista vacía

  void addItem(Item item) {
    misItems.add(item);
  }
}
