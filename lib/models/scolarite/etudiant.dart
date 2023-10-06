class Etudiant {
  int? id;
  String? nom;
  String? prenoms;
  String? dateNaissance;
  String? lieuNaissance;
  String? sexe;
  String? numeroIdentification;
  String? createdAt;
  String? updatedAt;

  Etudiant(
      {this.id,
      this.nom,
      this.prenoms,
      this.dateNaissance,
      this.lieuNaissance,
      this.sexe,
      this.numeroIdentification,
      this.createdAt,
      this.updatedAt});

  Etudiant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenoms = json['prenoms'];
    dateNaissance = json['date_naissance'];
    lieuNaissance = json['lieu_naissance'];
    sexe = json['sexe'];
    numeroIdentification = json['numero_identification'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['prenoms'] = prenoms;
    data['date_naissance'] = dateNaissance;
    data['lieu_naissance'] = lieuNaissance;
    data['sexe'] = sexe;
    data['numero_identification'] = numeroIdentification;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String get fullName => "$nom $prenoms";
}
