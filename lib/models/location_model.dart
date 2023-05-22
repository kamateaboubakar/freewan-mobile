import 'package:latlong2/latlong.dart';

class LocationModel {
  final double latitude;
  final double longitude;
  String title;

  LocationModel({
    required this.latitude,
    required this.longitude,
    this.title = '',
  });

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}
