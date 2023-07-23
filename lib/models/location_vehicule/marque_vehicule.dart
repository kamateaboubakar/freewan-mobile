class MarqueVehicule {
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? id;

  MarqueVehicule(
      {this.name, this.image, this.createdAt, this.updatedAt, this.id});

  MarqueVehicule.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}
