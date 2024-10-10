import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int channels;
  final int samplingRate;
  final int bitDepth;
  final int duration;

  const ResultPage({
    super.key,
    required this.channels,
    required this.samplingRate,
    required this.bitDepth,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    double fileSize = (channels * samplingRate * bitDepth * duration) / 8 / 1024 / 1024;

    return Scaffold(
      appBar: AppBar(title: const Text('Результат расчета')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Text(
                'Число каналов: $channels',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Частота дискредетации: $samplingRate Гц',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Глубина кодирования: $bitDepth бит',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Длительность: $duration сек',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Объем файла: ${fileSize.toStringAsFixed(2)} МБ',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
