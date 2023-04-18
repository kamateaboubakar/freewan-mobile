import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/const/const.dart';

import 'views/static/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: Const.defaultFont.fontFamily,
      ),
      home: const SplashScreen(),
    ),
  );
}
