import 'package:comunidadesucv/features/intro/controllers/intro_controller.dart';
import 'package:get/get.dart';

class IntroBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<IntroController>(() => IntroController());
  }
}