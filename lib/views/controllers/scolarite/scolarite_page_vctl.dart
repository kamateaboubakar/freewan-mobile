import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/scolarite/scolarite_api_ctl.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/scolarite/details_etudiant_page.dart';

class ScolaritePageVctl extends ViewController {
  var numIdCtl = TextEditingController();
  var anneeDebut = TextEditingController();
  var anneeFin = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      await pr.show();
      var res = await ScolariteApiCtl().searchEtudiant(
        numeroIdentification: numIdCtl.text.trim(),
        anneeScolaire: "${anneeDebut.text.trim()}-${anneeFin.text.trim()}",
      );
      await pr.hide();
      if (res.status) {
        Get.to(() => DetailsEtudiantPage(res.data!));
        numIdCtl.clear();
        anneeDebut.clear();
        anneeFin.clear();
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }
}
