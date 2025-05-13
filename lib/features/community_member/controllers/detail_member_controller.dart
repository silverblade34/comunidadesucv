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
      user.value = await listMembershipRepository.getMemberId(memberId);
    } catch (e) {
      print('Error loading user: $e');
    } finally {
      isLoading.value = false; // End loading
    }
  }

  void deleteFriend() async {
    isSendingRequest.value = true;
    bool response = await detailMemberRepository.deleteFriend(memberId);
    isSendingRequest.value = false;
    if (response) {
      state = FriendshipState.NO_FRIEND;
      update();
    }
  }

  void sendAndAcceptRequestFriend(FriendshipState friendshipState) async {
    isSendingRequest.value = true;
    bool response =
        await detailMemberRepository.sendAndAcceptRequestFriend(memberId);
    isSendingRequest.value = false;
    if (response) {
      state = friendshipState;
    }
    update();
  }
}
