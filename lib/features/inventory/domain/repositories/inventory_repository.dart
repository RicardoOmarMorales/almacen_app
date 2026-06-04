import '../entities/product.dart';

abstract class InventoryRepository {
  List<Product> getProducts();
  void addProduct(Product product);
  void updateStock(String productId, int newStock);
}
