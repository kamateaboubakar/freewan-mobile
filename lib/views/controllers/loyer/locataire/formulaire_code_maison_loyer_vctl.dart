import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/loyer/loyer_api_ctl.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/loyer/locataire/paiement_loyer_page.dart';

class FormulaireCodeMaisonLoyerVctl extends ViewController {
  var codeCtl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      await pr.show();
      var res = await LoyerApiCtl().getHabitatByCode(codeCtl.text);
      await pr.hide();
      if (res.status) {
        codeCtl.clear();
        Get.to(() => PaiementLoyerPage(res.data!));
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }
}
