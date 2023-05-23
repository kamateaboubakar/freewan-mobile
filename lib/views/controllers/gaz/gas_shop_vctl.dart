import 'package:wan_mobile/api/controllers/gaz_api_ctl.dart';
import 'package:wan_mobile/api/services/location_service.dart';
import 'package:wan_mobile/models/gas_purchase_action.dart';
import 'package:wan_mobile/models/gas_size.dart';
import 'package:wan_mobile/models/location_model.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class GasShopController extends ViewController {
  final GazApiCtl _gazApiCtl = GazApiCtl();

  late Shop _shop;

  Shop get shop => _shop;

  updateShop(Shop shop) => _shop = shop;

  HttpResponse<Shop>? _shopInfoResponse;

  HttpResponse<Shop>? get shopInfoResponse => _shopInfoResponse;

  List<Brands> _brands = [];

  List<Brands> get brands => _brands;

  Brands? _brand;

  Brands? get brand => _brand;

  updateSelectedBrand(Brands brand) {
    _brand = brand;
    _gasSize = null;
    update();
  }

  GasSize? _gasSize;

  GasSize? get gasSize => _gasSize;

  updateGasSize(GasSize gasSize) {
    _gasSize = gasSize;
    update();
  }

  GasPurchaseAction? _gasPurchaseAction;

  GasPurchaseAction? get gasPurchaseAction => _gasPurchaseAction;

  bool isPurchaseActionSelected(GasPurchaseAction action) =>
      action == _gasPurchaseAction;

  bool get hasPurchaseActionSelected => _gasPurchaseAction != null;

  void updatePurchaseAction(GasPurchaseAction action) {
    _gasPurchaseAction = action;
    update();
  }

  reset() {
    _brand = null;
    _brands = [];
  }

  getShopInfo(int id) async {
    _shopInfoResponse = null;
    update();
    _shopInfoResponse = await _gazApiCtl.getShopById(id: id);
    if (_shopInfoResponse!.status) {
      _brands = _shopInfoResponse!.data!.brands!;
    }
    update();
  }

  bool get isFormValid => _brand != null && _gasSize != null;

  void clearSelectedPurchaseAction() {
    _gasPurchaseAction = null;
    update();
  }
}
