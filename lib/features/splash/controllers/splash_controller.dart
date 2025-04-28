import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/splash/data/repository/splash_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController
    // ignore: deprecated_member_use
    with
        // ignore: deprecated_member_use
        SingleGetTickerProviderMixin {
  SplashRepository splashRepository = SplashRepository();
  final box = GetStorage();
  late AnimationController animationController;
  RxString code = "".obs;
  RxString username = "".obs;
  RxString name = "".obs;
  RxString lastName = "".obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    animationController.forward();
    _initData();
  }

  Future<void> _initData() async {
    // Login como Admin y se guarda el token
    final tokenAdmin = await splashRepository.loginAdmin();
    box.write("tokenAdmin", tokenAdmin);

    // Obtener tags y guardarlos
    final tags = await splashRepository.getTags();
    box.write("tags", tags);

    // Setear valores de usuario
    code.value = "2000067902";
    username.value = "daolivac";
    name.value = "DANIELA PIERINA";
    lastName.value = "OLIVA CHANTA";

    // Cargar datos de usuario
    await _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final userData = await splashRepository.getUser(username.value);
      await _saveUserSession(userData, isNewUser: false);
    } catch (e) {
      final userData = await splashRepository.getUserTrilce(
        code.value,
        username.value,
        name.value,
        lastName.value,
      );
      await _saveUserSession(userData, isNewUser: true);
    }
  }

  Future<void> _saveUserSession(UserDetail userData,
      {required bool isNewUser}) async {
    final tokenStudent = await splashRepository.authImpersonate(userData.id);

    box.write("tokenStudent", tokenStudent);
    box.write("user", userData);

    if (isNewUser) {
      Get.offAllNamed("/intro");
    } else {
      Get.offAllNamed("/intro");
    }
  }
}
