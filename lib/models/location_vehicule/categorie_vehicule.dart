class CategorieVehicule {
  String? libelle;
  int? id;
  String? description;
  String? image;

  CategorieVehicule({this.image, this.libelle});

  CategorieVehicule.fromJson(Map<String, dynamic> json) {
    libelle = json['libelle'];
    id = json['id'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['libelle'] = this.libelle;
    data['id'] = this.id;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
