import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Functions {
  static Map<String, String> _getMonthLib(DateTime date) {
    var months = [
      {"lite": "Jan.", "full": "Janvier"},
      {"lite": "Fev.", "full": "Février"},
      {"lite": "Mars", "full": "Mars"},
      {"lite": "Avr.", "full": "Avril"},
      {"lite": "Mai.", "full": "Mai"},
      {"lite": "Juin", "full": "Juin"},
      {"lite": "Juil.", "full": "Juillet"},
      {"lite": "Août", "full": "Août"},
      {"lite": "Sept.", "full": "Septembre"},
      {"lite": "Oct.", "full": "Octobre"},
      {"lite": "Nov.", "full": "Novembre"},
      {"lite": "Dec.", "full": "Décembre"},
    ];
    var index = date.month - 1;
    return months[index];
  }

  static String getDate(DateTime? date,
      {bool withTime = false,
      String divider = "/",
      String dateTimeDivider = " "}) {
    return (date == null)
        ? ""
        : formatDate(
            date,
            withTime
                ? [dd, divider, mm, divider, yyyy, dateTimeDivider, HH, ":", nn]
                : [dd, divider, mm, divider, yyyy]);
  }

  static String getStringDate(DateTime? date,
      {bool fullMonth = false,
      bool withTime = false,
      String separator = " à "}) {
    var mode = fullMonth ? "full" : "lite";
    if (date != null) {
      var day =
          date.day.toString().length < 2 ? "0${date.day}" : date.day.toString();
      var year = date.year.toString();
      return "$day ${_getMonthLib(date)[mode]!} $year${(withTime) ? separator + getTime(date) : ""}";
    }
    return "";
  }

  static String getTime(DateTime? dateTime) {
    return (dateTime == null) ? "" : formatDate(dateTime, [HH, ':', nn]);
  }

  static Future<bool?> isFirstLaunch() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool("firstLaunch");
  }

  static Future<bool?> setIsFirstLaunch() async {
    var pref = await SharedPreferences.getInstance();
    return pref.setBool("firstLaunch", false);
  }

  // static Future<HttpResponse<Position>> getPostion() async {
  //   try {
  //     bool serviceEnabled;
  //     LocationPermission permission;
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       return HttpResponse.error(
  //           message: "Le service de localisation est désactivé.");
  //     }

  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         return HttpResponse.error(
  //             message: "Les autorisations de localisation sont refusées");
  //       }
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       return HttpResponse.error(
  //           message:
  //               "Les autorisations de localisation sont définitivement refusées,"
  //               " nous ne pouvons pas demander d'autorisations.");
  //     }

  //     return HttpResponse.success(data: await Geolocator.getCurrentPosition());
  //   } catch (e) {
  //     print(e);
  //     return HttpResponse.error(
  //         message: "Désolé, une erreur est survenue. Veuillez réessayer.");
  //   }
  // }

  // static Future<String?> getFcmToken() async {
  //   try {
  //     String? token;
  //     FirebaseMessaging.instance.getToken().then((value) {
  //       token = value;
  //     }, onError: (obj) {
  //       token = null;
  //     });
  //     return token;
  //   } catch (e, st) {
  //     if (kDebugMode) {
  //       print(st);
  //     }
  //     return null;
  //   }
  // }
}
