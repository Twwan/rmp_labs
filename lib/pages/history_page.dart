import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmp_lab/cubit/history_cubit.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryScreenCubit()..loadResults(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('История расчетов'),
        ),
        body: BlocBuilder<HistoryScreenCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryScreenLoaded) {
              if (state.results.isEmpty) {
                return const Center(child: Text('История расчетов пуста :)'));
              }
              return ListView.builder(
                itemCount: state.results.length,
                itemBuilder: (context, index) {
                  final result = state.results[state.results.length - 1 - index];

                  return Column(
                    children: [
                      ListTile(
                        subtitle: Text('Тип файла: ${result['fileType']}\n'
                            'Каналы: ${result['channels']}\n'
                            'Частота дискретизации: ${result['samplingRate']} Гц\n'
                            'Глубина кодирования: ${result['bitDepth']} бит\n'
                            'Длительность: ${result['duration']} секунд\n'
                            'Размер файла: ${result['fileSize'].toStringAsFixed(2)} МБ'),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
