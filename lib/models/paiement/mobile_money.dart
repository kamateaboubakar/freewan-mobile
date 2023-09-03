import 'package:wan_mobile/models/paiement/mode_paiement.dart';
import 'package:wan_mobile/tools/types/types.dart';

class MobileMoney extends MoyenPaiements {
  @override
  int? id;
  int? userId;
  String? idUser;
  int? categorieId;
  String? numeroTelephone;
  String? createdAt;
  String? updatedAt;

  MobileMoney(
      {this.id,
      this.userId,
      this.idUser,
      this.categorieId,
      this.numeroTelephone,
      this.createdAt,
      this.updatedAt});

  MobileMoney.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    idUser = json['id_user'];
    categorieId = json['categorie_id'];
    numeroTelephone = json['numero_telephone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['id_user'] = idUser;
    data['categorie_id'] = categorieId;
    data['numero_telephone'] = numeroTelephone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  String get label => numeroTelephone.value;

  @override
  String get typePaiment => "MM";
}
