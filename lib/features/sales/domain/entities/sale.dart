class Sale {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double totalPrice;
  final DateTime date;

  Sale({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.date,
  });
}
