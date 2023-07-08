import 'package:wan_mobile/api/controllers/location_vehicule/location_vehicule_ctl.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class LocationVehiculeVclt extends ViewController {
  List<Car> marketCars = [];
  List<Car> userCars = [];
  List<CategorieVehicule> categories = [];
  bool loadMarketCars = false;
  bool loadCategories = false;
  bool loadUserCars = false;
  String? userCarsError;
  String? marketCarsError;

  Future<void> fecthMarketCars() async {
    loadMarketCars = true;
    update();
    var res = await LocationVehiculeCtl().getCars();
    loadMarketCars = false;
    update();
    if (res.status) {
      marketCars = res.data!;
      update();
    } else {
      marketCarsError = res.message;
      update();
    }
  }

  Future<void> fecthUserCars() async {
    loadUserCars = true;
    update();
    var res = await LocationVehiculeCtl().getUserCars();
    loadUserCars = false;
    update();
    if (res.status) {
      userCars = res.data!;
      update();
    } else {
      userCarsError = res.message;
      update();
    }
  }

  Future<void> fecthCategories() async {
    loadCategories = true;
    update();
    var res = await LocationVehiculeCtl().getCarsCategorie();
    loadCategories = false;
    update();
    if (res.status) {
      categories = res.data!;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
    Future.wait([fecthCategories(), fecthMarketCars(), fecthUserCars()]);
  }
}
