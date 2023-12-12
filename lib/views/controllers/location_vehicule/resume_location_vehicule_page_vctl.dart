import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/location_model.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/location_vehicule/location_vehicule_ctl.dart';
import 'package:wan_mobile/models/location_vehicule/booking.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/models/location_vehicule/mode_paiement.dart';

import 'package:wan_mobile/tools/widgets/date_time_range_editing_controller.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class ResumeLocationVehiculePageVctl extends ViewController {
  Car vehicule;
  bool withDriver;
  List<CustomDateTimeRange> seletedDays;
  LocationModel? locationModel;
  List<ModePaiement> modePaiements = [];

  ModePaiement? selectedModePaiement;

  ResumeLocationVehiculePageVctl(
      this.vehicule, this.seletedDays, this.withDriver);

  Future<void> submit() async {
    if (locationModel?.title != null) {
      if (selectedModePaiement != null) {
        await pr.show();
        Booking book = Booking();
        book.carId = vehicule.id;
        // book.customer = appCtl.user.fullName;
        book.userId = appCtl.user.id.value.toString();
        book.destination = locationModel!.title;
        book.paymentModeId = selectedModePaiement!.id;
        book.lat = locationModel!.latitude;
        book.long = locationModel!.longitude;
        book.price = vehicule
            .getTotal(seletedDays.length, withDriver: withDriver)
            .toString();
        book.startDate = seletedDays.first.start.date?.toNotIsoFormat();
        book.endDate = seletedDays.last.end.date?.toNotIsoFormat();
        book.creditCardOrPhoneNumber = appCtl.user.phoneNumber;

        var res = await LocationVehiculeCtl().createBooking(book);
        await pr.hide();
        if (res.status) {
          Get.offAll(() => const HomePage());
        } else {
          Tools.messageBox(message: res.message);
        }
      } else {
        Tools.messageBox(
            message: "Veuillez sélectionner un mode de paiement.");
      }
    } else {
      Tools.messageBox(message: "Veuillez sélectionner une destination.");
    }
  }

  Future<void> requestPermissionForLocation() async {
    await pr.show();

    var hasLocationPermission = await LocationService.hasLocationPermission();
    await pr.hide();
    if (hasLocationPermission) {
      locationModel =
          await LocationService.getLocation(withLocationDescription: true);
      update();
      return;
    }
    Tools.messageBox(
      message:
          "WAN a besoin d'accéder à votre position pour trouver les services les plus proches de vous",
      onConfirm: () async {
        await pr.show();
        var isGranted = await LocationService.requestLocationPermission();
        await pr.hide();
        if (!isGranted) {
          Get.back();
          return;
        }
        await pr.show();
        locationModel =
            await LocationService.getLocation(withLocationDescription: true);

        await pr.hide();
        update();
      },
    );
  }

  Future<void> fetchModePaiements() async {
    await pr.show();
    var res = await LocationVehiculeCtl().fetchModePaiements();
    await pr.hide();
    if (res.status) {
      modePaiements = res.data!;
      update();
    } else {
      Tools.messageBox(
          message:
              "Désolé, nous n'avons pas pu charger les moyens de paiement.");
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchModePaiements();
  }
}
