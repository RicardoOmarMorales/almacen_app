import 'package:almacen/features/inventory/data/datasources/inventory_local_datasource.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/inventory_repository.dart';
//import '../datasources/inventory_local_datasource.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryLocalDataSource dataSource;

  InventoryRepositoryImpl({required this.dataSource});

  @override
  List<Product> getProducts() => dataSource.getProducts();

  @override
  void addProduct(Product product) => dataSource.addProduct(product);

  @override
  void updateStock(String productId, int newStock) =>
      dataSource.updateStock(productId, newStock);
}
