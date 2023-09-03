import 'package:wan_mobile/api/controllers/location_vehicule/location_vehicule_ctl.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class LocationVehiculeVclt extends ViewController {
  List<Car> _marketCars = [];
  List<Car> userCars = [];
  List<CategorieVehicule> categories = [];
  bool loadMarketCars = false;
  bool loadCategories = false;
  bool loadUserCars = false;
  String? userCarsError;
  String? marketCarsError;
  int? selectedCategorie;
  String search = "";

  Future<void> fecthMarketCars() async {
    loadMarketCars = true;
    update();
    var res = await LocationVehiculeCtl().getCars();
    loadMarketCars = false;
    update();
    if (res.status) {
      _marketCars = res.data!;
      update();
    } else {
      marketCarsError = res.message;
      update();
    }
  }

  Future<void> fecthUserCars() async {
    loadUserCars = true;
    update();
    var res =
        await LocationVehiculeCtl().getUserCars(appCtl.user.accountId.value);
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
      marketCarsError = "";
      categories = res.data!;
      update();
    } else {
      marketCarsError = res.message;
      update();
    }
  }

  Future<void> fecthData() async {
    fecthMarketCars();
    fecthUserCars();
    fecthCategories();
  }

  @override
  void onReady() {
    super.onReady();
    Future.wait([fecthCategories(), fecthMarketCars(), fecthUserCars()]);
  }

  List<Car> get getMarketCars {
    var finalCars = _marketCars;
    if (selectedCategorie != null) {
      finalCars =
          _marketCars.where((e) => e.categoryId == selectedCategorie).toList();
    }

    if (search.isNotEmpty) {
      finalCars = finalCars
          .where((e) =>
              e.brand?.name.value
                  .toLowerCase()
                  .contains(search.toLowerCase()) ==
              true)
          .toList();
      // finalCars = finalCars
      //     .where(
      //         (e) => e.model.value.toLowerCase().contains(search.toLowerCase()))
      //     .toList();
    }
    return finalCars;
  }
}
