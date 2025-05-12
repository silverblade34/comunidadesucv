import 'package:comunidadesucv/core/models/user_friendship.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/detail_member_repository.dart';
import 'package:comunidadesucv/features/perfil/data/repository/friendships_repository.dart';
import 'package:comunidadesucv/features/perfil/data/repository/perfil_repository.dart';
import 'package:get/get.dart';

class FriendshipsController extends GetxController {
  FriendshipsRepository friendshipsRepository = FriendshipsRepository();
  PerfilRepository perfilRepository = PerfilRepository();
  DetailMemberRepository detailMemberRepository = DetailMemberRepository();

  final RxList<UserFriendship> dataUserFriendship = <UserFriendship>[].obs;
  final RxList<UserFriendship> dataUserFriendshipReceived =
      <UserFriendship>[].obs;
  final RxList<UserFriendship> dataUserFriendshipSent = <UserFriendship>[].obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    final results = await Future.wait([
      friendshipsRepository.getFriendshipReceived(),
      friendshipsRepository.getFriendshipSent(),
      perfilRepository.getFriendship()
    ]);

    dataUserFriendshipReceived.value = results[0];
    dataUserFriendshipSent.value = results[1];
    dataUserFriendship.value = results[2];
  }

  void deleteFriend(String memberId) async {
    bool response = await detailMemberRepository.deleteFriend(memberId);
    if (response) {
      initData();
    }
  }

  void sendAndAcceptRequestFriend(String memberId) async {
    bool response =
        await detailMemberRepository.sendAndAcceptRequestFriend(memberId);
    if (response) {
      initData();
    }
  }
}
