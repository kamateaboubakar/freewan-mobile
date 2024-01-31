import 'package:tools_flutter_project/tools/types/map.dart';

class MarchandRequest {
  String? nom;
  String? prenom;
  String? email;
  String? tel;
  String? password;
  int? countryId;

  MarchandRequest(
      {this.nom,
      this.prenom,
      this.email,
      this.tel,
      this.password,
      this.countryId});

  Json toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_name'] = nom;
    data['first_name'] = prenom;
    data['email'] = email;
    data['tel'] = tel;
    data['password'] = password;
    data['country_id'] = countryId;
    data['login'] = tel;
    return data;
  }
}
