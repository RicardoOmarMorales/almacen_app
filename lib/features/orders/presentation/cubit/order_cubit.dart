import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

class OrderState {
  final List<Order> orders;
  final bool isRecording;
  final bool isProcessing;
  final String currentTranscription;

  OrderState({
    required this.orders,
    required this.isRecording,
    required this.isProcessing,
    required this.currentTranscription,
  });

  OrderState copyWith({
    List<Order>? orders,
    bool? isRecording,
    bool? isProcessing,
    String? currentTranscription,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      isRecording: isRecording ?? this.isRecording,
      isProcessing: isProcessing ?? this.isProcessing,
      currentTranscription: currentTranscription ?? this.currentTranscription,
    );
  }
}

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository repository;

  OrderCubit({required this.repository})
    : super(
        OrderState(
          orders: [],
          isRecording: false,
          isProcessing: false,
          currentTranscription: "",
        ),
      );

  Future<void> startVoiceOrder(String providerName) async {
    emit(
      state.copyWith(isRecording: true, currentTranscription: "Escuchando..."),
    );
    await repository.initializeAudio();
    await Future.delayed(const Duration(seconds: 2));

    final transcription = await repository.listenAndTranscribe();
    emit(
      state.copyWith(isRecording: false, currentTranscription: transcription),
    );
  }

  Future<void> processAndSaveOrder(String providerName) async {
    if (state.currentTranscription.isEmpty ||
        state.currentTranscription == "Escuchando...")
      return;

    emit(state.copyWith(isProcessing: true));

    final pdfPath = await repository.generatePdfFromText(
      state.currentTranscription,
      providerName,
    );

    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      providerName: providerName,
      transcribedText: state.currentTranscription,
      pdfPath: pdfPath,
    );

    final updatedOrders = List<Order>.from(state.orders)..insert(0, newOrder);

    emit(
      state.copyWith(
        orders: updatedOrders,
        currentTranscription: "",
        isProcessing: false,
      ),
    );
  }

  void clearTranscription() {
    emit(state.copyWith(currentTranscription: ""));
  }

  Future<void> shareOrderPdf(String path) async {
    await repository.shareFile(path);
  }
}
