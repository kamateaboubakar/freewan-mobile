class ModePaiement {
  String? libelle;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? id;

  ModePaiement(
      {this.libelle,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.id});

  ModePaiement.fromJson(Map<String, dynamic> json) {
    libelle = json['libelle'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['libelle'] = libelle;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}
