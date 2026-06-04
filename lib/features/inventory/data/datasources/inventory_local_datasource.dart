import '../../domain/entities/product.dart';

abstract class InventoryLocalDataSource {
  List<Product> getProducts();
  void addProduct(Product product);
  void updateStock(String productId, int newStock);
}

class InventoryLocalDataSourceImpl implements InventoryLocalDataSource {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Coca Cola 2L',
      category: ProductCategory.bebidas,
      price: 1500.0,
      stock: 24,
    ),
    Product(
      id: '2',
      name: 'Papa blanca (Kg)',
      category: ProductCategory.verduras,
      price: 800.0,
      stock: 50,
    ),
    Product(
      id: '3',
      name: 'Pan Felipe (Kg)',
      category: ProductCategory.panificados,
      price: 1200.0,
      stock: 10,
    ),
    Product(
      id: '4',
      name: 'Lavandina Ayudin 1L',
      category: ProductCategory.limpieza,
      price: 950.0,
      stock: 15,
    ),
    Product(
      id: '5',
      name: 'Marlboro Box 20',
      category: ProductCategory.cigarrillos,
      price: 2100.0,
      stock: 30,
    ),
    Product(
      id: '6',
      name: 'Jamón Cocido (100g)',
      category: ProductCategory.fiambres,
      price: 700.0,
      stock: 50,
    ),
    Product(
      id: '7',
      name: 'Fideos Lucchetti',
      category: ProductCategory.almacen,
      price: 650.0,
      stock: 40,
    ),
  ];

  @override
  List<Product> getProducts() => _products;

  @override
  void addProduct(Product product) => _products.add(product);

  @override
  void updateStock(String productId, int newStock) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) _products[index].stock = newStock;
  }
}
