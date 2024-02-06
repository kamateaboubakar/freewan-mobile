import 'package:date_format/date_format.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wan_mobile/tools/const/const.dart';

class Functions {
  static List<Map<String, String>> months = [
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

  static Map<String, String> getMonthLib(DateTime date) {
    var index = date.month - 1;
    return months[index];
  }

  static int? getMonthIndex(String month, {bool lite = true}) {
    int? index;
    if (lite) {
      index = months.indexWhere((element) => element["lite"] == month);
    } else {
      index = months.indexWhere((element) => element["full"] == month);
    }

    if (index == -1) {
      return null;
    } else {
      return index + 1;
    }
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
      return "$day ${getMonthLib(date)[mode]!} $year${(withTime) ? separator + getTime(date) : ""}";
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

  static String formatMontant(String? montant, {bool withDevise = true}) {
    if (montant != null && montant != "null") {
      NumberFormat format = NumberFormat.currency(
          locale: 'fr_FR',
          symbol: withDevise ? Const.devise : "",
          decimalDigits: 0);

      var amount = num.tryParse(montant) ?? 0;
      return format.format(amount).trim();
    }
    if (withDevise) {
      return "0 ${Const.devise}";
    }
    return "0";
  }

  static Future<String?> getFcmToken() async {
    try {
      return FirebaseMessaging.instance.getToken();
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return null;
    }
  }

  static Future<void> shareAppText({required String codeParrain}) async {
    Share.share(
        """😀 hey, inscris-toi sur *${AppConst.appName}* avec mon code de parrain : *$codeParrain*

Le premier Hub de service ivoirien totalement digital.

Téléchargez directement l'application sur :
AppStore : ${Const.appStoreLink}
PlayStore : ${Const.playStoreLink}

🥳🥳 ${Const.appSlogan}""");
  }
}
