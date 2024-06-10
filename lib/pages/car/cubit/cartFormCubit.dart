import 'package:bloc/bloc.dart';

// Definición del estado
class CarFormState {
  final bool loading;
  final String selectedColor;

  CarFormState(this.loading, this.selectedColor);
}

// Definición del cubit
class CarFormCubit extends Cubit<CarFormState> {

  CarFormCubit() : super(CarFormState(false,"5C6BC0"));

  void changeLoading(bool status) => emit(CarFormState(status,state.selectedColor));
  void changeColor(String selectedColor) => emit(CarFormState(state.loading,selectedColor));

}