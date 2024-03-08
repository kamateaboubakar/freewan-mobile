import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/models/auth/credentials.dart';

class UpdatePasswordPageVctl extends ViewController {
  var oldPassCtl = TextEditingController();
  var newPassCtl = TextEditingController();
  var confirmPassCtl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var res = await UserApiCtl().updatePassword(
        oldPassword: oldPassCtl.text.trim(),
        newPassword: newPassCtl.text.trim(),
      );
      await EasyLoading.dismiss();
      if (res.status) {
        var creds = await Credentials.fromCache();
        if (creds != null) {
          creds.password = confirmPassCtl.text;
        } else {
          creds = Credentials(
            password: confirmPassCtl.text,
            phone: user.phoneNumber,
          );
        }
        await creds.save();
        await Tools.messageBox(message: "Le mot de passe a été mis à jour.");
        Get.back();
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }
}
