class UserLocalisation {
  int? id;
  String? address;
  String? customerId;
  double? latitude;
  double? longitude;
  LocalisationType? localisationType;
  bool? isNew;

  UserLocalisation({
    this.id,
    this.address,
    this.customerId,
    this.latitude,
    this.longitude,
    this.localisationType,
    this.isNew = false,
  });

  UserLocalisation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    customerId = json['customer_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    localisationType = json['localisation_type'] != null
        ? LocalisationType.fromJson(json['localisation_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['customer_id'] = customerId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (localisationType != null) {
      data['localisation_type'] = localisationType!.toJson();
    }
    return data;
  }
}

class LocalisationType {
  int? id;
  String? name;
  String? photoLink;

  LocalisationType({this.id, this.name, this.photoLink});

  LocalisationType.fromJson(Map<String, dynamic> json) {
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
