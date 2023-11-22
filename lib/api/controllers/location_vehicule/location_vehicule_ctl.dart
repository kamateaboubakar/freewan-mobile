import 'dart:io';

import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:wan_mobile/api/abstracts/links.dart';

import 'package:wan_mobile/models/location_vehicule/booking.dart';
import 'package:wan_mobile/models/location_vehicule/car.dart';
import 'package:wan_mobile/models/location_vehicule/categorie_vehicule.dart';
import 'package:wan_mobile/models/location_vehicule/marque_vehicule.dart';
import 'package:wan_mobile/models/location_vehicule/mode_paiement.dart';
import 'package:wan_mobile/models/location_vehicule/option_vehicule.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:wan_mobile/tools/types/types.dart';

class LocationVehiculeCtl {
  Future<HttpResponse<List<Car>>> getCars() async {
    try {
      var res = await WebRequest.nativRequest(
        "${Links.locationVehicule}/cars",
        headers: AppHttpHeaders.headers,
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
      var res = await WebRequest.nativRequest(
        "${Links.locationVehicule}/cars/user/$userId",
        headers: AppHttpHeaders.headers,
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
      var res = await WebRequest.nativRequest(
        "${Links.locationVehicule}/categories",
        headers: AppHttpHeaders.headers,
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
      var res = await WebRequest.nativRequest(
        "${Links.locationVehicule}/brands",
        headers: AppHttpHeaders.headers,
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
      var res = await WebRequest.nativRequest(
        "${Links.locationVehicule}/bookings",
        verbe: RequestVerbeEnum.POST,
        body: booking.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
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
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${Links.locationVehicule}/cars",
        body: car.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
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
      var res = await WebRequest.multipartRequest(
        url: "${Links.locationVehicule}/cars-photos/upload/car/$carId",
        verbe: RequestVerbeEnum.POST,
        files: images.map((e) => File(e)).toList(),
      );

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
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${Links.locationVehicule}/options",
        body: op.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
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
      var res = await WebRequest.nativRequest(
        "${Links.locationVehicule}/payment-mode",
        headers: AppHttpHeaders.headers,
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
