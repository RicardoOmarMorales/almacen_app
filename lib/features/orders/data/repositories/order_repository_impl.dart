import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<bool> initializeAudio() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<String> listenAndTranscribe() async {
    await Future.delayed(const Duration(seconds: 3));
    return "Hola proveedor, necesito 5 cajones de Coca Cola, 10 kilos de papas, 5 kilos de tomates y 10 paquetes de pan lactal. Gracias.";
  }

  @override
  Future<String> generatePdfFromText(String text, String providerName) async {
    await Future.delayed(const Duration(seconds: 2));
    final date = DateTime.now();
    return "/storage/emulated/0/Documents/Pedido_${providerName}_${date.day}_${date.month}.pdf";
  }

  @override
  Future<void> shareFile(String path) async {
    await Future.delayed(const Duration(milliseconds: 500));
    print("Compartiendo archivo profesionalmente desde Clean Arch: $path");
  }
}
