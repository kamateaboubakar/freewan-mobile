import 'package:wan_mobile/models/loyer/abstracts/habitat.dart';

class PaiementLoyer {
  String? createdAt;
  String? updatedAt;
  int? active;
  int? version;
  int? id;
  String? date;
  String? reference;
  double? montant;
  String? telPaiement;
  String? idUserPaiement;
  int? mois;
  int? annee;
  Habitat? habitat;

  PaiementLoyer(
      {this.createdAt,
      this.updatedAt,
      this.active,
      this.version,
      this.id,
      this.date,
      this.reference,
      this.montant,
      this.telPaiement,
      this.idUserPaiement,
      this.mois,
      this.annee,
      this.habitat});

  PaiementLoyer.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    active = json['active'];
    version = json['version'];
    id = json['id'];
    date = json['date'];
    reference = json['reference'];
    montant = json['montant'];
    telPaiement = json['telPaiement'];
    idUserPaiement = json['idUserPaiement'];
    mois = json['mois'];
    annee = json['annee'];
    habitat =
        json['habitat'] != null ? Habitat.fromJson(json['habitat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['active'] = active;
    data['version'] = version;
    data['id'] = id;
    data['date'] = date;
    data['reference'] = reference;
    data['montant'] = montant;
    data['telPaiement'] = telPaiement;
    data['idUserPaiement'] = idUserPaiement;
    data['mois'] = mois;
    data['annee'] = annee;
    data['habitat'] = habitat?.id;
    return data;
  }
}
