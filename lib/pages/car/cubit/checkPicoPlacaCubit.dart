import 'package:bloc/bloc.dart';

// Definición del estado
class CheckPicoPlacaState {
  final bool? result;

  CheckPicoPlacaState(this.result);
}

// Definición del cubit
class CheckPicoPlacaCubit extends Cubit<CheckPicoPlacaState> {

  CheckPicoPlacaCubit() : super(CheckPicoPlacaState(null));

  void changeResult(bool status) => emit(CheckPicoPlacaState(status));

}