import '../entities/sale.dart';

abstract class SalesRepository {
  void recordSale(Sale sale);
  List<Sale> getSales();
}
