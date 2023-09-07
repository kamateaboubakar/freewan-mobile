class AccountTransaction {
  int? id;
  int? userId;
  String? libele;
  String? amount;
  String? frais;
  String? service;
  String? modePayment;
  String? mobileMoneyId;
  String? bankcardId;
  String? createdAt;
  String? updatedAt;

  AccountTransaction(
      {this.id,
      this.userId,
      this.libele,
      this.amount,
      this.frais,
      this.service,
      this.modePayment,
      this.mobileMoneyId,
      this.bankcardId,
      this.createdAt,
      this.updatedAt});

  AccountTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    libele = json['libele'];
    amount = json['amount'];
    frais = json['frais'];
    service = json['service'];
    modePayment = json['mode_payment'];
    mobileMoneyId = json['mobile_money_id'].toString();
    bankcardId = json['bankcard_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['libele'] = libele;
    data['amount'] = amount;
    data['frais'] = frais;
    data['service'] = service;
    data['mode_payment'] = modePayment;
    data['mobile_money_id'] = mobileMoneyId;
    data['bankcard_id'] = bankcardId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
