import 'package:comunidadesucv/config/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();

    bool isLogged = box.read('isLogged') ?? false;
    if (route == Routes.splash) {
      return isLogged ? const RouteSettings(name: Routes.communities) : null;
    } else if (route != Routes.profileConfiguration) {
      return isLogged
          ? null
          : const RouteSettings(name: Routes.profileConfiguration);
    } else {
      return isLogged ? const RouteSettings(name: Routes.communities) : null;
    }
  }
}
