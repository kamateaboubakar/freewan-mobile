import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/models/auth/credentials.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class RegisterPageVctl extends ViewController {
  var currentStep = 0;
  List<Pays> pays = [];
  Pays selectedPays;
  String phone;

  RegisterPageVctl(this.selectedPays, this.phone);

  List<SecurityQuestion> selectedQuestions =
      List.generate(5, (index) => SecurityQuestion());

  List<SecurityQuestion> securityQuestions = [];

  var nomCtl = TextEditingController();
  var prenomCtl = TextEditingController();
  var dateNaissanceCtl = DateTimeEditingController();
  var emailCtl = TextEditingController();
  var passwordCtl = TextEditingController();
  var confirmPasswordCtl = TextEditingController();

  var infoUserFormkey = GlobalKey<FormState>();
  var passFormKey = GlobalKey<FormState>();

  nextStep() {
    if (currentStep < 4) {
      switch (currentStep) {
        case 0:
          if (infoUserFormkey.currentState!.validate()) {
            currentStep = 1;
            update();
          }
          break;
        case 1:
          if (!selectedQuestions.any((e) => e.id == null)) {
            currentStep = 2;
            update();
          } else {
            Tools.messageBox(
                title: AppConst.appName,
                message:
                    "Veuillez sélectionner 5 questions de securité avant de continuer.");
          }
          break;
        case 2:
          if (passwordCtl.text == confirmPasswordCtl.text) {
            _submit();
          } else {
            Tools.messageBox(
                message: "Les mots de passe ne correspondent pas.");
          }
      }
      update();
    } else {
      //Question
      _submit();
    }
  }

  prevStep() {
    if (currentStep > 0) {
      currentStep--;
      update();
    }
  }

  Future<void> _submit() async {
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var user = User();
    user.email = emailCtl.text.trim().toLowerCase();
    user.lastName = nomCtl.text.trim();
    user.firstName = prenomCtl.text.trim();
    user.phoneNumber = phone;
    user.birthDate = dateNaissanceCtl.date;
    user.countryCallingCode = selectedPays.callingCode;
    user.password = confirmPasswordCtl.text;
    user.securityQuestions = selectedQuestions.map((e) => e).toList();
    var res = await UserApiCtl.register(user, selectedPays.id.value);
    await EasyLoading.dismiss();
    if (res.status) {
      var creds = Credentials(phone: phone, password: passwordCtl.text);
      await creds.save();
      appCtl.user = res.data!;
      Get.offAll(() => const HomePage(displayWelcome: true));
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void dispose() {
    emailCtl.dispose();
    passwordCtl.dispose();
    super.dispose();
  }

  Future<bool> onBack() async {
    var res = await Tools.showChoiceMessage(
        title: AppConst.appName,
        message: "Voulez-vous quitter la page d'inscription ?");
    if (res == true) {
      Get.off(() => const PhoneAuth());
      return true;
    }
    return false;
  }
}
