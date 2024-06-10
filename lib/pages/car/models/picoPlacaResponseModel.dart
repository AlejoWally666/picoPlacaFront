class PicoPlacaResponseModel {
  bool? ok;
  Data? data;
  String? message;

  PicoPlacaResponseModel({this.ok, this.data, this.message});

  PicoPlacaResponseModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  bool? picoplaca;

  Data({this.picoplaca});

  Data.fromJson(Map<String, dynamic> json) {
    picoplaca = json['picoplaca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picoplaca'] = this.picoplaca;
    return data;
  }
}
