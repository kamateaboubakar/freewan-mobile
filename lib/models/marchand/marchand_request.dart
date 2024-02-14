import 'package:tools_flutter_project/tools/types/map.dart';

class MarchandRequest {
  String? nom;
  String? prenoms;
  String? email;
  String? tel;
  String? tel2;
  String? password;
  int? countryId;

  MarchandRequest(
      {this.nom,
      this.prenoms,
      this.email,
      this.tel,
      this.password,
      this.countryId});

  Json toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nom'] = nom;
    data['prenoms'] = prenoms;
    data['email'] = email;
    data['tel'] = tel;
    data['tel2'] = tel2;
    data['password'] = password;
    data['country_id'] = countryId;
    data['login'] = tel;
    return data;
  }
}
