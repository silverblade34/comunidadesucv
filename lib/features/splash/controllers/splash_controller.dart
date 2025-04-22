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
    await Future.delayed(Duration(seconds: 3));

    code.value = "2000067902";
    username.value = "daolivac";
    name.value = "DANIELA PIERINA";
    lastName.value = "OLIVA CHANTA";
    await _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      var userData = await splashRepository.getUser(username.value);
      List<String> tags = await splashRepository.getTags();
      box.write("tags", tags);
      box.write("user", userData);
      Get.offAllNamed("/intro");
    } catch (e) {
      var userData = await splashRepository.getUserTrilce(
          code.value, username.value, name.value, lastName.value);
      List<String> tags = await splashRepository.getTags();
      box.write("tags", tags);
      box.write("user", userData);
      Get.offAllNamed("/intro");
    }
  }
}
