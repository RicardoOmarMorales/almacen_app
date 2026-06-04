import 'package:almacen/features/sales/presentation/cubit/sales_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../cubit/inventory_cubit.dart';

class CategoryList extends StatelessWidget {
  final ProductCategory category;
  const CategoryList({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        final cubit = context.read<InventoryCubit>();
        final products = cubit.getProductsByCategory(category);

        if (products.isEmpty) {
          return const Center(
            child: Text('No hay productos en esta categoría.'),
          );
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                title: Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Precio: \$${product.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Stock: ${product.stock}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.green,
                      ),
                      onPressed: product.stock > 0
                          ? () =>
                                _showSellProductDialog(context, product, cubit)
                          : null, // Deshabilitar si no hay stock
                    ),
                    IconButton(
        icon: const Icon(Icons.edit, color: Colors.blue),
        onPressed: () => _showEditStockDialog(context, product, cubit),
      ),
    ],
  ),
)

void _showSellProductDialog(BuildContext context, Product product, InventoryCubit inventoryCubit) {
  final TextEditingController controller = TextEditingController(text: '1');
  
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text('Registrar Venta: ${product.name}'),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Cantidad a vender (Máx: ${product.stock})',
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: () {
            final quantity = int.tryParse(controller.text) ?? 0;
            if (quantity > 0 && quantity <= product.stock) {
              // 1. Registramos la venta en el SalesCubit
              context.read<SalesCubit>().recordProductSale(product, quantity);
              
              // 2. Descontamos el Stock en el InventoryCubit
              inventoryCubit.updateStock(product.id, product.stock - quantity);
              
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Venta registrada con éxito')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cantidad inválida o superior al stock disponible')),
              );
            }
          },
          child: const Text('Confirmar Venta'),
        ),
      ],
    ),
  );
}