import 'package:comunidadesucv/features/community_detail/controllers/forum_controller.dart';
import 'package:get/get.dart';

class ForumBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ForumController>(() => ForumController());
  }
}