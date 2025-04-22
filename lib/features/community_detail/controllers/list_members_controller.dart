import 'package:comunidadesucv/features/communities/data/dto/membership_info.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/list_membership_repository.dart';
import 'package:get/get.dart';

class ListMembersController extends GetxController {
  int spaceId = Get.arguments;
  ListMembershipRepository listMembershipRepository =
      ListMembershipRepository();
  RxList<MembershipInfo> memberships = RxList([]);

  @override
  void onInit() {
    super.onInit();
    _loadMemberships();
  }

  void _loadMemberships() async {
    final response = await listMembershipRepository.getSpaceMembers(spaceId);
    memberships.value = response.results;
    print("==========================");
    print(memberships);
  }
}
