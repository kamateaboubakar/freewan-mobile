import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/security_question_ctl.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/models/user.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

import '../../../tools/cache/cache.dart';
import '../../../tools/cache/cache_keys.dart';
import '../../../tools/widgets/date_time_editing_controller.dart';

class RegisterPageVctl extends ViewController {
  var pageCtl = PageController();
  var currentStep = 0;
  List<Pays> pays = [];
  Pays selectedPays;
  String phone;

  RegisterPageVctl(this.selectedPays, this.phone);

  SecurityQuestion q1 = SecurityQuestion();
  SecurityQuestion q2 = SecurityQuestion();
  SecurityQuestion q3 = SecurityQuestion();
  SecurityQuestion q4 = SecurityQuestion();
  SecurityQuestion q5 = SecurityQuestion();
  List<SecurityQuestion> securityQuestions = [];

  var nomCtl = TextEditingController();
  var prenomCtl = TextEditingController();
  var dateNaissanceCtl = DateTimeEditingController();
  var emailCtl = TextEditingController();
  var passwordCtl = TextEditingController();
  var confirmPasswordCtl = TextEditingController();

  var pageController = PageController();

  var infoUserFormkey = GlobalKey<FormState>();
  var passFormKey = GlobalKey<FormState>();
  var questionFormKey = GlobalKey<FormState>();

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
          if (questionFormKey.currentState!.validate()) {
            currentStep = 2;
            update();
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

      pageController.animateToPage(currentStep,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
      update();
    } else {
      //Question
      _submit();
    }
  }

  prevStep() {
    if (currentStep > 0) {
      currentStep--;
      pageController.animateToPage(currentStep,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
      update();
    }
  }

  Future<void> _submit() async {
    if (selectedQuestions
        .where((e) => e?.id == null && e?.answer == null)
        .isEmpty) {
      await pr.show();
      var user = User();
      user.email = emailCtl.text.trim();
      user.lastName = nomCtl.text.trim();
      user.firstName = prenomCtl.text.trim();
      user.phoneNumber = phone;
      user.birthDate = dateNaissanceCtl.date;
      user.countryCallingCode = selectedPays.callingCode;
      user.password = confirmPasswordCtl.text;
      user.securityQuestions = selectedQuestions.map((e) => e!).toList();
      var res = await UserApiCtl().register(user);
      await pr.hide();
      if (res.status) {
        await Cache.setString(CacheKey.credentials,
            {"phone": phone, "pays": selectedPays.toJson()}.parseToJson());
        appCtl.user = user;
        Get.offAll(() => const HomePage(displayWelcome: true));
      } else {
        Tools.messageBox(message: res.message);
      }
    } else {
      Tools.messageBox(
          message: "Vous devez sélectionner 5 questions de sécurités pour"
              " continuer votre inscription.");
    }
  }

  @override
  void dispose() {
    emailCtl.dispose();
    passwordCtl.dispose();
    super.dispose();
  }

  List<SecurityQuestion> get getAvailaibleQuestions => securityQuestions
      .where((e) => selectedQuestions.where((q) => e.id == q?.id).isEmpty)
      .toList();

  void selectQuestion({required SecurityQuestion e, required int index}) {
    var state = selectedQuestions.contains(e);
    if (!state) {
      selectedQuestions[index] = e;
      update();
    } else {
      Tools.messageBox(message: "Cette question est déjà utilisée.");
    }
  }

  Future<bool> onBack() async {
    var res = await Tools.showChoiceMessage(
        message: "Voulez-vous quitter la page d'inscription ?");
    if (res == true) {
      Get.off(() => const PhoneAuth());
      return true;
    }
    return false;
  }

  @override
  void onReady() {
    super.onReady();
    _fetchSecurityQuestion();
  }

  Future<void> _fetchSecurityQuestion() async {
    await pr.show();
    var res = await SecurityQuestionCtl().getAll();
    await pr.hide();
    if (res.status) {
      securityQuestions = res.data!;
      update();
    }
  }

  List<SecurityQuestion?> get selectedQuestions => [q1, q2, q3, q4, q5];
}
