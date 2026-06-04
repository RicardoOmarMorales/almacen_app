import '../../domain/entities/sale.dart';

abstract class SalesLocalDataSource {
  void recordSale(Sale sale);
  List<Sale> getSales();
}

class SalesLocalDataSourceImpl implements SalesLocalDataSource {
  // Historial de ventas en memoria
  final List<Sale> _sales = [];

  @override
  void recordSale(Sale sale) => _sales.add(sale);

  @override
  List<Sale> getSales() => _sales;
}
