class CarModel {
  int? id;
  String? placa;
  String? color;
  String? model;
  String? chasis;

  CarModel({this.id, this.placa, this.color, this.model, this.chasis});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placa = json['placa'];
    color = json['color'];
    model = json['modelo'];
    chasis = json['chasis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['placa'] = this.placa;
    data['color'] = this.color;
    data['modelo'] = this.model;
    data['chasis'] = this.chasis;
    return data;
  }
}
