import 'package:wan_mobile/models/construction/material_unit.dart';

class OrderItems {
  int? id;
  int? materialId;
  String? materialName;
  String? materialDescription;
  int? materialPrice;
  MaterialUnit? materialUnit;
  int? quantity;
  String? createdAt;
  int? total;

  OrderItems(
      {this.id,
      this.materialId,
      this.materialName,
      this.materialDescription,
      this.materialPrice,
      this.materialUnit,
      this.quantity,
      this.createdAt,
      this.total});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialId = json['materialId'];
    materialName = json['materialName'];
    materialDescription = json['materialDescription'];
    materialPrice = json['materialPrice'];
    materialUnit = json['materialUnit'] != null
        ? MaterialUnit.fromJson(json['materialUnit'])
        : null;
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['materialId'] = materialId;
    data['materialName'] = materialName;
    data['materialDescription'] = materialDescription;
    data['materialPrice'] = materialPrice;
    if (materialUnit != null) {
      data['materialUnit'] = materialUnit!.toJson();
    }
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['total'] = total;
    return data;
  }
}
