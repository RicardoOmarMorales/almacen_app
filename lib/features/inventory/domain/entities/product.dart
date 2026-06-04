enum ProductCategory {
  verduras,
  bebidas,
  cigarrillos,
  almacen,
  fiambres,
  panificados,
  limpieza,
}

class Product {
  final String id;
  final String name;
  final ProductCategory category;
  double price;
  int stock;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
  });
}
