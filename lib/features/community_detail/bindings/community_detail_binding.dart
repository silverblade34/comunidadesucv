import 'package:comunidadesucv/features/community_detail/controllers/community_detail_controller.dart';
import 'package:get/get.dart';

class CommunityDetailBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CommunityDetailController>(() => CommunityDetailController());
  }
}