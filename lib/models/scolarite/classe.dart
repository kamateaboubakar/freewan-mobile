import 'package:wan_mobile/models/scolarite/niveau_scolaire.dart';

class Classe {
  int? id;
  String? anneeScolaire;
  int? niveauId;
  String? montantFraisScolarite;
  String? dateFinReglementFrais;
  String? createdAt;
  String? updatedAt;
  int? etudiantId;
  NiveauScolaire? niveauScolaire;

  Classe(
      {this.id,
      this.anneeScolaire,
      this.niveauId,
      this.montantFraisScolarite,
      this.dateFinReglementFrais,
      this.createdAt,
      this.updatedAt,
      this.etudiantId,
      this.niveauScolaire});

  Classe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    anneeScolaire = json['annee_scolaire'];
    niveauId = json['niveau_id'];
    montantFraisScolarite = json['montant_frais_scolarite'];
    dateFinReglementFrais = json['date_fin_reglement_frais'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    etudiantId = json['etudiant_id'];
    niveauScolaire = json['niveau_scolaire'] != null
        ? new NiveauScolaire.fromJson(json['niveau_scolaire'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['annee_scolaire'] = this.anneeScolaire;
    data['niveau_id'] = this.niveauId;
    data['montant_frais_scolarite'] = this.montantFraisScolarite;
    data['date_fin_reglement_frais'] = this.dateFinReglementFrais;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['etudiant_id'] = this.etudiantId;
    if (this.niveauScolaire != null) {
      data['niveau_scolaire'] = this.niveauScolaire!.toJson();
    }
    return data;
  }
}
