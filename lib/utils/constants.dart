import 'package:flutter/material.dart';
import 'package:pico_placa/pages/car/models/carModel.dart';

class AppColors {
  static const Color mainBlue = Color(0xFF0A2AC1);
  static const Color mainDarkCyan = Color(0xFF0292B7);
  static const Color mainDarkBlue = Color(0xFF09596D);
  static const Color mainGreen = Color(0xFF1B5E20);
  static const Color mainLightGreen = Color(0xFF099f37);
  static const Color mainGrey = Color(0xFF7B7B7D);
  static const Color mainAmbar = Color(0xFFF1C300);
  static const Color mainRed = Color(0xFFED1C24);
  static const Color mainOrange = Color(0xFFEB6900);
}

class CarsData1 {
static List<CarModel> CarsDataList =[
  CarModel.fromJson({
    "id": 1,
    "placa": "ABC-1234",
    "color": "0013FF",
    "modelo": "Chevrolet Sail",
    "chasis": "31sdfsdsdf"
  }),
  CarModel.fromJson({
    "id": 2,
    "placa": "PDF-1245",
    "color": "01FF21",
    "modelo": "Hyundai i10",
    "chasis": "31sdfsdsdf"
  }),
  CarModel.fromJson({
    "id": 3,
    "placa": "TBH-0231",
    "color": "FF3921",
    "modelo": "Ford Explorer",
    "chasis": "31sdfsdsdf"
  }),
];
}