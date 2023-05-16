import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/answer_security_question_page.dart';
import 'package:wan_mobile/views/static/auth/otp_auth.dart';
import 'package:wan_mobile/views/static/auth/register/register_page.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class PhoneAuthVctl extends ViewController {
  var telCtl = TextEditingController();
  List<Pays> pays = [];
  String? _firebaseUserId;

  Pays? selectedPays;

  bool acceptCgu = false;

  Future<void> submit() async {
    if (selectedPays?.id != null) {
      if (telCtl.text.isNotEmpty) {
        if (acceptCgu) {
          if (_firebaseUserId != null) {
            await pr.show();
            var res = await UserApiCtl().loginPhone(
              phone: telCtl.text,
              countryCode: selectedPays!.id!.toInt(),
              firebaseUserId: _firebaseUserId!,
            );
            await pr.hide();
            if (res.status) {
              Get.to(
                () => OPTAuth(
                    phone: telCtl.text,
                    selectedPays: selectedPays!,
                    onSubmit: (code) => submitOtp(code, res.data!)),
              );
            } else {
              if (res.detailErrors.contains("users_pkey")) {
                var resp =
                    await UserApiCtl().getUsersAnswer(userId: _firebaseUserId!);
                if (resp.status) {
                  resp.data!.shuffle();
                  var selectQuestion = resp.data!.first;

                  Get.to(() => AnswerSecurityQuestionPage(selectQuestion));
                } else {
                  Tools.messageBox(message: resp.message);
                }
              } else {
                Tools.messageBox(message: res.message);
              }
            }
          } else {
            Tools.messageBox(
                message: "Désolé, nous n'avons pas pu nous"
                    " authentifier avec le serveur.");
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

  Future<void> submitOtp(String code, String onlineOTP) async {
    if (code == onlineOTP) {
      Get.off(() => const RegisterPage());
    } else {
      Tools.messageBox(message: "Désolé, le code saisi n'est pas valide.");
    }
  }

  Future<void> _firebaseAnonymeAuth() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      _firebaseUserId = userCredential.user?.uid;
      update();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          Tools.messageBox(
              message:
                  "Désolé, nous n'avons pas pu nous authentifier avec le serveur.");

          break;
        default:
          Tools.messageBox(
              message:
                  "Désolé, une erreur est survenue, veuillez réessayer SVP.");
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    _firebaseAnonymeAuth();
  }
}
