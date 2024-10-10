import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'result_page.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  CalculatorPageState createState() => CalculatorPageState();
}

class CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _samplingRateController = TextEditingController();
  final TextEditingController _bitDepthController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  bool _agreement = false;

  String _fileType = 'MP3';
  int _channels = 1;

  void _updateChannels(String? fileType) {
    switch (fileType) {
      case 'AAC':
        _channels = 4;
        break;
      case 'WAV':
        _channels = 2;
        break;
      case 'FLAC':
        _channels = 2;
        break;
      default:
        _channels = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Неборский Мирон Евгеньевич')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _fileType,
                decoration: const InputDecoration(labelText: 'Тип файла'),
                items: ['MP3', 'WAV', 'FLAC', 'AAC'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _fileType = newValue!;
                    _updateChannels(_fileType);
                  });
                },
              ),
              TextFormField(
                controller: _samplingRateController,
                decoration: const InputDecoration(labelText: 'Частота дискретизации (Гц)'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(
                    RegExp(r'^0+'),
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите частоту';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bitDepthController,
                decoration: const InputDecoration(labelText: 'Глубина кодирования (бит)'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(
                    RegExp(r'^0+'),
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите глубину кодирования';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Длительность (секунды)'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(
                    RegExp(r'^0+'),
                  ),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Пожалуйста, введите длительность';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: const Text('Даю согласие на обработку данных'),
                contentPadding: EdgeInsets.zero,
                value: _agreement,
                onChanged: (newValue) {
                  setState(() {
                    _agreement = newValue!;
                  });
                },
              ),
              if (!_agreement)
                const Text(
                  'Пожалуйста, дайте согласие на обработку данных',
                  style: TextStyle(color: Colors.red),
                ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _agreement) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          channels: _channels,
                          samplingRate: int.parse(_samplingRateController.text),
                          bitDepth: int.parse(_bitDepthController.text),
                          duration: int.parse(_durationController.text),
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
