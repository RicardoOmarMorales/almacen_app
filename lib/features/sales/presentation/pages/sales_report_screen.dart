import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/sales_cubit.dart';
import '../../domain/entities/sale.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro de Ventas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ventas Diarias', icon: Icon(Icons.today)),
              Tab(text: 'Ventas Mensuales', icon: Icon(Icons.calendar_month)),
            ],
          ),
        ),
        body: BlocBuilder<SalesCubit, SalesState>(
          builder: (context, state) {
            final cubit = context.read<SalesCubit>();

            return TabBarView(
              children: [
                _SalesListReport(
                  sales: cubit.dailySales,
                  totalRevenue: cubit.calculateTotalRevenue(cubit.dailySales),
                  title: 'Hoy',
                ),
                _SalesListReport(
                  sales: cubit.monthlySales,
                  totalRevenue: cubit.calculateTotalRevenue(cubit.monthlySales),
                  title: 'Este Mes',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SalesListReport extends StatelessWidget {
  final List<Sale> sales;
  final double totalRevenue;
  final String title;

  const _SalesListReport({
    required this.sales,
    required this.totalRevenue,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (sales.isEmpty) {
      return Center(child: Text('No hay registros de ventas para $title.'));
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green.shade50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Recaudado ($title):',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalRevenue.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sales.length,
            itemBuilder: (context, index) {
              final sale = sales[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
                  title: Text(
                    sale.productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Cant: ${sale.quantity} u. • ${sale.date.hour}:${sale.date.minute.toString().padLeft(2, '0')} hs',
                  ),
                  trailing: Text(
                    '\$${sale.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
