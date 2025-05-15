import 'package:comunidadesucv/core/enum/friendship_state.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/communities/data/dto/membership_info.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/detail_member_repository.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/list_membership_repository.dart';
import 'package:get/get.dart';

class DetailMemberController extends GetxController {
  MembershipInfo membership = Get.arguments["membership"];
  FriendshipState state = Get.arguments["state"];
  ListMembershipRepository listMembershipRepository =
      ListMembershipRepository();
  DetailMemberRepository detailMemberRepository = DetailMemberRepository();

  final Rx<UserDetail> user = UserDetail.empty().obs;
  final RxBool isSendingRequest = false.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  void _loadUser() async {
    isLoading.value = true;
    try {
      user.value = await listMembershipRepository
          .getMemberId(membership.user.id.toString());
    } catch (e) {
      print('Error loading user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteFriend() async {
    isSendingRequest.value = true;
    bool response = await detailMemberRepository
        .deleteFriend(membership.user.id.toString());
    isSendingRequest.value = false;
    if (response) {
      state = FriendshipState.NO_FRIEND;
      update();
    }
  }

  void sendAndAcceptRequestFriend(FriendshipState friendshipState) async {
    isSendingRequest.value = true;
    bool response = await detailMemberRepository
        .sendAndAcceptRequestFriend(membership.user.id.toString());
    isSendingRequest.value = false;
    if (response) {
      state = friendshipState;
    }
    update();
  }
}
