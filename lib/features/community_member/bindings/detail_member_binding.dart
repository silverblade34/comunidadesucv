import 'package:comunidadesucv/features/community_member/controllers/detail_member_controller.dart';
import 'package:get/get.dart';

class DetailMemberBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<DetailMemberController>(() => DetailMemberController());
  }
}