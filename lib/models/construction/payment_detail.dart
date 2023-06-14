class PaymentDetail {
  String? id;
  String? provider;
  String? reference;
  String? amount;
  int? paymentFees;
  int? deliveryFees;
  String? status;
  String? createdAt;
  String? updatedAt;

  PaymentDetail(
      {this.id,
      this.provider,
      this.reference,
      this.amount,
      this.paymentFees,
      this.deliveryFees,
      this.status,
      this.createdAt,
      this.updatedAt});

  PaymentDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    reference = json['reference'];
    amount = json['amount'];
    paymentFees = json['paymentFees'];
    deliveryFees = json['deliveryFees'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider'] = provider;
    data['reference'] = reference;
    data['amount'] = amount;
    data['paymentFees'] = paymentFees;
    data['deliveryFees'] = deliveryFees;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
