import 'package:comunidadesucv/features/perfil/controllers/friendships_controller.dart';
import 'package:get/get.dart';

class FriendshipsBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<FriendshipsController>(() => FriendshipsController());
  }
}