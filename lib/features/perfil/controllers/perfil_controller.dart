import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/communities/data/dto/user_info.dart';
import 'package:comunidadesucv/features/perfil/data/repository/perfil_repository.dart';
import 'package:comunidadesucv/features/splash/data/repository/splash_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PerfilController extends GetxController {
  final box = GetStorage();
  SplashRepository splashRepository = SplashRepository();
  PerfilRepository perfilRepository = PerfilRepository();

  final Rx<UserDetail> user = UserDetail.empty().obs;

  final RxList<UserInfo> dataUserFriendship = <UserInfo>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() async {
    isLoading.value = true;
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;

      final results = await Future.wait([
        splashRepository.getUser(user.value.account!.username),
        perfilRepository.getFriendship(),
      ]);

      user.value = results[0] as UserDetail;
      dataUserFriendship.value = results[1] as List<UserInfo>;

      box.write("user", user.value);
    } else {
      Get.snackbar("Error", "No se encontró información del usuario");
    }
    isLoading.value = false;
  }
}
