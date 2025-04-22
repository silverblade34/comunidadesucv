import 'package:comunidadesucv/features/community_detail/controllers/list_members_controller.dart';
import 'package:get/get.dart';

class ListMembersBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ListMembersController>(() => ListMembersController());
  }
}