import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/links.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/location_vehicule/booking.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class LocationVehiculeCtl extends WebController {
  Future<HttpResponse<List<Car>>> getCars() async {
    try {
      var res = await get(
        "${Links.locationVehicule}/cars",
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: (body.data as List).map((e) => Car.fromJson(e)).toList(),
        );
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<Car>>> getUserCars() async {
    try {
      var res = await get(
        "${Links.locationVehicule}/user/cars",
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: (body.data as List).map((e) => Car.fromJson(e)).toList(),
        );
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<CategorieVehicule>>> getCarsCategorie() async {
    try {
      var res = await get(
        "${Links.locationVehicule}/categories",
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: (body.data as List)
              .map((e) => CategorieVehicule.fromJson(e))
              .toList(),
        );
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<Booking>> createBooking(Booking booking) async {
    try {
      var res = await post(
        "${Links.locationVehicule}/bookings",
        booking.toJson().parseToJson(),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: Booking.fromJson(body.data),
        );
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<Car>> createCar(Car car) async {
    try {
      var res = await post(
        "${Links.locationVehicule}/cars",
        car.toJson().parseToJson(),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: Car.fromJson(body.data),
        );
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
