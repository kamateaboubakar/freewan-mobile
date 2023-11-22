import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/app_theme.dart';
import 'package:tools_flutter_project/tools/env/env.dart';
import 'package:wan_mobile/tools/services/notification_service.dart';

import 'views/static/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.init();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  await Firebase.initializeApp();

  await NotificationService.setup();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    ),
  );
}
