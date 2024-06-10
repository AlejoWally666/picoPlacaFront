

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pico_placa/pages/car/cubit/cartFormCubit.dart';
import 'package:pico_placa/pages/car/cubit/checkPicoPlacaCubit.dart';
import 'package:pico_placa/pages/car/models/CarResponseModel.dart';
import 'package:pico_placa/pages/car/models/carListResponseModel.dart';
import 'package:pico_placa/pages/car/models/picoPlacaResponseModel.dart';
import 'package:pico_placa/pages/home/cubit/homePageCubit.dart';
import 'package:pico_placa/services/apiRest/apiRequest.dart';
import 'package:pico_placa/services/apiRest/apiUrls.dart';
import 'package:pico_placa/utils/globals.dart';
import 'package:pico_placa/widgets/awesomeDialogWidget.dart';
import 'package:http/http.dart' as http;
import 'package:pico_placa/widgets/textFormats.dart';

class CarController{

  static Future<void> saveCar(BuildContext context,BuildContext contextHome, String selectedColor, String placaText,String modelText,chasisText) async {
    FocusScope.of(context).unfocus();

    http.Response? response =
    await ApiRequest.post(ApiUrl.getVehiculoUrl(), {
      "placa": placaText,
      "color": selectedColor,
      "modelo": modelText,
      "chasis": chasisText
    });
    CarResponseModel? carRes = null;
    try {
      if (response != null) {
        carRes = CarResponseModel.fromJson(
            jsonDecode(response.body));
        if (carRes.ok == true) {
          if (carRes.data?.id != null) {
            Navigator.of(context).pop();
            showOkDialog(contextHome, "Registro Exitoso",
                "${carRes.message}");
            Globals.restart=true;
            Globals.listCars=[];
            await contextHome.read<HomePageCubit>().loadCarList(contextHome);
            return;
          } else {
            showErrorDialog(
                context,
                "Error",
                carRes.message ??
                    "No se ha registrdo el vehículo");
          }
        } else {
          showErrorDialog(
              context,
              "Error",
              carRes.message ??
                  "No se ha registrdo el vehículo");
        }
      } else {
        showErrorDialog(context, "Error",
            "No se ha registrdo el vehículo");
      }
    } catch (error, stackTrace) {
      showErrorDialog(context, "Error",
          "No se ha registrdo el vehículo");
    }

    context.read<CarFormCubit>().changeLoading(false);
    return;
  }
  static Future<void> updateCar(BuildContext context,BuildContext contextHome, String selectedColor, String placaText,String modelText,chasisText,int idCar) async {
    FocusScope.of(context).unfocus();

    http.Response? response =
    await ApiRequest.put(ApiUrl.updateVehiculoUrl(idCar), {
      "placa": placaText,
      "color": selectedColor,
      "modelo": modelText,
      "chasis": chasisText
    });
    CarResponseModel? carRes = null;
    try {
      if (response != null) {
        carRes = CarResponseModel.fromJson(
            jsonDecode(response.body));
        if (carRes.ok == true) {
          if (carRes.data?.id != null) {
            Navigator.of(context).pop();

            showOkDialog(contextHome, "Datos actualizados con Éxito",
                "${carRes.message}");

            Globals.restart=true;
            Globals.listCars=[];
            await contextHome.read<HomePageCubit>().loadCarList(contextHome);
          } else {
            showErrorDialog(
                context,
                "Error",
                carRes.message ??
                    "No se ha actualizado los datos del vehículo");
          }
        } else {
          showErrorDialog(
              context,
              "Error",
              carRes.message ??
                  "No se ha registrdo el vehículo");
        }
      } else {
        showErrorDialog(context, "Error",
            "No se ha actualizado los datos del vehículo");
      }
    } catch (error, stackTrace) {
      showErrorDialog(context, "Error",
          "No se ha actualizado los datos del vehículo");
    }
    return;
  }
  static Future<void> deleteCar(BuildContext context,int idCar) async {
    FocusScope.of(context).unfocus();

    http.Response? response =
    await ApiRequest.delete(ApiUrl.updateVehiculoUrl(idCar),);
    CarResponseModel? carRes = null;
    try {
      if (response != null) {
        carRes = CarResponseModel.fromJson(
            jsonDecode(response.body));
        if (carRes.ok == true) {
          if (carRes.data?.id != null) {

            showOkDialog(context, "Eliminado con éxito",
                "${carRes.message}");

            Globals.restart=true;
            Globals.listCars=[];
            await context.read<HomePageCubit>().loadCarList(context);
          } else {
            showErrorDialog(
                context,
                "Error",
                carRes.message ??
                    "No se ha eliminado el vehículo");
          }
        } else {
          showErrorDialog(
              context,
              "Error",
              carRes.message ??
                  "No se ha eliminado el vehículo");
        }
      } else {
        showErrorDialog(context, "Error",
            "No se ha eliminado el vehículo");
      }
    } catch (error, stackTrace) {
      showErrorDialog(context, "Error",
          "No se ha eliminado el vehículo");
    }
    return;
  }

