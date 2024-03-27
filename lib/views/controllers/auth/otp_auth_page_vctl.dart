import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/models/auth/otp_session.dart';
import 'package:wan_mobile/views/static/auth/password_page.dart';
import 'package:wan_mobile/views/static/auth/register/register_page.dart';

class OtpAuthPageVctl extends GetxController {
  final String phone;
  final Pays selectedPays;
  OtpSession otp;
  bool timerExpired = false;
  var codeCtl = TextEditingController();
  DateTime endDate;

  OtpAuthPageVctl({
    required this.phone,
    required this.selectedPays,
    required this.otp,
  }) : endDate = otp.endDate.toDateTime()!;

  Future<void> submitOtp() async {
    if (codeCtl.text.isNotEmpty) {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var res = await UserApiCtl.verifyOtp(
          fullPhone: "${selectedPays.callingCode.value}$phone",
          code: codeCtl.text);
      await EasyLoading.dismiss();
      if (res.status) {
        Get.off(() => RegisterPage(selectedPays, phone));
      } else {
        Tools.messageBox(
          title: AppConst.appName,
          message: res.message,
        );
      }
    } else {
      Tools.messageBox(
        title: AppConst.appName,
        message: "Désolé, le code saisi n'est pas valide.",
      );
    }
  }

  Future<void> resendOtp() async {
    var rep = await Tools.showChoiceMessage(
      title: AppConst.appName,
      message: "Voulez-vous vraiment renvoyer le code ?",
      secondaryColor: AssetColors.blue,
    );
    if (rep == true) {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var res = await UserApiCtl.loginPhone(
        phone: phone,
        paysId: selectedPays.id!,
      );
      await EasyLoading.dismiss();
      if (res.status) {
        if (res.data == null) {
          await Tools.messageBox(
              title: AppConst.appName,
              message: "Ce compte existe déjà. Vous serez redirigés"
                  " vers la page de mot de passe.");
          Get.off(() => PasswordPage(phone: phone));
        } else {
          await Tools.showToast(message: "Le code a bien été envoyé");
          timerExpired = false;
          otp = res.data!;
          endDate = otp.endDate.toDateTime()!;
          codeCtl.clear();
          update();
        }
      } else {
        Tools.messageBox(
          title: AppConst.appName,
          message: res.message,
        );
      }
    }
  }

  @override
  void dispose() {
    codeCtl.dispose();
    super.dispose();
  }
}
