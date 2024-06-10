import 'package:pico_placa/pages/car/models/carModel.dart';

class CarResponseModel {
  bool? ok;
  CarModel? data;
  String? message;

  CarResponseModel({this.ok, this.data, this.message});

  CarResponseModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    data = json['data'] != null ? new CarModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

