import 'package:comunidadesucv/features/profile_configuration/controllers/profile_configuration_controller.dart';
import 'package:get/get.dart';

class ProfileConfigurationBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ProfileConfigurationController>(() => ProfileConfigurationController());
  }
}