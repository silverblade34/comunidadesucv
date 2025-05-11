import 'package:comunidadesucv/core/enum/friendship_state.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/detail_member_repository.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/list_membership_repository.dart';
import 'package:get/get.dart';

class DetailMemberController extends GetxController {
  String memberId = Get.arguments["friendId"];
  FriendshipState state = Get.arguments["state"];
  ListMembershipRepository listMembershipRepository =
      ListMembershipRepository();
  DetailMemberRepository detailMemberRepository = DetailMemberRepository();

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
    user.value = await listMembershipRepository.getMemberId(memberId);
  }

  void deleteFriend() async {
    bool response = await detailMemberRepository.deleteFriend(memberId);
    if (response) {
      state = FriendshipState.NO_FRIEND;
      update();
    }
  }

  void sendAndAcceptRequestFriend(FriendshipState friendshipState) async {
    bool response =
        await detailMemberRepository.sendAndAcceptRequestFriend(memberId);
    if (response) {
      state = friendshipState;
      update();
    }
  }
}
