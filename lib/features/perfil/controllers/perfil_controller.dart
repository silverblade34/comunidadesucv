import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/splash/data/repository/splash_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PerfilController extends GetxController {
  final box = GetStorage();
  SplashRepository splashRepository = SplashRepository();
  final Rx<UserDetail> user = UserDetail(
      id: 0,
      guid: '',
      displayName: '',
      url: '',
      account: null,
      profile: null,
      spaces: []).obs;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  void _loadUser() async {
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;
      user.value = await splashRepository.getUser(user.value.account!.username);
      box.write("user", user.value);
    } else {
      Get.snackbar("Error", "No se encontró información del usuario");
    }
  }
}
