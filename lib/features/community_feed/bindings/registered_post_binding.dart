import 'package:comunidadesucv/features/community_feed/controllers/registered_post_controller.dart';
import 'package:get/get.dart';

class RegisteredPostBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<RegisteredPostController>(() => RegisteredPostController());
  }
}