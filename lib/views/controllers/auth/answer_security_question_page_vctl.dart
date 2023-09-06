import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/tools/cache/cache.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class AnswerSecurityQuestionPageVctl extends ViewController {
  SecurityQuestion question;
  String phone;
  String password;

  var answerCtl = TextEditingController();
  AnswerSecurityQuestionPageVctl({
    required this.question,
    required this.phone,
    required this.password,
  });

  Future<void> submit() async {
    if (answerCtl.text.isNotEmpty) {
      await pr.show();
      var res = await UserApiCtl().answerSecurityQuestionLogin(
          phone: phone,
          securityQuestionId: question.id!,
          answer: answerCtl.text);
      await pr.hide();
      if (res.status) {
        await Cache.setString(CacheKey.login,
            {"phone": phone, "password": password}.parseToJson());
        appCtl.user = res.data!;
        Get.offAll(() => const HomePage());
      } else {
        Tools.messageBox(message: res.message);
      }
    } else {
      Tools.messageBox(message: "Réponse incorrecte.");
    }
  }

  @override
  void dispose() {
    answerCtl.dispose();
    super.dispose();
  }
}
