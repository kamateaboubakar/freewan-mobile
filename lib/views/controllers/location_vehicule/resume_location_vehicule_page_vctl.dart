import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/location_vehicule/location_vehicule_ctl.dart';
import 'package:wan_mobile/models/location_vehicule/booking.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/date_time_range_editing_controller.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class ResumeLocationVehiculePageVctl extends ViewController {
  Car vehicule;
  bool withDriver;
  List<CustomDateTimeRange> seletedDays;

  ResumeLocationVehiculePageVctl(
      this.vehicule, this.seletedDays, this.withDriver);

  Future<void> submit() async {
    await pr.show();
    Booking book = Booking();
    book.carId = vehicule.id;
    book.customer = null;
    book.userId = 1;
    book.destination = "Test";
    book.paymentModeId = 1;
    book.price = vehicule
        .getTotal(seletedDays.length, withDriver: withDriver)
        .toString();
    book.startDate = seletedDays.first.start.toString();
    book.endDate = seletedDays.last.end.toString();
    var res = await LocationVehiculeCtl().createBooking(book);
    await pr.hide();
    if (res.status) {
      Get.offAll(() => const HomePage());
    } else {
      Tools.messageBox(message: res.message);
    }
  }
}
