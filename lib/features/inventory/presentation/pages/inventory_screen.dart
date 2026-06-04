import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../widgets/category_list.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  String _getCategoryName(ProductCategory category) {
    switch (category) {
      case ProductCategory.verduras:
        return 'Verduras';
      case ProductCategory.bebidas:
        return 'Bebidas';
      case ProductCategory.cigarrillos:
        return 'Cigarrillos';
      case ProductCategory.almacen:
        return 'Almacén';
      case ProductCategory.fiambres:
        return 'Fiambres';
      case ProductCategory.panificados:
        return 'Panificados';
      case ProductCategory.limpieza:
        return 'Limpieza';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ProductCategory.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inventario del Local'),
          bottom: TabBar(
            isScrollable: true,
            tabs: ProductCategory.values
                .map((cat) => Tab(text: _getCategoryName(cat)))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: ProductCategory.values
              .map((cat) => CategoryList(category: cat))
              .toList(),
        ),
      ),
    );
  }
}
