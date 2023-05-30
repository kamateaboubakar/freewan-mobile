import 'package:wan_mobile/models/don/categorie_campagne.dart';
import 'package:wan_mobile/models/don/organization.dart';
import 'package:wan_mobile/tools/types/types.dart';

class Campagne {
  int? id;
  CategorieCampagne? category;
  Organization? organization;
  String? label;
  double? amount;
  double? collectedAmount;
  String? description;
  String? createdAt;
  String? deadline;
  String? image;
  String? imageUrl;
  String? status;
  int? donorCount;

  Campagne(
      {this.id,
      this.category,
      this.organization,
      this.label,
      this.amount,
      this.collectedAmount,
      this.description,
      this.createdAt,
      this.deadline,
      this.image,
      this.imageUrl,
      this.status,
      this.donorCount});

  Campagne.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? CategorieCampagne.fromJson(json['category'])
        : null;
    organization = json['organization'] != null
        ? Organization.fromJson(json['organization'])
        : null;
    label = json['label'];
    amount = json['amount'];
    collectedAmount = json['collectedAmount'];
    description = json['description'];
    createdAt = json['createdAt'];
    deadline = json['deadline'];
    image = json['image'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    donorCount = json['donorCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organizationId'] = organization?.id;
    data['categoryId'] = category?.id;
    data['label'] = label;
    data['amount'] = amount;
    data['description'] = description;
    data['deadline'] = deadline;
    data['image'] = image;
    return data;
  }

  int get nbJourRestant {
    if (deadline == null) {
      return 0;
    } else {
      return deadline!.toDateTime()!.difference(DateTime.now()).inDays;
    }
  }
}
