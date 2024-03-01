import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/models/auth/otp_session.dart';
import 'package:wan_mobile/views/static/auth/password_page.dart';
import 'package:wan_mobile/views/static/auth/register/register_page.dart';

class OtpAuthVctl extends GetxController {
  final String phone;
  final Pays selectedPays;
  OtpSession otp;

  OtpAuthVctl({
    required this.phone,
    required this.selectedPays,
    required this.otp,
  });

  Future<void> submitOtp(String code) async {
    if (code.value.isNotEmpty) {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var res = await UserApiCtl().verifyOtp(phone: phone, code: code.value);
      await EasyLoading.dismiss();
      if (res.status) {
        Get.to(() => RegisterPage(selectedPays, phone));
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
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var res = await UserApiCtl().loginPhone(
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
        otp = res.data!;
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
