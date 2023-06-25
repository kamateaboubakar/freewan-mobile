import 'package:wan_mobile/models/loyer/abstracts/bien_immobilier.dart';

class Habitat extends BienImmobilier {
  double? loyer;
  int? jourMoisPaiement;
  int? nbPiece;
  String? code;

  Habitat();

  Habitat.fromJson(Map<String, dynamic>? json) {
    fromJson(json);
  }

  @override
  fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      super.fromJson(json);
      loyer = json['loyer'];
      jourMoisPaiement = json['jourMoisPaiement'];
      nbPiece = json['nbPiece'];
      code = json['code'];
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['loyer'] = loyer;
    data['jourMoisPaiement'] = jourMoisPaiement;
    data['nbPiece'] = nbPiece;
    data['code'] = code;
    return data;
  }
}
