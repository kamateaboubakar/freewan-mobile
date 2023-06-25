class TypeAppartement {
  String? createdAt;
  String? updatedAt;
  int? active;
  int? version;
  int? id;
  String? libelle;

  TypeAppartement(
      {this.createdAt,
      this.updatedAt,
      this.active,
      this.version,
      this.id,
      this.libelle});

  TypeAppartement.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    active = json['active'];
    version = json['version'];
    id = json['id'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['active'] = active;
    data['version'] = version;
    data['id'] = id;
    data['libelle'] = libelle;
    return data;
  }
}
