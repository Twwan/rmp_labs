part of 'calculator_cubit.dart';

abstract class CalculatorState {}

class CalculatorStateInit extends CalculatorState {}

class CalculatorFileSizeState extends CalculatorState {
  final double fileSize;

  CalculatorFileSizeState({required this.fileSize});
}

class CalculatorErrorState extends CalculatorState {
  final String message;

  CalculatorErrorState({required this.message});
}

class CheckboxState extends CalculatorState {
  final bool agreement;

  CheckboxState({required this.agreement});
}
