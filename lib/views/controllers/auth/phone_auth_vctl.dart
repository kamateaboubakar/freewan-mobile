import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/api/controllers/pays_api_ctl.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/otp_auth.dart';

class PhoneAuthVctl extends ViewController {
  var telCtl = TextEditingController();
  late ProgressDialog pr;

  List<Pays> pays = [];
  Pays? selectedPays;

  PhoneAuthVctl() : pr = Tools.progressDialog();

  Future<void> submit() async {
    if (selectedPays != null) {
      if (telCtl.text.isNotEmpty) {
        // await pr.show();
        // var codePays = selectedPays!.callingCode;

        // var phone = "$codePays${telCtl.text}";
        // var res = await UserApiCtl().loginPhone(phone);
        // await pr.hide();
        // if (res.status) {
        //   Get.to(() => OPTAuth(phone: phone));
        // } else {
        //   Tools.messageBox(message: res.message);
        // }
        Get.to(() => OPTAuth(phone: telCtl.text));
      } else {
        Tools.messageBox(
            message: "Veuillez entrer un numéro de téléphone valide SVP.");
      }
    } else {
      Tools.messageBox(message: "Veuillez sélectionner votre région SVP.");
    }
  }

  _getPays() async {
    var res = await PaysApiCtl().getAll();
    if (res.status) {
      pays = res.data!;
      update();
    } else {
      print(res.message);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getPays();
  }
}
