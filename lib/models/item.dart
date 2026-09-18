class Item {
  final String idProducto;
  final String idOrden;
  final String nombreProducto;
  final double precio;
  final int cantidad;
  final String emailUsuario;
  final DateTime fechaCompletada;

  Item({
    required this.idProducto,
    required this.idOrden,
    required this.nombreProducto,
    required this.precio,
    required this.cantidad,
    required this.emailUsuario,
    required this.fechaCompletada,
  });
}
