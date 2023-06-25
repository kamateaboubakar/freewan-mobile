import 'package:wan_mobile/models/loyer/abstracts/habitat.dart';

class Maison extends Habitat {
  String? libelle;
  String? lieu;
  Maison();
  Maison.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      fromJson(json);
      libelle = json['libelle'];
      lieu = json['lieu'];
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['libelle'] = libelle;
    data['lieu'] = lieu;
    return data;
  }
}
