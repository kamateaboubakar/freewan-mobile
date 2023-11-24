import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/paiement/mode_paiement.dart';

class CarteBancaire extends MoyenPaiements {
  @override
  int? id;
  int? userId;
  String? idUser;
  int? categorieId;
  String? numeroCarte;
  String? cvc;
  String? dateExpiration;
  String? createdAt;
  String? updatedAt;
  String? owerName;

  CarteBancaire(
      {this.id,
      this.userId,
      this.idUser,
      this.categorieId,
      this.numeroCarte,
      this.cvc,
      this.dateExpiration,
      this.createdAt,
      this.updatedAt,
      this.owerName});

  CarteBancaire.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    idUser = json['id_user'];
    categorieId = json['categorie_id'];
    numeroCarte = json['numero_carte'];
    cvc = json['cvc'];
    dateExpiration = json['date_expiration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    owerName = json['ower_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['id_user'] = idUser;
    data['categorie_id'] = categorieId;
    data['numero_carte'] = numeroCarte;
    data['cvc'] = cvc;
    data['date_expiration'] = dateExpiration;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['ower_name'] = owerName;
    return data;
  }

  @override
  String get label => "************${numeroCarte.value.substring(12)}";

  @override
  String get typePaiment => "CB";
}
