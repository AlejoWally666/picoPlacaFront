import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pico_placa/pages/car/controllers/carController.dart';
import 'package:pico_placa/pages/car/models/carListResponseModel.dart';
import 'package:pico_placa/pages/home/homePage.dart';
import 'package:pico_placa/utils/globals.dart';
import 'dart:html' as html;

// Definición del estado
class HomePageState {
  final bool loading;
  final DateTime dateTimeSelected;
  final ListCarResponseModel? listCars;

  final bool showTable;

  HomePageState(this.loading,this.dateTimeSelected,this.listCars,this.showTable);
}

// Definición del cubit
class HomePageCubit extends Cubit<HomePageState> {

  HomePageCubit() : super(HomePageState(true,DateTime.now(),ListCarResponseModel(ok: false,data: []),false));

  void changeLoading(status) => emit(HomePageState(status,state.dateTimeSelected,state.listCars,state.showTable));

  void changeDateTime(DateTime dateTime) => emit(HomePageState(state.loading,dateTime,state.listCars,state.showTable));

  Future<void> loadCarList(BuildContext context) async {
    emit(HomePageState(true,state.dateTimeSelected,state.listCars,false));
    ListCarResponseModel listCars = await CarController.getCarList(context);
    Globals.listCars=listCars?.data??[];
    print("Globals.listCars::${Globals.listCars.length}");

      emit(HomePageState(false,state.dateTimeSelected,listCars,true));
      if(Globals.restart){
        reloadPage();
          Globals.restart=false;
return;
      }else{

        emit(HomePageState(false,state.dateTimeSelected,state.listCars,state.showTable));
      }

    Future.delayed(Duration(milliseconds: 600), () async {
      //reloadPage();

      emit(HomePageState(false,state.dateTimeSelected,state.listCars,true));
      Globals.restart=false;
    });
  }



  void reloadPage() {
    html.window.location.reload();
  }

}