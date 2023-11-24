import 'package:tools_flutter_project/tools/types/map.dart';

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
