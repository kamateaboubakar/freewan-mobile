import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/location_vehicule/location_vehicule_ctl.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/models/location_vehicule/marque_vehicule.dart';
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
  MarqueVehicule? marqueVehicule;
  var modeleVehiculeCtl = TextEditingController();
  var anneeVehiculeCtl = TextEditingController();
  var vitesseMaxCtl = TextEditingController();
  String? transmission;
  var plaqueImmatriculation = TextEditingController();
  String? energie;
  var couleur = TextEditingController();
  var nbPlaces = TextEditingController();
  var moteur = TextEditingController();
  var puissance = TextEditingController();
  var images = <String>[];
  int? carUploadedId;

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
    if (form1Key.currentState!.validate()) {
      if (categorieVehicule != null) {
        pageController.jumpToPage(1);
      } else {
        Tools.messageBox(
            message: "Veuillez sélectionner une catégorie de véhicule");
      }
    }
  }

  void validStepTwo() {
    if (form2Key.currentState!.validate()) {
      pageController.jumpToPage(2);
    }
  }

  Future<void> submit() async {
    if (images.isNotEmpty) {
      await pr.show();
      Car car = Car();
      car.categoryId = categorieVehicule?.id;
      car.brandId = marqueVehicule?.id;
      car.model = modeleVehiculeCtl.text;
      car.ownerId = appCtl.user.id.value.toString();
      car.year = anneeVehiculeCtl.text;
      car.maxSpeed = vitesseMaxCtl.text;
      car.transmission = transmission;
      car.plateNumber = plaqueImmatriculation.text;
      car.energy = energie;
      car.priceWithDriver = priceWithDriver.text.toInt();
      car.priceWithoutDriver = priceWithoutDriver.text.toInt();
      car.power = puissance.text;
      car.motor = moteur.text;
      car.color = couleur.text;
      car.seats = nbPlaces.text.toInt();

      var res = await LocationVehiculeCtl().createCar(car);
      await pr.hide();
      if (res.status) {
        car = res.data!;
        //Option
        var op = Options();
        op.airConditoner = airConditioner.toInt();
        op.withDriver = withDriver.toInt();
        op.withFullFuel = fullFuel.toInt();
        op.carId = car.id;

        var resOp = await LocationVehiculeCtl().createOption(op);
        if (resOp.status) {
          await pr.show();
          var result = await LocationVehiculeCtl()
              .updateImagesCar(images, res.data!.id!);
          await pr.hide();
          if (result.status) {
            Get.back(result: true);
          } else {
            Tools.messageBox(message: result.message);
          }
        } else {
          Tools.messageBox(message: resOp.message);
        }
      } else {
        Tools.messageBox(message: res.message);
      }
    } else {
      Tools.messageBox(
          message: "Veuillez ajouter une image ou plusieurs images.");
    }
  }

  @override
  void onReady() {
    super.onReady();
    fecthCategories();
  }

  Future<List<MarqueVehicule>> fetchMarque() async {
    var res = await LocationVehiculeCtl().fetchMarque();
    return res.data!;
  }
}
