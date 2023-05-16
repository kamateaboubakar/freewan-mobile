import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/security_question_ctl.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/models/user.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

import '../../../tools/widgets/date_time_editing_controller.dart';

class RegisterPageVctl extends ViewController {
  var pageCtl = PageController();
  var currentStep = 0;
  List<Pays> pays = [];
  // Pays selectedPays;

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
  var telCtl = TextEditingController();

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

      // switch (currentStep) {
      //   case 0: //Email
      //     if (emailFormKey.currentState!.validate()) {
      //       currentStep = 1;
      //       update();
      //     }
      //     break;
      //   case 1: //Password
      //     if (passFormKey.currentState!.validate()) {
      //       if (passwordCtl.text == confirmPasswordCtl.text) {
      //         currentStep = 2;
      //         update();
      //       } else {
      //         Tools.messageBox(
      //             message: "Les mots de passe ne sont pas identiques.");
      //       }
      //     }
      //     break;
      // }
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
      user.id = fb.FirebaseAuth.instance.currentUser?.uid;
      user.email = emailCtl.text.trim();
      user.nom = nomCtl.text.trim();
      user.prenom = prenomCtl.text.trim();
      user.dateNaissance = dateNaissanceCtl.date;
      user.password = confirmPasswordCtl.text;
      // user.securityQuestions = selectedQuestions.map((e) => e!).toList();
      var res = await UserApiCtl().register(user);
      await pr.hide();
      if (res.status) {
        var securityQuestions = selectedQuestions.map((e) => e!).toList();
        var resList = <HttpResponse<bool>>[];
        for (var q in securityQuestions) {
          res =
              await UserApiCtl().saveUsersSecuriteQuestionAnswers(q, user.id!);
          resList.add(res);
        }
        if (resList.where((e) => e.status == false).isEmpty) {
          appCtl.user = user;
          Get.offAll(() => const HomePage(displayWelcome: true));
        } else {
          Tools.messageBox(message: res.message);
        }
      } else {
        Tools.messageBox(message: res.message);
      }
      // await pr.show();
      // var user = User();
      // user.phoneNumber = telCtl.text;
      // user.email = emailCtl.text;
      // user.password = passwordCtl.text;
      // user.countryCallingCode = selectedPays.callingCode;
      // user.securityQuestions = selectedQuestions;
      // var res = await UserApiCtl().register(user);
      // await pr.hide();
      // if (res.status) {
      //   Get.offAll(() => const HomePage());
      //   Tools.showToast(
      //       message: "Votre inscription a bien été pris en compte");
      // } else {
      //   Tools.messageBox(message: res.message);
      // }
    } else {
      Tools.messageBox(
          message: "Vous devez sélectionner 5 questions de sécurités pour"
              " continuer votre inscription.");
    }
  }

  @override
  void dispose() {
    telCtl.dispose();
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
