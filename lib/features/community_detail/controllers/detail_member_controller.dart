import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/list_membership_repository.dart';
import 'package:get/get.dart';

class DetailMemberController extends GetxController {
  String memberId = Get.arguments;
  ListMembershipRepository listMembershipRepository =
      ListMembershipRepository();

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
    print("------------------1");
    print(memberId);
    user.value = await listMembershipRepository.getMemberId(memberId);
    print("=========================2");
    print(user.value);
  }
}
