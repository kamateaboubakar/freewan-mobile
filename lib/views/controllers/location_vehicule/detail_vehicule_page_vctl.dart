import 'package:flutter/material.dart';
import 'package:module_master/tools/tools.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/tools/types/types.dart';

import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/models/user.dart';

class DetailVehiculePageVctl extends ViewController {
  User? propritaire;
  Car vehicule;

  DetailVehiculePageVctl(this.vehicule);

  Future<void> fetchPropritaire() async {
    if (vehicule.ownerId != appCtl.user.accountId) {
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
