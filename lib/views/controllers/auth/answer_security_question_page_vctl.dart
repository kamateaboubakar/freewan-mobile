import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools/types/map.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
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
        await Cache.setString(CacheKey.login.name,
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
