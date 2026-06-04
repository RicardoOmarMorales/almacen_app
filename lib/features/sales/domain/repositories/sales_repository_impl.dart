import 'package:almacen/features/sales/data/datasources/sales_local_datasource.dart';

import '../../domain/entities/sale.dart';
import '../../domain/repositories/sales_repository.dart';
//import '../data/datasources/sales_local_datasource.dart';

class SalesRepositoryImpl implements SalesRepository {
  final SalesLocalDataSource dataSource;

  SalesRepositoryImpl({required this.dataSource});

  @override
  void recordSale(Sale sale) => dataSource.recordSale(sale);

  @override
  List<Sale> getSales() => dataSource.getSales();
}
