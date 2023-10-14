import 'package:geolocator/geolocator.dart';
import 'package:get/utils.dart';
import 'package:location/location.dart';
import '../../models/location_model.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:latlong2/latlong.dart';

class LocationService {
  static final Location _location = Location();

  static Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await _location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return false;
    }
    return true;
  }

  static Future<bool> hasLocationPermission() async {
    var permissionGranted = await _location.hasPermission();
    return permissionGranted == PermissionStatus.granted;
  }

  static Future<LocationModel> getLocation({
    bool withLocationDescription = false,
  }) async {
    var locationData = await _location.getLocation();
    String locationName = '';
    if (withLocationDescription) {
      locationName = await getPlaceDescription(
        locationData.latitude!,
        locationData.longitude!,
      );
    }
    return LocationModel(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
      title: locationName,
    );
  }

  static Future<String> getPlaceDescription(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isEmpty) return '';
    var placeMark = placemarks.first;
    return '${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}';
  }

  static int getDistanceBetweenTwoPoints(
      {required LatLng? point1, required LatLng? point2}) {
    if (point1 == null || point2 == null) {
      return 0;
    } else {
      return (Geolocator.distanceBetween(point1.latitude, point1.longitude,
                  point2.latitude, point2.longitude) /
              1000)
          .ceil();
    }
  }
}
