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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['description'] = description;
    data['rating'] = rating;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['photo_link'] = photoLink;
    return data;
  }
}
