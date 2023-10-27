import 'package:flutter/material.dart';

abstract class Const {
  static const String appName = "Lebedoo";
  static const String appVersion = '1.0.30';
  static const Color primaryColor = Color.fromRGBO(0, 159, 249, 1);
  static const Color secondaryColor = Color.fromRGBO(0, 0, 0, 0.5);
  static const primaryFonts = "";

  static var onlineUrl = "http://148.113.143.59:8081/api/v1";
  // static var onlineUrl = "http://148.113.143.59:8080/api/v1";
  static var gazBaseUrl = "http://148.113.143.59:8082";
  static var jobBaseUrl = "http://148.113.143.59:8083/api/v1";
  static var donationBaseUrl = "http://148.113.143.59:8084/api/v1";
  static var constructionBaseUrl = "http://148.113.143.59:8081/api/v1";
  static var pressingBaseUrl = "http://148.113.143.59:8085";
  static var boutiquerUrl = "https://freewan.io/store.lebedoo.ci";

  static var localUrl = "";
  static var defaultFont = "cooljazz";

  static String appLogo = "assets/images/lebedoo_logo.png";
  static String inLineAppLogo = "assets/images/lebedoo_inline_logo.png";

  static var devise = "Fcfa";

  static var pressingImageUrl = "http://148.113.143.59:8008/pressing";
  static const supportWhatsapp = "+2250101001437";

  static const appStoreLink = "http://148.113.143.59:8183/";
  static const playStoreLink = "http://148.113.143.59:8183/";
  static const appSlogan = "Dans LEBEDOO y'a tous dedans";
}
