import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

class DetailVehiculePageVctl extends ViewController {
  User? propritaire;
  Car vehicule;

  DetailVehiculePageVctl(this.vehicule);

  Future<void> fetchPropritaire() async {
    if (vehicule.ownerId != appCtl.user.id) {
      await pr.show();
      var res = await UserApiCtl().getUserProfilById(vehicule.ownerId.value);
      await pr.hide();
      if (res.status) {
        propritaire = res.data!;
        update();
      } else {
        Tools.showToast(
            color: Colors.amber,
            message: "Nous n'avons pas pu récuperer "
                "les informations du propritaire.");
      }
    } else {
      propritaire = appCtl.user;
      update();
    }
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   fetchPropritaire();
  // }
}
