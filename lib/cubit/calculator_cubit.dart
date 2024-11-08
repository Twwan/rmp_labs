import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmp_lab/db_provider.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorStateInit());

  final TextEditingController samplingRateController = TextEditingController();
  final TextEditingController bitDepthController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  String fileType = 'MP3';
  int channels = 1;
  bool agreement = false;

  void updateChannels(String? newValue) {
    fileType = newValue!;
    switch (fileType) {
      case 'AAC':
        channels = 4;
        break;
      case 'WAV':
        channels = 2;
        break;
      case 'FLAC':
        channels = 2;
        break;
      default:
        channels = 1;
    }
    emit(CalculatorStateInit());
  }

  void updateAgreement(bool? value) {
    agreement = value ?? false;
    emit(CheckboxState(agreement: agreement));
  }

  void resetForm() {
    emit(CalculatorStateInit());
  }

  void calculateFileSize() {
    if (!agreement) {
      emit(CalculatorErrorState(message: 'Пожалуйста, дайте согласие на обработку данных'));
      return;
    }

    if (samplingRateController.text.isEmpty || bitDepthController.text.isEmpty || durationController.text.isEmpty) {
      emit(CalculatorErrorState(message: 'Все поля должны быть заполнены'));
      return;
    }

    final double samplingRate = double.parse(samplingRateController.text);
    final double bitDepth = double.parse(bitDepthController.text);
    final double duration = double.parse(durationController.text);
    double fileSize = (channels * samplingRate * bitDepth * duration) / 8 / 1024 / 1024;

    DBProvider.db.addValues({
      'fileType': fileType,
      'channels': channels.toString(),
      'samplingRate': samplingRateController.text,
      'bitDepth': bitDepthController.text,
      'duration': durationController.text,
      'fileSize': fileSize,
    });

    emit(CalculatorFileSizeState(fileSize: fileSize));
  }
}
