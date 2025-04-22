import 'package:comunidadesucv/features/community_feed/controllers/community_feed_controller.dart';
import 'package:get/get.dart';

class CommunityFeedBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CommunityFeedController>(() => CommunityFeedController());
  }
}