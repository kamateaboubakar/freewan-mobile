import 'package:wan_mobile/tools/widgets/location_vehicule/proprietaire_vehicule.dart';

class Vehicule {
  String? marque;
  String? prix;
  String? modele;
  String? moteur;
  String? puissance;
  String? nbJour;
  String? image;
  String? vitesseMax;
  PropietaireVehicule? propietaireVehicule;

  Vehicule(
      {this.marque,
      this.moteur,
      this.modele,
      this.nbJour,
      this.prix,
      this.image,
      this.propietaireVehicule,
      this.puissance,
      this.vitesseMax});
}
