import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/static/splashscreen.dart';

void main() {
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}
