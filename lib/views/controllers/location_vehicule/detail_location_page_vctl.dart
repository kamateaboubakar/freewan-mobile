import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/date_time_range_editing_controller.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/location_vehicule/location/resume_location_vehicule_page.dart';

class DetailLocationVehiculePageVctl extends ViewController {
  List<CustomDateTimeRange> seletedDays = [];
  DateTime? focusedDay;
  bool withDriver = false;
  var scrollController = ScrollController();
  Car vehicule;

  DetailLocationVehiculePageVctl(this.vehicule);

  void checkDate() {
    bool check = false;
    for (var e in seletedDays) {
      if (e.start.date!.isAfter(e.end.date!) ||
          e.start.date!.isAtSameMomentAs(e.end.date!)) {
        check = true;
        break;
      }
    }
    if (check == false) {
      Get.to(
        () => ResumeLocationVehiculePage(vehicule, seletedDays,
            withDriver: withDriver),
      );
    } else {
      Tools.messageBox(
          message: "Vous avez fait une erreur de saisie sur les heures. "
              "Veuillez vérifier vos saisies.");
    }
  }
}
