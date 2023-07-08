import 'package:wan_mobile/tools/types/types.dart';

class PropietaireVehicule {
  String? nom, prenoms, rating;

  PropietaireVehicule({this.nom, this.prenoms, this.rating});

  Json toJson() => {};

  PropietaireVehicule.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    prenoms = json['prenoms'];
    rating = json['rating'];
  }
}