  static Future<void> checkPicoPlaca(BuildContext context,BuildContext contextHome,String placa,DateTime datetime) async {
    FocusScope.of(context).unfocus();

    http.Response? response =
    await ApiRequest.post(ApiUrl.checkPicoPlacaUrl(), {
      "placa": placa,
      "dia": datetime.weekday,
      "hora":horaMinString(datetime)
    });
    PicoPlacaResponseModel? picoPlacaRes = null;
    try {
      if (response != null) {
        picoPlacaRes = PicoPlacaResponseModel.fromJson(
            jsonDecode(response.body));
        if (picoPlacaRes.ok == true) {
          if (picoPlacaRes.data?.picoplaca == true) {
            //Manejar cuando si tiene pico y placa
            context.read<CheckPicoPlacaCubit>().changeResult(
                false);
          } else {
            //Manejar cuando no tiene pico y placa
            context.read<CheckPicoPlacaCubit>().changeResult(
                true);
          }
        } else {
          Navigator.of(context).pop();
          showErrorDialog(
              contextHome,
              "Error",
              picoPlacaRes.message ??
                  "No se pudo validar el pico y placa1");
        }
      } else {
        Navigator.of(context).pop();
        showErrorDialog(contextHome, "Error",
            "No se pudo validar el pico y placa2");
      }
    } catch (error, stackTrace) {
      print(stackTrace);
      Navigator.of(context).pop();
      showErrorDialog(contextHome, "Error",
          "No se pudo validar el pico y placa3");
    }
    return;
  }

  static Future<ListCarResponseModel> getCarList(BuildContext contextHome) async {
    FocusScope.of(contextHome).unfocus();

    http.Response? response =
    await ApiRequest.get(ApiUrl.getVehiculoUrl());
    ListCarResponseModel carListRes = ListCarResponseModel(ok: false);
    try {
      if (response != null) {
        print("${response.body}");
        carListRes = ListCarResponseModel.fromJson(
            jsonDecode(response.body));
        if (carListRes.ok == true) {
          if ((carListRes.data??[]).length != 0) {
            Globals.listCars=carListRes.data??[];
          } else {
            showErrorDialog(
                contextHome,
                "Error",
                carListRes.message ??
                    "No se ha registrdo el vehículo");
          }
        } else {
          showErrorDialog(
              contextHome,
              "Error",
              carListRes.message ??
                  "No se ha registrdo el vehículo");
        }
      } else {
        showErrorDialog(contextHome, "Error",
            "No se ha registrdo el vehículo");
      }
    } catch (error, stackTrace) {
      showErrorDialog(contextHome, "Error",
          "No se ha registrdo el vehículo");
    }
    return carListRes;
  }


}