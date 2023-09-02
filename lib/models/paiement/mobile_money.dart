import 'package:wan_mobile/models/paiement/mode_paiement.dart';
import 'package:wan_mobile/tools/types/types.dart';

class MobileMoney extends MoyenPaiements {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['id_user'] = this.idUser;
    data['categorie_id'] = this.categorieId;
    data['numero_telephone'] = this.numeroTelephone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String get label => numeroTelephone.value;

  @override
  String get typePaiment => "MM";
}
