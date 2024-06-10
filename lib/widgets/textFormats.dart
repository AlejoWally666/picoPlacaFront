

import 'package:flutter/material.dart';
Widget buildTextTitulo(String titulo) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Text(titulo,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.indigo)),
  );
}
Widget buildLabel(String  text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey)),
  );
}

String maskString(String str) {
  if (str.length <= 2) {
    return str;
  }
  String firstChar = str.substring(0, 1);
  String lastChar = str.substring(str.length - 1);
  String maskedPart = '*' * (str.length - 2);
  return '$firstChar$maskedPart$lastChar';
}
String fechaString(DateTime newDateTime) {
  String mes, dia;
  if (newDateTime.month < 10) {
    mes = "0${newDateTime.month.toString()}";
  } else {
    mes = "${newDateTime.month.toString()}";
  }
  if (newDateTime.day < 10) {
    dia = "0${newDateTime.day.toString()}";
  } else {
    dia = "${newDateTime.day.toString()}";
  }
  return "${newDateTime.year}-$mes-$dia";
}
String horaMinString(DateTime newDateTime) {
  String hora, minuto;
  if (newDateTime.hour < 10) {
    hora = "0${newDateTime.hour.toString()}";
  } else {
    hora = "${newDateTime.hour.toString()}";
  }
  if (newDateTime.minute < 10) {
    minuto = "0${newDateTime.minute.toString()}";
  } else {
    minuto = "${newDateTime.minute.toString()}";
  }
  return "$hora:$minuto";
}

Color hexToColor(String hexString) {

  hexString = hexString.replaceAll('#', '');


  hexString = '0xFF' + hexString;


  return Color(int.parse(hexString));
}