import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/pays_api_ctl.dart';
import 'package:wan_mobile/api/controllers/marchand/marchand_api.dart';
import 'package:wan_mobile/models/marchand/marchand_request.dart';

class MarchandRegisterPageVctl extends ViewController {
  var formKey = GlobalKey<FormState>();
  var nomCtl = TextEditingController();
  var prenomCtl = TextEditingController();
  var emailCtl = TextEditingController();
  var telCtl = TextEditingController();
  var tel2Ctl = TextEditingController();
  var passwordCtl = TextEditingController();
  var confirmPasswordCtl = TextEditingController();
  Pays? selectedPays;
  bool hidePass = true;

  Future<List<Pays>> getPays() async {
    var res = await PaysApiCtl.getAll();
    if (res.status) {
      return res.data!;
    } else {
      return [];
    }
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      var marchand = MarchandRequest();
      marchand.nom = nomCtl.text;
      marchand.prenoms = prenomCtl.text;
      marchand.email = emailCtl.text;
      marchand.tel = telCtl.text;
      marchand.tel2 = tel2Ctl.text;
      marchand.password = passwordCtl.text;
      marchand.countryId = selectedPays?.id;
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var res = await MarchandApi.register(marchand);
      await EasyLoading.dismiss();
      if (res.status) {
        await Tools.messageBox(
            message: "Le compte marchand a été crée avec succès.");
        Get.back();
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }
}
