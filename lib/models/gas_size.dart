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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture_name'] = this.pictureName;
    data['brand_in_shop_id'] = this.brandInShopId;
    return data;
  }
}
