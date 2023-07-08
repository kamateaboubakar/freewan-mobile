class Options {
  int? id;
  int? airConditoner;
  int? withFullFuel;
  int? carId;
  int? withDriver;
  String? createdAt;
  String? updatedAt;

  Options(
      {this.id,
      this.airConditoner,
      this.withFullFuel,
      this.carId,
      this.withDriver,
      this.createdAt,
      this.updatedAt});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    airConditoner = json['airConditoner'];
    withFullFuel = json['withFullFuel'];
    carId = json['carId'];
    withDriver = json['withDriver'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['airConditoner'] = this.airConditoner;
    data['withFullFuel'] = this.withFullFuel;
    data['carId'] = this.carId;
    data['withDriver'] = this.withDriver;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
