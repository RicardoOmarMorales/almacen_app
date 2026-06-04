import '../entities/order.dart';

abstract class OrderRepository {
  Future<bool> initializeAudio();
  Future<String> listenAndTranscribe();
  Future<String> generatePdfFromText(String text, String providerName);
  Future<void> shareFile(String path);
}
