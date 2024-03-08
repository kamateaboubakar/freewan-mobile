import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/otp_auth_page.dart';
import 'package:wan_mobile/views/static/auth/password_page.dart';

class PhoneAuthVctl extends ViewController {
  var phoneCtl = TextEditingController();
  List<Pays> pays = [];

  Pays? selectedPays;

  bool acceptCgu = false;

  Future<void> submit() async {
    if (selectedPays?.id != null) {
      if (phoneCtl.text.isNotEmpty) {
        if (acceptCgu) {
          await EasyLoading.show(maskType: EasyLoadingMaskType.black);
          var res = await UserApiCtl().loginPhone(
            phone: phoneCtl.text,
            paysId: selectedPays!.id!,
          );
          await EasyLoading.dismiss();

          if (res.status) {
            if (res.data == null) {
              await Get.to(() => PasswordPage(phone: phoneCtl.text));
            } else {
              await Get.to(
                () => OPTAuthPage(
                  phone: phoneCtl.text,
                  selectedPays: selectedPays!,
                  otp: res.data!,
                ),
              );
            }
            phoneCtl.clear();
            selectedPays = null;
            acceptCgu = false;
            update();
          } else {
            Tools.messageBox(message: res.message);
          }
        } else {
          Tools.messageBox(
              message: "Veuillez accepter les conditions d'utilisation.");
        }
      } else {
        Tools.messageBox(
            message: "Veuillez saisir un numéro de téléphone valide SVP.");
      }
    } else {
      Tools.messageBox(message: "Veuillez sélectionner un pays valide SVP.");
    }
  }
}
