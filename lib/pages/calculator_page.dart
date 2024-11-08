import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmp_lab/cubit/calculator_cubit.dart';
import 'package:rmp_lab/pages/history_page.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Неборский Мирон Евгеньевич'),
          leading: IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CalculatorCubit, CalculatorState>(
            builder: (context, state) {
              final cubit = context.read<CalculatorCubit>();

              if (state is CalculatorFileSizeState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Размер файла: ${state.fileSize.toStringAsFixed(2)} МБ', style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          cubit.resetForm();
                        },
                        child: const Text('Назад'),
                      ),
                    ],
                  ),
                );
              }

              return Form(
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: cubit.fileType,
                      decoration: const InputDecoration(labelText: 'Тип файла'),
                      items: ['MP3', 'WAV', 'FLAC', 'AAC'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        cubit.updateChannels(newValue);
                      },
                    ),
                    TextFormField(
                      controller: cubit.samplingRateController,
                      decoration: const InputDecoration(labelText: 'Частота дискретизации (Гц)'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(
                          RegExp(r'^0+'),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: cubit.bitDepthController,
                      decoration: const InputDecoration(labelText: 'Глубина кодирования (бит)'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(
                          RegExp(r'^0+'),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: cubit.durationController,
                      decoration: const InputDecoration(labelText: 'Длительность (секунды)'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(
                          RegExp(r'^0+'),
                        ),
                      ],
                    ),
                    BlocBuilder<CalculatorCubit, CalculatorState>(
                      builder: (context, checkboxState) {
                        return CheckboxListTile(
                          title: const Text('Даю согласие на обработку данных'),
                          contentPadding: EdgeInsets.zero,
                          value: (checkboxState is CheckboxState) ? checkboxState.agreement : cubit.agreement,
                          onChanged: (newValue) {
                            cubit.updateAgreement(newValue);
                          },
                        );
                      },
                    ),
                    if (state is CalculatorErrorState)
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ElevatedButton(
                      onPressed: () => cubit.calculateFileSize(),
                      child: const Text('Рассчитать'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
