import 'package:flutter/material.dart';
import 'package:wan_mobile/api/controllers/address_api_ctl.dart';
import 'package:wan_mobile/api/controllers/pressing_api_ctl.dart';
import 'package:wan_mobile/models/address/address_type.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/models/user.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

import '../../../api/services/location_service.dart';
import '../../../models/location_model.dart';
import '../../../models/pressing/time_delivery.dart';
import '../../../models/pressing/user_localisation.dart';
import '../../../tools/utils/http_response.dart';

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
      //customerId: appCtl.user.accountId!,
      customerId: "051115ABJ",
    );
    update(['userLocalisationView']);
  }

  getAddressTypes() async {
    _addressTypeResponse = null;
    update(['addressTypeView']);
    _addressTypeResponse = await _addressApiCtl.getAddressType();
    update(['addressTypeView']);
  }
}
