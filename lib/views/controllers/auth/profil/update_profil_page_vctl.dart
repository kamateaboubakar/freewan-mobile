import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';

class UpdateProfilPageVctl extends ViewController {
  var firtNameCtl = TextEditingController();
  var lastNameCtl = TextEditingController();
  var emailCtl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      await EasyLoading.show();
      var res = await UserApiCtl().updateProfil(
        firstName: firtNameCtl.text.trim(),
        lastName: lastNameCtl.text.trim(),
        email: emailCtl.text.trim(),
      );
      await EasyLoading.dismiss();
      if (res.status) {
        appCtl.user = res.data!;
        Tools.messageBox(message: "Le profil a été mis à jour.");
        Get.back();
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }
}
