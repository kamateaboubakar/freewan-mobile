class ImageVehicule {
  int? id;
  int? carId;
  String? photoLink;
  String? createdAt;
  String? updatedAt;

  ImageVehicule(
      {this.id, this.carId, this.photoLink, this.createdAt, this.updatedAt});

  ImageVehicule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['carId'];
    photoLink = json['photoLink'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['carId'] = carId;
    data['photoLink'] = photoLink;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  String? get url => photoLink == null ? null : "http://$photoLink";
}
