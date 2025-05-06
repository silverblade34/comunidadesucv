import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/core/models/user_friendship.dart';
import 'package:comunidadesucv/features/perfil/data/repository/perfil_repository.dart';
import 'package:comunidadesucv/features/splash/data/repository/splash_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PerfilController extends GetxController {
  final box = GetStorage();
  SplashRepository splashRepository = SplashRepository();
  PerfilRepository perfilRepository = PerfilRepository();

  final Rx<UserDetail> user = UserDetail(
      id: 0,
      guid: '',
      displayName: '',
      url: '',
      account: null,
      profile: null,
      spaces: []).obs;

  final RxList<UserFriendship> dataUserFriendship = <UserFriendship>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() async {
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;

      final results = await Future.wait([
        splashRepository.getUser(user.value.account!.username),
        perfilRepository.getFriendship(),
      ]);

      user.value = results[0] as UserDetail;
      dataUserFriendship.value = results[1] as List<UserFriendship>;

      box.write("user", user.value);
    } else {
      Get.snackbar("Error", "No se encontró información del usuario");
    }
  }
}
