import 'package:wan_mobile/api/controllers/address_api_ctl.dart';
import 'package:wan_mobile/models/address/address_type.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

import '../../../models/pressing/user_localisation.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';

class AddressController extends ViewController {
  final AddressApiCtl _addressApiCtl = AddressApiCtl();

  HttpResponse<List<UserLocalisation>>? _userLocalisationResponse;

  HttpResponse<List<UserLocalisation>>? get userLocalisationResponse =>
      _userLocalisationResponse;

  HttpResponse<List<AddressType>>? _addressTypeResponse;

  HttpResponse<List<AddressType>>? get addressTypeResponse =>
      _addressTypeResponse;

  getUserAddresses() async {
    _userLocalisationResponse = null;
    update(['userLocalisationView']);
    _userLocalisationResponse = await _addressApiCtl.getCustomerAddress(
        customerId: appCtl.user.id.value.toString());
    if (_userLocalisationResponse!.status) {
      getAddressTypes();
    }
    update(['userLocalisationView']);
  }

  getAddressTypes() async {
    _addressTypeResponse = null;
    update(['addressTypeView']);
    _addressTypeResponse = await _addressApiCtl.getAddressType();
    update(['addressTypeView']);
  }
}
