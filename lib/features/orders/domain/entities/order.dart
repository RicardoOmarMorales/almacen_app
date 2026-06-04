class Order {
  final String id;
  final DateTime date;
  final String providerName;
  final String transcribedText;
  final String pdfPath;

  Order({
    required this.id,
    required this.date,
    required this.providerName,
    required this.transcribedText,
    required this.pdfPath,
  });
}
