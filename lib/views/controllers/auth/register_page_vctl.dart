import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/api/controllers/pays_api_ctl.dart';
import 'package:wan_mobile/api/controllers/security_question_ctl.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/models/user.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/otp_auth.dart';

class RegisterPageVctl extends ViewController {
  var pageCtl = PageController();
  var currentStep = 0;
  List<Pays> pays = [];
  Pays? selectedPays;
  List<SecurityQuestion> securityQuestions = [];
  List<SecurityQuestion> selectedQuestions = [];
  var form1 = GlobalKey<FormState>();
  var form2 = GlobalKey<FormState>();
  late ProgressDialog pr;
  var emailCtl = TextEditingController();
  var passwordCtl = TextEditingController();
  var telCtl = TextEditingController();
  var hidePass = true;

  RegisterPageVctl() : pr = Tools.progressDialog();

  Future<void> getData() async {
    await _getPays();
    await _getSecurityQuestion();
  }

  _getPays() async {
    var res = await PaysApiCtl().getAll();
    if (res.status) {
      pays = res.data!;
      update();
    } else {
      print(res.message);
    }
  }

  _getSecurityQuestion() async {
    var res = await SecurityQuestionCtl().getAll();
    if (res.status) {
      securityQuestions = res.data!;
      update();
    } else {
      print(res.message);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  nextStep() {
    if (currentStep < 2) {
      switch (currentStep) {
        case 0:
          if (form1.currentState!.validate()) {
            currentStep = 1;
            update();
          }
          break;
        case 1:
          if (selectedQuestions.length == 5) {
            currentStep = 2;
            update();
          } else {
            Get.snackbar(
                "Message", "Vous devez sélectionner au moins 5 questions");
          }
          break;
      }
    } else {
      submit();
    }
  }

  prevStep() {
    if (currentStep > 0) {
      currentStep--;
      update();
    }
  }

  Future<void> submit() async {
    if (form2.currentState!.validate()) {
      await pr.show();
      var user = User();
      user.phoneNumber = telCtl.text;
      user.email = emailCtl.text;
      user.password = passwordCtl.text;
      user.countryCallingCode = selectedPays!.callingCode;
      user.securityQuestions = selectedQuestions;
      // user.email
      var res = await UserApiCtl().register(user);
      await pr.hide();
      if (res.status) {
        Get.offAll(() => OPTAuth(phone: telCtl.text));
        Tools.showToast(message: "Votre inscription a bien été pris en compte");
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }

  @override
  void dispose() {
    telCtl.dispose();
    emailCtl.dispose();
    passwordCtl.dispose();
    super.dispose();
  }
}
