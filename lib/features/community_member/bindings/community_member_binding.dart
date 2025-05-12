import 'package:comunidadesucv/features/community_member/controllers/community_member_controller.dart';
import 'package:get/get.dart';

class CommunityMemberBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CommunityMemberController>(() => CommunityMemberController());
  }
}