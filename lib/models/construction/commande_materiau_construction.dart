import 'package:wan_mobile/models/construction/adresse_livraison.dart';
import 'package:wan_mobile/models/construction/customer.dart';
import 'package:wan_mobile/models/construction/order_item.dart';
import 'package:wan_mobile/models/construction/payment_detail.dart';

class CommandeMateriauConstruction {
  String? id;
  Customer? customer;
  PaymentDetail? paymentDetail;
  int? total;
  AdresseLivraison? adresseLivraison;
  String? deliveryDate;
  String? createdAt;
  String? status;
  List<OrderItems>? orderItems;
  int? totalOrderItem;

  CommandeMateriauConstruction(
      {this.id,
      this.customer,
      this.paymentDetail,
      this.total,
      this.adresseLivraison,
      this.deliveryDate,
      this.createdAt,
      this.status,
      this.orderItems,
      this.totalOrderItem});

  CommandeMateriauConstruction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    paymentDetail = json['paymentDetail'] != null
        ? PaymentDetail.fromJson(json['paymentDetail'])
        : null;
    total = json['total'];
    adresseLivraison = json['deliveryAddress'] != null
        ? AdresseLivraison.fromJson(json['deliveryAddress'])
        : null;
    deliveryDate = json['deliveryDate'];
    createdAt = json['createdAt'];
    status = json['status'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    totalOrderItem = json['totalOrderItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (paymentDetail != null) {
      data['paymentDetail'] = paymentDetail!.toJson();
    }
    data['total'] = total;
    if (adresseLivraison != null) {
      data['deliveryAddress'] = adresseLivraison!.toJson();
    }
    data['deliveryDate'] = deliveryDate;
    data['createdAt'] = createdAt;
    data['status'] = status;
    if (orderItems != null) {
      data['orderItems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['totalOrderItem'] = totalOrderItem;
    return data;
  }
}
