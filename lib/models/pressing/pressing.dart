import 'package:wan_mobile/tools/const/const.dart';

class Pressing {
  int? id;
  String? name;
  String? address;
  String? description;
  int? rating;
  double? latitude;
  double? longitude;
  String? photoLink;

  Pressing(
      {this.id,
        this.name,
        this.address,
        this.description,
        this.rating,
        this.latitude,
        this.longitude,
        this.photoLink});

  Pressing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    rating = json['rating'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    photoLink = json['photo_link'];
  }

  String get imageUrl => "${Const.pressingImageUrl}/$photoLink";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['photo_link'] = this.photoLink;
    return data;
  }
}
