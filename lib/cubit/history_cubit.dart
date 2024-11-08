import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmp_lab/db_provider.dart';

part 'history_state.dart';

class HistoryScreenCubit extends Cubit<HistoryState> {
  HistoryScreenCubit() : super(HistoryStateInit());

  void loadResults() async {
    final results = await DBProvider.db.getAllValues();
    emit(HistoryScreenLoaded(results));
  }
}
