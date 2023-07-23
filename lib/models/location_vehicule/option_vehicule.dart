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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['airConditoner'] = airConditoner;
    data['withFullFuel'] = withFullFuel;
    data['carId'] = carId;
    data['withDriver'] = withDriver;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
