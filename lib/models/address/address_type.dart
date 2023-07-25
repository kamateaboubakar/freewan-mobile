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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo_link'] = photoLink;
    return data;
  }
}
