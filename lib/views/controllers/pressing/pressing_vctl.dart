import 'package:flutter/material.dart';
import 'package:wan_mobile/api/controllers/pressing_api_ctl.dart';
import 'package:wan_mobile/models/address/address_type.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

import '../../../api/services/location_service.dart';
import '../../../models/location_model.dart';
import '../../../models/pressing/pressing_article.dart';
import '../../../models/pressing/pressing_service.dart';
import '../../../models/pressing/time_delivery.dart';
import '../../../models/pressing/user_localisation.dart';
import '../../../tools/utils/http_response.dart';

class PressingController extends ViewController {
  final PressingApiCtl _pressingApiCtl = PressingApiCtl();

  HttpResponse<List<Pressing>>? _response;

  HttpResponse<List<Pressing>>? get response => _response;

  LocationModel? _userLocation;

  LocationModel? get userLocation => _userLocation;

  bool get hasUserLocalisation {
    var result = _userLocalisation != null;
    print('hasUserLocalisation $result');
    return result;
  }

  AddressType? _addressType;

  AddressType? get addressType => _addressType;

  String get recuperationPlaceName =>
      _recuperationPlace?.title ?? _userLocation?.title ?? '';

  bool get hasAddressTypeSeleced {
    var result = _addressType != null;
    print('hasAddressTypeSeleced $result');
    return result;
  }

  updateAddressType(AddressType? addressType) {
    _addressType = addressType;
    update();
  }

  updateUserLocation(LocationModel locationModel) {
    _userLocation = locationModel;
    update();
  }

  List<Pressing>? _pressings;

  List<Pressing>? get pressings => _pressings;

  Pressing? _pressing;

  Pressing? get pressing => _pressing;

  UserLocalisation? _userLocalisation;

  UserLocalisation? get userLocalisation => _userLocalisation;

  LocationModel? _recuperationPlace;

  LocationModel? get recuperationPlace => _recuperationPlace;

  updateRecuperationPlace(LocationModel locationModel) {
    _recuperationPlace = locationModel;
    update();
  }

  updateUserLocalisation(UserLocalisation? userLocalisation) {
    _userLocalisation = userLocalisation;
    update();
  }

  updatePressing(Pressing pressing) {
    _pressing = pressing;
    update();
  }

  Future<HttpResponse<List<Pressing>>> getClosestPressing() async {
    _userLocation = await LocationService.getLocation(withLocationDescription: true);
    var response = await _pressingApiCtl.getClosestPressings(latitude: _userLocation!.latitude, longitude: _userLocation!.longitude);
    if (response.status) {
      _pressings = response.data!;
    }
    update();
    return response;
  }

  void reset() {
    _pressing = null;
    _userLocalisation = null;
    _addressType = null;
    update();
  }

  bool get hasUserLocation => _userLocation != null;

  late TimeDeliverySelection _timeDeliverySelection;

  TimeDeliverySelection get timeDeliverySelection => _timeDeliverySelection;

  TimeOfDay? _deliveryHour;

  TimeOfDay? get deliveryHour => _deliveryHour;

  void resetInfoRecuperation() {
    _timeDeliverySelection = TimeDeliverySelection.times.first;
    _deliveryHour = null;
  }

  void updateDeliverySelectionTime(TimeDeliverySelection deliveryTime) {
    _timeDeliverySelection = deliveryTime;
    update();
  }

  void updateDeliveryHour(TimeOfDay? selectedTime) {
    _deliveryHour = selectedTime;
    update();
  }

  Future<LocationModel> getLocationDescription(
      LocationModel locationModel) async {
    String locationDescription = await LocationService.getPlaceDescription(
      locationModel.latitude,
      locationModel.longitude,
    );
    locationModel.title = locationDescription;
    return locationModel;
  }

  Future<HttpResponse> submitOrder({
    required String recuperationDate,
    required double totalAmount,
    required int pressingId,
    required List<PressingService> services,
    required List<PressingArticle> articles,
    required UserLocalisation userLocalisation,
  }) {
    return _pressingApiCtl.submitOrder(
      recuperationDate: recuperationDate,
      totalAmount: totalAmount,
      pressingId: pressingId,
      services: services,
      articles: articles,
      userLocalisation: userLocalisation,
    );
  }

  void saveRecuperationPlace() {
    if (!hasUserLocalisation) {
      _userLocalisation = UserLocalisation(
        address: _recuperationPlace!.title,
        longitude: _recuperationPlace!.longitude,
        latitude: _recuperationPlace!.latitude,
        localisationType: LocalisationType(
          id: _addressType!.id,
          name: _addressType!.name,
        ),
      );
      update();
    }
  }
}
