class UserLocalisation {
  int? id;
  String? address;
  String? customerId;
  double? latitude;
  double? longitude;
  LocalisationType? localisationType;

  UserLocalisation(
      {this.id,
        this.address,
        this.customerId,
        this.latitude,
        this.longitude,
        this.localisationType});

  UserLocalisation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    customerId = json['customer_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    localisationType = json['localisation_type'] != null
        ? new LocalisationType.fromJson(json['localisation_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['customer_id'] = this.customerId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.localisationType != null) {
      data['localisation_type'] = this.localisationType!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo_link'] = this.photoLink;
    return data;
  }
}
