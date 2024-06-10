import 'dart:convert';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pico_placa/pages/car/controllers/carController.dart';
import 'package:pico_placa/pages/car/cubit/checkPicoPlacaCubit.dart';
import 'package:pico_placa/pages/car/models/carModel.dart';
import 'package:pico_placa/utils/constants.dart';

class CheckPicoPlaca extends StatelessWidget {
  CheckPicoPlaca({Key? key, required this.carModel, required this.contextHome, required this.datetime}) : super(key: key);

  final CarModel carModel;
  final BuildContext contextHome;
  final DateTime datetime;

  TextEditingController _modelText = TextEditingController();
  TextEditingController _placaText = TextEditingController();
  TextEditingController _chasisText = TextEditingController();

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  bool _inited=false;

// ValueChanged<Color> callback
  void changeColor(Color color) {
    pickerColor = color;
  }

  String? _validatePlacaInput(String? value) {
    final regex = RegExp(r'^[A-Za-z]{3}-\d{4}$');
    if (value == null || !regex.hasMatch(value)) {
      return 'Formato de placa inválido. Debe ser AAA-0123.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CheckPicoPlacaCubit(),
        child: BlocBuilder<CheckPicoPlacaCubit, CheckPicoPlacaState>(
            builder: (context, state)
            {
              if (!_inited) {
                _inited = true;
                CarController.checkPicoPlaca(context, contextHome, carModel.placa??"",datetime);
              }
              return Center(child:
                Column(
                  children: [
                    SizedBox(
                      width: 180,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Card(child: Padding(
                          padding: const EdgeInsets.only(left: 4.0,right: 4,top:2),
                          child: Column(
                            children: [
                              Text('ECUADOR',style: TextStyle(height: 1,fontWeight: FontWeight.bold,fontSize: 14),),
                              Text('${carModel.placa}',style: TextStyle(height: 2,fontWeight: FontWeight.bold,fontSize: 18),),
                            ],
                          ),
                        )),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: state.result!=false?12:76),
                      child: Lottie.asset("assets/lottie/${state.result==null?"loading":state.result==true?"okAnim":"stop"}.json"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        state.result==null?"Consulta Pico y Placa, por favor espere....":state.result==true?"Vehículo SÍ puede circular con normalidad":"Vehículo NO puede circular, por restricción de Pico y Placa",
                        textAlign: TextAlign.center,
                        style: TextStyle(

                            fontSize: 25, color: AppColors.mainDarkBlue),
                      ),
                    ),
                  ],
                )
                ,);
            }));
  }

}
