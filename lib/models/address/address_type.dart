class AddressType {
  int? id;
  String? name;
  String? photoLink;

  AddressType({this.id, this.name, this.photoLink});

  AddressType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photoLink = json['photo_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo_link'] = this.photoLink;
    return data;
  }
}
