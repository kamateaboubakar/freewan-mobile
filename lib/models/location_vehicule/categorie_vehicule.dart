class CategorieVehicule {
  String? libelle;
  int? id;
  String? description;
  String? _image;

  CategorieVehicule({String? image, this.libelle}) : _image = image;

  CategorieVehicule.fromJson(Map<String, dynamic> json) {
    libelle = json['libelle'];
    id = json['id'];
    description = json['description'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['libelle'] = libelle;
    data['id'] = id;
    data['description'] = description;
    data['image'] = _image;
    return data;
  }

  String get image => _image == null ? '' : "http://$_image";
}
