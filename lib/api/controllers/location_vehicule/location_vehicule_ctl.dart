import 'dart:io';

import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/links.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/location_vehicule/booking.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/models/location_vehicule/marque_vehicule.dart';
import 'package:wan_mobile/models/location_vehicule/mode_paiement.dart';
import 'package:wan_mobile/models/location_vehicule/option_vehicule.dart';
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

  Future<HttpResponse<List<Car>>> getUserCars(String userId) async {
    try {
      var res = await get(
        "${Links.locationVehicule}/cars/user/$userId",
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

  Future<HttpResponse<List<MarqueVehicule>>> fetchMarque() async {
    try {
      var res = await get(
        "${Links.locationVehicule}/brands",
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: (body.data as List)
              .map((e) => MarqueVehicule.fromJson(e))
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

  Future<HttpResponse<bool>> updateImagesCar(
      List<String> images, int carId) async {
    try {
      // /cars-photos/upload/car/{id}
      var res = await (await multiPartclient2(
        "POST",
        Uri.parse("${Links.locationVehicule}/cars-photos/upload/car/$carId"),
        files: images.map((e) => File(e)).toList(),
      ))
          .send();
      if ([200, 201].contains(res.statusCode)) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<Options>> createOption(Options op) async {
    try {
      var res = await post(
        "${Links.locationVehicule}/options",
        op.toJson().parseToJson(),
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: Options.fromJson(body.data),
        );
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<ModePaiement>>> fetchModePaiements() async {
    try {
      var res = await get(
        "${Links.locationVehicule}/payment-mode",
        headers: HttpClientConst.headers,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data:
              (body.data as List).map((e) => ModePaiement.fromJson(e)).toList(),
        );
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
