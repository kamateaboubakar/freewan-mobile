import 'package:wan_mobile/tools/types/types.dart';

class Adresse {
  int? id;
  int? userId;
  String? libelle;
  String? locationLabel;
  double? latitude;
  double? longitude;

  Adresse({this.libelle, this.userId, this.latitude, this.longitude});

  Adresse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    userId = json['user_id'];
    latitude = json['latitude'].toString().toDouble();
    longitude = json['longitude'].toString().toDouble();
    locationLabel = json['location_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['libelle'] = this.libelle;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location_label'] = this.locationLabel;
    return data;
  }
}
