import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../inventory/domain/entities/product.dart';
import '../../domain/entities/sale.dart';
import '../../domain/repositories/sales_repository.dart';

class SalesState {
  final List<Sale> sales;
  SalesState({required this.sales});
}

class SalesCubit extends Cubit<SalesState> {
  final SalesRepository repository;

  SalesCubit({required this.repository}) : super(SalesState(sales: []));

  // Registrar nueva venta
  void recordProductSale(Product product, int quantity) {
    final sale = Sale(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      productId: product.id,
      productName: product.name,
      quantity: quantity,
      totalPrice: product.price * quantity,
      date: DateTime.now(),
    );

    repository.recordSale(sale);
    emit(SalesState(sales: List.from(repository.getSales())));
  }

  // Filtrar ventas del día de hoy
  List<Sale> get dailySales {
    final now = DateTime.now();
    return state.sales.where((sale) {
      return sale.date.year == now.year &&
          sale.date.month == now.month &&
          sale.date.day == now.day;
    }).toList();
  }

  // Filtrar ventas del mes actual
  List<Sale> get monthlySales {
    final now = DateTime.now();
    return state.sales.where((sale) {
      return sale.date.year == now.year && sale.date.month == now.month;
    }).toList();
  }

  // Calcular ganancias totales de una lista de ventas
  double calculateTotalRevenue(List<Sale> salesList) {
    return salesList.fold(0.0, (sum, sale) => sum + sale.totalPrice);
  }
}
