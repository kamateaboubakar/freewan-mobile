class CarteBancaire {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['id_user'] = this.idUser;
    data['categorie_id'] = this.categorieId;
    data['numero_carte'] = this.numeroCarte;
    data['cvc'] = this.cvc;
    data['date_expiration'] = this.dateExpiration;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ower_name'] = this.owerName;
    return data;
  }
}
