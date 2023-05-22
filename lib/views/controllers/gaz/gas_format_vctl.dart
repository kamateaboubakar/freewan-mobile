import 'package:wan_mobile/api/controllers/gaz_api_ctl.dart';
import 'package:wan_mobile/api/services/location_service.dart';
import 'package:wan_mobile/models/gas_purchase_action.dart';
import 'package:wan_mobile/models/gas_size.dart';
import 'package:wan_mobile/models/location_model.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class GasFormatController extends ViewController {
  final GazApiCtl _gazApiCtl = GazApiCtl();

  HttpResponse<List<GasSize>>? _response;

  HttpResponse<List<GasSize>>? get response => _response;

  getGasSize({required int shopId, required int brandId}) async {
    _response = null;
    update();
    _response = await _gazApiCtl.getGasSize(shopId: shopId, brandId: brandId);
    update();
  }
}
