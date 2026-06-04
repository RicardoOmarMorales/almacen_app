// ... (Tus imports previos)
// ... (Tus imports previos)
import 'package:almacen/features/inventory/data/datasources/inventory_local_datasource.dart';
import 'package:almacen/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:almacen/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:almacen/features/inventory/presentation/cubit/inventory_cubit.dart';
import 'package:almacen/features/orders/data/repositories/order_repository_impl.dart';
import 'package:almacen/features/orders/domain/repositories/order_repository.dart';
import 'package:almacen/features/orders/presentation/cubit/order_cubit.dart';
import 'package:almacen/features/sales/domain/repositories/sales_repository_impl.dart';
import 'package:get_it/get_it.dart';

import '../../features/sales/data/datasources/sales_local_datasource.dart';
//import '../../features/sales/data/repositories/sales_repository_impl.dart';
import '../../features/sales/domain/repositories/sales_repository.dart';
import '../../features/sales/presentation/cubit/sales_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! FEATURES - INVENTORY
  sl.registerFactory(() => InventoryCubit(repository: sl()));
  sl.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<InventoryLocalDataSource>(
    () => InventoryLocalDataSourceImpl(),
  );

  //! FEATURES - ORDERS
  sl.registerFactory(() => OrderCubit(repository: sl()));
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());

  //! FEATURES - SALES (NUEVO)
  sl.registerFactory(() => SalesCubit(repository: sl()));
  sl.registerLazySingleton<SalesRepository>(
    () => SalesRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<SalesLocalDataSource>(
    () => SalesLocalDataSourceImpl(),
  );
}
