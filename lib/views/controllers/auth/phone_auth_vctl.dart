import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/api/controllers/pays_api_ctl.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/otp_auth.dart';
import 'package:wan_mobile/views/static/auth/register/register_page.dart';

class PhoneAuthVctl extends ViewController {
  var telCtl = TextEditingController();
  late ProgressDialog pr;

  List<Pays> pays = [];
  Pays? selectedPays;

  bool acceptCgu = false;

  PhoneAuthVctl() : pr = Tools.progressDialog();

  Future<void> submit() async {
    Get.to(() => OPTAuth(phone: telCtl.text, onSubmit: submitOtp));
    // if (selectedPays != null) {
    //   if (telCtl.text.isNotEmpty) {
    //     // await pr.show();
    //     // var codePays = selectedPays!.callingCode;

    //     // var phone = "$codePays${telCtl.text}";
    //     // var res = await UserApiCtl().loginPhone(phone);
    //     // await pr.hide();
    //     // if (res.status) {
    //     //   Get.to(() => OPTAuth(phone: phone, selectedPays: selectedPays!));
    //     // } else {
    //     //   Tools.messageBox(message: res.message);
    //     // }
    //     Get.to(() => OPTAuth(
    //           phone: telCtl.text,
    //           selectedPays: selectedPays!,
    //         ));
    //   } else {
    //     Tools.messageBox(
    //         message: "Veuillez entrer un numéro de téléphone valide SVP.");
    //   }
    // } else {
    //   Tools.messageBox(message: "Veuillez sélectionner votre région SVP.");
    // }
  }

  Future<void> submitOtp(String code) async {
    if (code.isNotEmpty) {
      // await pr.show();
      // var res = await UserApiCtl().verifyOtp(code: code, phone: phone);
      // await pr.hide();

      Get.to(() => const RegisterPage());

      // if (res.status) {
      // } else {
      //   Tools.messageBox(message: res.message);
      // }
    }
  }

  _getPays() async {
    var res = await PaysApiCtl().getAll();
    if (res.status) {
      pays = res.data!;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getPays();
  }
}
