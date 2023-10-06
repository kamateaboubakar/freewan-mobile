import 'package:wan_mobile/models/scolarite/ecole.dart';

class NiveauScolaire {
  int? id;
  String? libelle;
  int? ecoleId;
  String? createdAt;
  String? updatedAt;
  Ecole? ecole;

  NiveauScolaire(
      {this.id,
      this.libelle,
      this.ecoleId,
      this.createdAt,
      this.updatedAt,
      this.ecole});

  NiveauScolaire.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    ecoleId = json['ecole_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ecole = json['ecole'] != null ? Ecole.fromJson(json['ecole']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['libelle'] = libelle;
    data['ecole_id'] = ecoleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (ecole != null) {
      data['ecole'] = ecole!.toJson();
    }
    return data;
  }
}
