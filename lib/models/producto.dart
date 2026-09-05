class Producto {
  final String id;
  final String nombre;
  final double precio;
  final int stock;
  final String? descripcion;
  final String imagen;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
    this.descripcion,
    required this.imagen,
  });
}
