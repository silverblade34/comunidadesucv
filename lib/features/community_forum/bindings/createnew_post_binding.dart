import 'package:comunidadesucv/features/community_forum/controllers/createnew_post_controller.dart';
import 'package:get/get.dart';

class CreateNewPostBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CreateNewPostController>(() => CreateNewPostController());
  }
}