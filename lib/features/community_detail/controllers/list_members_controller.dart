import 'package:comunidadesucv/features/communities/data/dto/membership_info.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/list_membership_repository.dart';
import 'package:get/get.dart';

class ListMembersController extends GetxController {
  int spaceId = Get.arguments;
  ListMembershipRepository listMembershipRepository =
      ListMembershipRepository();
  RxList<MembershipInfo> memberships = RxList([]);
  RxList<MembershipInfo> recommendedMemberships = RxList([]);

  @override
  void onInit() {
    super.onInit();
    _loadMemberships();
  }

  void _loadMemberships() async {
    final response = await listMembershipRepository.getSpaceMembers(spaceId);

    memberships.value = response.results
        .where((membership) =>
            membership.user.guid != "72c88b0d-3589-4542-a4ca-15f998e14484")
        .toList();

    final List<MembershipInfo> recommended = [];

    for (MembershipInfo membership in memberships) {
      final membershipTags =
          (membership.user.tags).map((e) => e.toLowerCase()).toSet();

      final hasCommonTags = membershipTags.isNotEmpty;

      if (hasCommonTags) {
        recommended.add(membership);
      }
    }

    recommendedMemberships.assignAll(recommended);
  }
}
