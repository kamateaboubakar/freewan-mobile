import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools/env/env.dart';
import 'package:wan_mobile/firebase_options.dart';
import 'package:wan_mobile/tools/services/notification_service.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

import 'views/static/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.init();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.setup();

  runApp(
    GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routes: {
        "/home": (context) => const HomePage(),
      },
      home: const ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: SplashScreen(),
      ),
    ),
  );
}
