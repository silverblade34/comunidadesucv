import 'dart:io';

import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/config/routes/pages.dart';
import 'package:comunidadesucv/core/controllers/theme_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
  
void main() async {
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController(), permanent: true);

  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  WakelockPlus.enable();
  runApp(GetMaterialApp(
    title: "Comunidades digitales",
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.splash,
    theme: AppTheme.getTheme(),
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
  }
}
