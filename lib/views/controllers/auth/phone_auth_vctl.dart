import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/otp_auth.dart';
import 'package:wan_mobile/views/static/auth/password_page.dart';
import 'package:wan_mobile/views/static/auth/register/register_page.dart';

class PhoneAuthVctl extends ViewController {
  var telCtl = TextEditingController();
  List<Pays> pays = [];

  Pays? selectedPays;

  bool acceptCgu = false;

  Future<void> submit() async {
    if (selectedPays?.callingCode != null) {
      if (telCtl.text.isNotEmpty) {
        if (acceptCgu) {
          await pr.show();
          var res = await UserApiCtl()
              .loginPhone(phone: selectedPays!.callingCode.value + telCtl.text);
          await pr.hide();
          if (res.status) {
            if (res.data == true) {
              Get.to(() => PasswordPage(selectedPays!, telCtl.text));
            } else {
              Get.to(
                () => OPTAuth(
                  phone: telCtl.text,
                  selectedPays: selectedPays!,
                  onSubmit: (code) => submitOtp(
                      code, selectedPays!.callingCode.value + telCtl.text),
                  resendOtp: () => submit(),
                ),
              );
            }
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
      Tools.messageBox(message: "Le code pays n'est pas valide.");
    }

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

  Future<void> submitOtp(String code, String phone) async {
    if (code.isNotEmpty) {
      await pr.show();
      var res = await UserApiCtl().verifyOtp(phone: phone, code: code);
      await pr.hide();
      if (res.status) {
        Get.to(() => RegisterPage(selectedPays!, telCtl.text));
      } else {
        Tools.messageBox(message: res.message);
      }
    } else {
      Tools.messageBox(message: "Désolé, le code saisi n'est pas valide.");
    }
  }
}
