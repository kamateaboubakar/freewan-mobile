class GasSize {
  int? price;
  int? id;
  String? name;
  String? pictureName;
  int? brandInShopId;

  GasSize(
      {this.price, this.id, this.name, this.pictureName, this.brandInShopId});

  GasSize.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    id = json['id'];
    name = json['name'];
    pictureName = json['picture_name'];
    brandInShopId = json['brand_in_shop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['price'] = price;
    data['id'] = id;
    data['name'] = name;
    data['picture_name'] = pictureName;
    data['brand_in_shop_id'] = brandInShopId;
    return data;
  }
}
