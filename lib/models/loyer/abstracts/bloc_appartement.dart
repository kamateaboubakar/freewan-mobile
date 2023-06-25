import 'package:wan_mobile/models/loyer/abstracts/bien_immobilier.dart';
import 'package:wan_mobile/models/loyer/appartement.dart';

class BlocAppartement extends BienImmobilier {
  List<Appartement> appartements = [];
  String? libelle;
  String? lieu;

  BlocAppartement(
      {super.createdAt,
      super.updatedAt,
      super.active,
      super.version,
      super.id,
      this.libelle,
      this.lieu,
      super.ownerId,
      this.appartements = const []});

  BlocAppartement.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      fromJson(json);
      appartements = <Appartement>[];
      json['appartements'].forEach((v) {
        appartements.add(Appartement.fromJson(v));
      });
      libelle = json['libelle'];
      lieu = json['lieu'];
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['appartements'] = appartements.map((v) => v.id).toList();
    data["libelle"] = libelle;
    data["lieu"] = lieu;
    return data;
  }
}
