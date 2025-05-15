import 'package:comunidadesucv/features/communities/data/dto/user_info.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/detail_member_repository.dart';
import 'package:comunidadesucv/features/perfil/data/repository/friendships_repository.dart';
import 'package:comunidadesucv/features/perfil/data/repository/perfil_repository.dart';
import 'package:get/get.dart';

class FriendshipsController extends GetxController {
  FriendshipsRepository friendshipsRepository = FriendshipsRepository();
  PerfilRepository perfilRepository = PerfilRepository();
  DetailMemberRepository detailMemberRepository = DetailMemberRepository();

  final RxList<UserInfo> dataUserFriendship = <UserInfo>[].obs;
  final RxList<UserInfo> dataUserFriendshipReceived =
      <UserInfo>[].obs;
  final RxList<UserInfo> dataUserFriendshipSent = <UserInfo>[].obs;

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
