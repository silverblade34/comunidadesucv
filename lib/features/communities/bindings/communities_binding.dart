import 'package:comunidadesucv/features/communities/controllers/communities_controller.dart';
import 'package:get/get.dart';

class CommunitiesBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CommunitiesController>(() => CommunitiesController());
  }
}