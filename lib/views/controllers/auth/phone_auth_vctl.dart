import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/otp_auth.dart';
import 'package:wan_mobile/views/static/auth/password_page.dart';
import 'package:wan_mobile/views/static/auth/register/register_page.dart';

class PhoneAuthVctl extends ViewController {
  var phoneCtl = TextEditingController();
  List<Pays> pays = [];

  Pays? selectedPays;

  bool acceptCgu = false;

  Future<void> submit() async {
    if (selectedPays?.id != null) {
      if (phoneCtl.text.isNotEmpty) {
        if (acceptCgu) {
          await pr.show();
          var res = await UserApiCtl()
              .loginPhone(phone: phoneCtl.text, paysId: selectedPays!.id!);
          await pr.hide();
          if (res.status) {
            if (res.data == null) {
              await Get.to(() => PasswordPage(phone: phoneCtl.text));
            } else {
              await Get.to(
                () => OPTAuth(
                  phone: phoneCtl.text,
                  selectedPays: selectedPays!,
                  onSubmit: (code) => submitOtp(
                      code, selectedPays!.callingCode.value + phoneCtl.text),
                  resendOtp: () => submit(),
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
        Get.to(() => RegisterPage(selectedPays!, phoneCtl.text));
      } else {
        Tools.messageBox(message: res.message);
      }
    } else {
      Tools.messageBox(message: "Désolé, le code saisi n'est pas valide.");
    }
  }
}
