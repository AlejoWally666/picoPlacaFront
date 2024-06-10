import 'package:pico_placa/pages/car/models/carModel.dart';

class ListCarResponseModel {
  bool? ok;
  List<CarModel>? data;
  String? message;

  ListCarResponseModel({this.ok, this.data, this.message});

  ListCarResponseModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['data'] != null) {
      data = <CarModel>[];
      json['data'].forEach((v) {
        data!.add(new CarModel.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

