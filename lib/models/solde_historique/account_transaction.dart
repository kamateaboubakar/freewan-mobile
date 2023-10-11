class AccountTransaction {
  int? id;
  int? userId;
  String? libele;
  String? amount;
  String? frais;
  String? service;
  String? modePayment;
  String? createdAt;
  String? updatedAt;
  int? recevedId;
  String? numberPayment;
  String? paymentUrl;

  AccountTransaction(
      {this.id,
      this.userId,
      this.libele,
      this.amount,
      this.frais,
      this.service,
      this.modePayment,
      this.numberPayment,
      this.createdAt,
      this.updatedAt,
      this.recevedId,
      this.paymentUrl});

  AccountTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    libele = json['libele'];
    amount = json['amount'];
    frais = json['frais'];
    service = json['service'];
    modePayment = json['mode_payment'];
    numberPayment = json['number_payment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    recevedId = json['receved_id'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_users'] = userId;
    data['libele'] = libele;
    data['amount'] = amount;
    data['frais'] = frais;
    data['service'] = service;
    data['mode_payment'] = modePayment;
    data['number_payment'] = numberPayment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['receved_id'] = recevedId;
    data['payment_url'] = paymentUrl;
    return data;
  }
}
