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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['display_price'] = displayPrice;
    data['photo_link'] = photoLink;
    return data;
  }
}
