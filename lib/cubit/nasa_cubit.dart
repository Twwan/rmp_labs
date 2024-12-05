import 'package:rmp_lab/cubit/nasa_state.dart';
import 'package:rmp_lab/models/nasa.dart';
import 'package:rmp_lab/requests/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NasaCubit extends Cubit<NasaState> {
  NasaCubit() : super(NasaLoadingState());

  Future<void> loadData() async {
    try {
      Map<String, dynamic> apiData = await getNasaData();
      Nasa nasaData = Nasa.fromJson(apiData);
      emit(NasaLoadedState(data: nasaData));
      return;
    } catch (e) {
      emit(NasaErrorState());
      return;
    }
  }
}