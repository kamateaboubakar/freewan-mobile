import 'package:wan_mobile/tools/const/const.dart';

class PressingArticle {
  int? id;
  String? name;
  double? price;
  String? displayPrice;
  String? photoLink;
  int? quantity;

  PressingArticle({
    this.id,
    this.name,
    this.price,
    this.displayPrice,
    this.photoLink,
    this.quantity = 0,
  });

  PressingArticle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    displayPrice = json['display_price'];
    photoLink = json['photo_link'];
    quantity = json['quantity'] ?? 0;
  }

  String get imageUrl => "${Const.pressingImageUrl}/$photoLink";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['display_price'] = this.displayPrice;
    data['photo_link'] = this.photoLink;
    return data;
  }
}
