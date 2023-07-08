import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/location_vehicule/location_vehicule_ctl.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/models/location_vehicule/option_vehicule.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class EditionLocationVehiculeVctl extends ViewController {
  bool loadCategories = false;
  List<CategorieVehicule> categories = [];
  bool airConditioner = false;
  bool fullFuel = false;
  PageController pageController = PageController();
  CategorieVehicule? categorieVehicule;
  bool withDriver = false;
  var priceWithDriver = TextEditingController();
  var priceWithoutDriver = TextEditingController();
  var form1Key = GlobalKey<FormState>();
  var form2Key = GlobalKey<FormState>();

  Future<void> fecthCategories() async {
    loadCategories = true;
    update();
    var res = await LocationVehiculeCtl().getCarsCategorie();
    loadCategories = false;
    update();
    if (res.status) {
      categories = res.data!;
    }
  }

  void validStepOne() {
    // if (form1Key.currentState!.validate()) {
    pageController.jumpToPage(1);
    // }
  }

  Future<void> submit() async {
    if (form2Key.currentState!.validate()) {
      await pr.show();
      Car car = Car();
      car.id = categorieVehicule!.id!;
      car.priceWithDriver = priceWithDriver.text.toInt();
      car.priceWithoutDriver = priceWithoutDriver.text.toInt();
      Options op = Options();
      op.airConditoner = airConditioner.toInt();
      op.withDriver = withDriver.toInt();
      op.withFullFuel = fullFuel.toInt();
      car.options.add(op);
      var res = await LocationVehiculeCtl().createCar(car);
      await pr.hide();
      if (res.status) {
        Get.back();
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    fecthCategories();
  }
}
