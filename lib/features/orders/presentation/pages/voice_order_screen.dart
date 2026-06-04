import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/order_cubit.dart';

class VoiceOrderScreen extends StatefulWidget {
  const VoiceOrderScreen({Key? key}) : super(key: key);

  @override
  State<VoiceOrderScreen> createState() => _VoiceOrderScreenState();
}

class _VoiceOrderScreenState extends State<VoiceOrderScreen> {
  final TextEditingController _providerController = TextEditingController();

  @override
  void dispose() {
    _providerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedido a Proveedor (Voz)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            final orderCubit = context.read<OrderCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _providerController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Proveedor',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_providerController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, ingrese el nombre del proveedor primero.',
                            ),
                          ),
                        );
                        return;
                      }
                      if (!state.isRecording) {
                        orderCubit.startVoiceOrder(_providerController.text);
                      }
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: state.isRecording
                            ? Colors.red.shade100
                            : Colors.green.shade100,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        state.isRecording ? Icons.mic : Icons.mic_none,
                        size: 60,
                        color: state.isRecording ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    state.isRecording
                        ? 'Grabando...'
                        : 'Toque para grabar pedido',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade50,
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        state.currentTranscription.isEmpty
                            ? 'La transcripción aparecerá aquí...'
                            : state.currentTranscription,
                        style: TextStyle(
                          fontSize: 16,
                          color: state.currentTranscription.isEmpty
                              ? Colors.grey
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (state.currentTranscription.isNotEmpty && !state.isRecording)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => orderCubit.clearTranscription(),
                          child: const Text('Descartar'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state.isProcessing
                              ? null
                              : () {
                                  orderCubit.processAndSaveOrder(
                                    _providerController.text,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Pedido procesado y PDF generado.',
                                      ),
                                    ),
                                  );
                                  _providerController.clear();
                                },
                          child: state.isProcessing
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Generar PDF y Guardar'),
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
