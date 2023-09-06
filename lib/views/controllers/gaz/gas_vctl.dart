import 'package:wan_mobile/api/controllers/gaz_api_ctl.dart';
import 'package:wan_mobile/api/services/location_service.dart';
import 'package:wan_mobile/models/gas_size.dart';
import 'package:wan_mobile/models/location_model.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class GasController extends ViewController {
  final GazApiCtl _gazApiCtl = GazApiCtl();

  List<Shop>? _shops;

  List<Shop>? get shops => _shops;

  Shop? _shop;

  Shop? get shop => _shop;

  bool get isLocationTypeSelected => _selectedLocationType != -1;

  bool get hasUserLocation => _userLocation != null;

  updateShop(Shop shop) {
    _shop = shop;
    update();
  }

  LocationModel? _userLocation;

  LocationModel? get userLocation => _userLocation;

  updateUserLocation(LocationModel locationModel) {
    _userLocation = locationModel;
    update();
  }

  LocationModel? _deliveryLocation;

  LocationModel? get deliveryLocation => _deliveryLocation;

  updateDeliveryLocation(LocationModel locationModel) {
    _deliveryLocation = locationModel;
    update();
  }

  int _selectedLocationType = -1;

  int get selectedLocationType => _selectedLocationType;

  reset() {
    _selectedLocationType = -1;
    _shop = null;
    _deliveryLocation = null;
    _userLocation = null;
  }

  updateLocationType(int type) {
    _selectedLocationType = type;
    update();
  }

  bool get isLocationTypeHome => _selectedLocationType == 1;

  bool get isLocationTypeOffice => _selectedLocationType == 2;

  Future<HttpResponse<List<Shop>>> getClosestShop() async {
    _userLocation =
        await LocationService.getLocation(withLocationDescription: true);
    var response = await _gazApiCtl.getClosestShop(
        latitude: _userLocation!.latitude, longitude: _userLocation!.longitude);
    if (response.status) {
      _shops = response.data!;
    }
    update();
    return response;
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

  String get deliveryLocationName =>
      _deliveryLocation?.title ?? _userLocation?.title ?? '';

  Future<HttpResponse> submitOrder(
      {required LocationModel userlocation,
      required GasSize gasSize,
      required Shop shop}) {
    return _gazApiCtl.submitOrder(
      brandInShopId: gasSize.brandInShopId!,
      customerSessionId: appCtl.user.id.value.toString(),
      customerAddressId: 0,
      latitude: userLocation!.latitude,
      longitude: userLocation!.longitude,
      targetId: _selectedLocationType,
      price: gasSize.price!,
    );
  }

  void clearSelectedShop() {
    _shop = null;
    update();
  }
}
