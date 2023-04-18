import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Const {
  static const String appName = "WAN";
  static const String appVersion = '1.0.0';
  static const Color primaryColor = Color.fromRGBO(0, 159, 249, 1);
  static const Color secondaryColor = Color.fromRGBO(0, 0, 0, 0.5);
  static const primaryFonts = "";

  static var onlineUrl = "http://148.113.143.59:8080/api/v1";
  static var localUrl = "";
  static var defaultFont = GoogleFonts.poppins();
}
