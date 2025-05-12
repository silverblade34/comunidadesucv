import 'package:comunidadesucv/features/community_forum/controllers/community_forum_controller.dart';
import 'package:get/get.dart';

class CommunityForumBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CommunityForumController>(() => CommunityForumController());
  }
}