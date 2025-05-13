import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:comunidadesucv/core/enum/friendship_state.dart';
import 'package:comunidadesucv/features/community_member/controllers/community_member_controller.dart';
import 'package:comunidadesucv/features/community_member/presentation/widgets/friend_option_sheets.dart';
import 'package:comunidadesucv/features/community_member/presentation/widgets/members_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recommended_members_section.dart';

class MembersListView extends StatelessWidget {
  final CommunityMemberController controller;

  const MembersListView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.searchController.text.isEmpty &&
                      controller.recommendedMemberships.isNotEmpty)
                    RecommendedMembersSection(
                      recommendedMemberships: controller.recommendedMemberships,
                      getFriendshipState: controller.getFriendshipState,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      controller.searchController.text.isEmpty
                          ? 'Todos los miembros'
                          : 'Resultados',
                      style: AppFonts.subtitleCommunity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom + 20,
            ),
            sliver: SliverList.builder(
              itemCount: controller.filteredMemberships.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.filteredMemberships.length) {
                  return controller.isLoading.value && controller.hasMore.value
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox();
                }

                final membership = controller.filteredMemberships[index];

                return MemberListItem(
                  controller: controller,
                  id: membership.user.id,
                  name: membership.user.displayName,
                  details: '${membership.user.carrera}',
                  avatar: membership.user.imageUrl,
                  getDisplayName: controller.getDisplayName,
                  onIconTap: (id, name, friendshipState) =>
                      _handleIconTap(context, id, name, friendshipState),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleIconTap(BuildContext context, int userId, String name,
      FriendshipState friendshipState) {
    switch (friendshipState) {
      case FriendshipState.SELF:
        Get.toNamed("/perfil");
        break;
      case FriendshipState.NO_FRIEND:
        controller.sendAndAcceptRequestFriend(userId.toString());
        break;
      case FriendshipState.FRIEND:
        _showFriendOptions(context, userId, name);
        break;
      case FriendshipState.REQUEST_RECEIVED:
        _showRequestOptions(context, userId, name);
        break;
      default:
        break;
    }
  }

  void _showFriendOptions(BuildContext context, int userId, String name) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundDialogDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => FriendOptionsSheet(
          controller: controller, userId: userId, name: name),
    );
  }

  void _showRequestOptions(BuildContext context, int userId, String name) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundDialogDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) =>
          FriendRequestOptionsSheet(userId: userId, name: name),
    );
  }
}
