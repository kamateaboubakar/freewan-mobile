import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/models/loyer/abstracts/habitat.dart';
import 'package:wan_mobile/models/loyer/type_appartement.dart';

class Appartement extends Habitat {
  String? numeroAppartement;
  TypeAppartement? typeAppartement;
  BlocAppartement? blocAppart;

  Appartement({
    this.numeroAppartement,
    this.typeAppartement,
    this.blocAppart,
  });

  Appartement.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      super.fromJson(json);
      numeroAppartement = json['numeroAppartement'];
      typeAppartement = json['typeAppartement'] != null
          ? TypeAppartement.fromJson(json['typeAppartement'])
          : null;
      blocAppart = json['blocAppart'] != null
          ? BlocAppartement.fromJson(json['blocAppartement'])
          : null;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['numeroAppartement'] = numeroAppartement;
    data['typeAppartement'] = typeAppartement?.id;
    data['blocAppartement'] = blocAppart?.id;
    return data;
  }
}
