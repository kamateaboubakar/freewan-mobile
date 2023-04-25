import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/api/controllers/security_question_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class RegisterPageVctl extends ViewController {
  var pageCtl = PageController();
  var currentStep = 0;
  List<Pays> pays = [];
  // Pays selectedPays;
  List<SecurityQuestion> securityQuestions = [];
  List<SecurityQuestion> selectedQuestions =
      List.generate(5, (index) => SecurityQuestion());

  late ProgressDialog pr;
  var emailCtl = TextEditingController();
  var passwordCtl = TextEditingController();
  var confirmPasswordCtl = TextEditingController();
  var telCtl = TextEditingController();

  var pageController = PageController();

  var emailFormKey = GlobalKey<FormState>();
  var passFormKey = GlobalKey<FormState>();
  var questionFormKey = GlobalKey<FormState>();

  RegisterPageVctl() : pr = Tools.progressDialog();

  Future<void> getData() async {
    await _getSecurityQuestion();
  }

  _getSecurityQuestion() async {
    var res = await SecurityQuestionCtl().getAll();
    if (res.status) {
      securityQuestions = res.data!;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  nextStep() {
    // if (currentStep < 2) {
    //   currentStep++;
    //   // switch (currentStep) {
    //   //   case 0: //Email
    //   //     if (emailFormKey.currentState!.validate()) {
    //   //       currentStep = 1;
    //   //       update();
    //   //     }
    //   //     break;
    //   //   case 1: //Password
    //   //     if (passFormKey.currentState!.validate()) {
    //   //       if (passwordCtl.text == confirmPasswordCtl.text) {
    //   //         currentStep = 2;
    //   //         update();
    //   //       } else {
    //   //         Tools.messageBox(
    //   //             message: "Les mots de passe ne sont pas identiques.");
    //   //       }
    //   //     }
    //   //     break;
    //   // }
    //   pageController.animateToPage(currentStep,
    //       duration: const Duration(milliseconds: 500), curve: Curves.ease);
    // } else {
    //   //Question
    //   _submit();
    // }
  }

  prevStep() {
    if (currentStep > 0) {
      currentStep--;
      update();
    }
  }

  Future<void> _submit() async {
    if (selectedQuestions.where((e) => e.securityQuestionId == null).isEmpty) {
      if (questionFormKey.currentState!.validate()) {
        Get.offAll(() => const HomePage());
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
      }
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
      .where((e) => selectedQuestions
          .where((q) => e.securityQuestionId == q.securityQuestionId)
          .isEmpty)
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

  setResponseQuestion({required int index, required String value}) {
    selectedQuestions[index].answer = value;
    update();
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
}
