// ...
import 'package:almacen/core/di/injection_container.dart' as di;
import 'package:almacen/features/inventory/presentation/cubit/inventory_cubit.dart';
import 'package:almacen/features/orders/presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/sales/presentation/cubit/sales_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const WarehouseApp());
}

// ... En el MultiBlocProvider de tu Widget WarehouseApp:
@override
Widget build(BuildContext context) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<InventoryCubit>(create: (_) => di.sl<InventoryCubit>()),
      BlocProvider<OrderCubit>(create: (_) => di.sl<OrderCubit>()),
      BlocProvider<SalesCubit>(create: (_) => di.sl<SalesCubit>()), // Inyectado
    ],
    child: MaterialApp(/*...*/),
  );
}
