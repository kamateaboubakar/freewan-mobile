class Ecole {
  int? id;
  String? libelle;
  String? createdAt;
  String? updatedAt;

  Ecole({this.id, this.libelle, this.createdAt, this.updatedAt});

  Ecole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['libelle'] = libelle;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
