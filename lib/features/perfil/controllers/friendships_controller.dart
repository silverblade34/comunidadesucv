import 'package:comunidadesucv/core/models/user_friendship.dart';
import 'package:comunidadesucv/features/perfil/data/repository/friendships_repository.dart';
import 'package:comunidadesucv/features/perfil/data/repository/perfil_repository.dart';
import 'package:get/get.dart';

class FriendshipsController extends GetxController {
  FriendshipsRepository friendshipsRepository = FriendshipsRepository();
  PerfilRepository perfilRepository = PerfilRepository();

  final RxList<UserFriendship> dataUserFriendship = <UserFriendship>[].obs;
  final RxList<UserFriendship> dataUserFriendshipReceived =
      <UserFriendship>[].obs;
  final RxList<UserFriendship> dataUserFriendshipSent = <UserFriendship>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() async {
    final results = await Future.wait([
      friendshipsRepository.getFriendshipReceived(),
      friendshipsRepository.getFriendshipSent(),
      perfilRepository.getFriendship()
    ]);

    dataUserFriendshipReceived.value = results[0];
    dataUserFriendshipSent.value = results[1];
    dataUserFriendship.value = results[2];
  }
}
