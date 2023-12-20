import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/location_model.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/adresse_api_ctl.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

class EditionAdresseVctl extends ViewController {
  var labelCtl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var location = LocationModel(latitude: 0, longitude: 0);
  Adresse? adresse;

  EditionAdresseVctl({this.adresse});

  Future<void> getLocation() async {
    await pr.show();
    location = await LocationService.getLocation(withLocationDescription: true);
    await pr.hide();
    update();
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      HttpResponse<Adresse> res;
      if (adresse?.id == null) {
        adresse = initItem(Adresse());
        await pr.show();
        res = await AdresseApiCtl().createAdresse(adresse!);
        await pr.hide();
      } else {
        await pr.show();
        adresse = initItem(adresse!);
        res = await AdresseApiCtl().updateAdresse(adresse!);
        await pr.hide();
      }
      if (res.status) {
        await Tools.showToast();
        Get.back(result: true);
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }

  Adresse initItem(Adresse item) {
    item.libelle = labelCtl.text;
    item.locationLabel = location.title;
    item.latitude = location.latitude;
    item.longitude = location.longitude;
    return item;
  }

  @override
  void onReady() async {
    super.onReady();
    if (adresse != null) {
      labelCtl.text = adresse!.libelle.value;

      await pr.show();
      var title = await LocationService.getPlaceDescription(
          adresse!.latitude!, adresse!.longitude!);
      await pr.hide();

      location = LocationModel(
          latitude: adresse!.latitude!,
          longitude: adresse!.longitude!,
          title: title);
      update();
    }
  }
}
