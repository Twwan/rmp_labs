part of 'history_cubit.dart';

abstract class HistoryState {}

class HistoryStateInit extends HistoryState {}

class HistoryScreenLoaded extends HistoryState {
  final List<Map<String, dynamic>> results;

  HistoryScreenLoaded(this.results);
}
