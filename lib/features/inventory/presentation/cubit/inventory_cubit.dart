import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/inventory_repository.dart';

class InventoryState {
  final List<Product> products;
  InventoryState({required this.products});
}

class InventoryCubit extends Cubit<InventoryState> {
  final InventoryRepository repository;

  InventoryCubit({required this.repository})
    : super(InventoryState(products: repository.getProducts()));

  List<Product> getProductsByCategory(ProductCategory category) {
    return state.products.where((p) => p.category == category).toList();
  }

  void addProduct(Product product) {
    repository.addProduct(product);
    emit(InventoryState(products: List.from(repository.getProducts())));
  }

  void updateStock(String productId, int newStock) {
    repository.updateStock(productId, newStock);
    emit(InventoryState(products: List.from(repository.getProducts())));
  }
}
