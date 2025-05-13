import 'package:comunidadesucv/config/constants/responsive.dart';
import 'package:comunidadesucv/features/community_detail/controllers/community_detail_controller.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/community_detail_title.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/community_image_loading.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/community_rules.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/description_text.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/join_button.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/menu_item.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/recent_publication_list.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/restrict_access_dialog.dart';
import 'package:comunidadesucv/features/community_member/presentation/widgets/members_avatar_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityDetailPage extends GetView<CommunityDetailController> {
  const CommunityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              CommunityImageLoading(
                controller: controller,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCommunityInfo(context),
                        _buildRecentPublicationsSection(context),
                        SizedBox(
                          height: 15,
                        ),
                        _buildNavigationMenu(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildBackButton(),
          JoinButton(
            controller: controller,
            top: MediaQuery.of(context).size.height * 0.3 -
                ResponsiveSize.getHeight(context, 20),
            right: ResponsiveSize.getWidth(context, 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityInfo(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
          left: ResponsiveSize.getWidth(context, 20),
          right: ResponsiveSize.getWidth(context, 20),
          bottom: ResponsiveSize.getHeight(context, 15),
          top: ResponsiveSize.getHeight(context, 20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommunityDetailTitle(
              name: controller.space.value.name,
              isLoading: controller.isLoading.value,
            ),
            MembersAvatarRow(
              memberships: controller.space.value.lastMemberships,
              totalMembersCount: controller.space.value.membersCount,
              spaceId: controller.space.value.id,
              isLoading: controller.isLoading.value,
            ),
            SizedBox(height: ResponsiveSize.getHeight(context, 15)),
            DescriptionText(
              description: controller.space.value.description,
              isLoading: controller.isLoading.value,
            ),
            SizedBox(height: ResponsiveSize.getHeight(context, 15)),
            CommunityRulesWidget(
              rules: controller.space.value.about,
              isExpanded: controller.isRulesExpanded.value,
              onToggle: controller.toggleRulesExpanded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPublicationsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.getWidth(context, 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Publicaciones recientes",
            style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveSize.getFontSize(context, 16)),
          ),
          SizedBox(height: ResponsiveSize.getHeight(context, 10)),
          RecentPublicationsList(controller: controller),
        ],
      ),
    );
  }

  Widget _buildNavigationMenu() {
    return Column(
      children: [
        MenuItem(
          icon: Icons.bookmark_border,
          label: "Publicaciones",
          iconBackgroundColor: Colors.blue,
          onTap: () async {
            if (controller.isButtonMember.value) {
              final result = await Get.toNamed(
                "/community_feed",
                arguments: controller.space.value,
              );

              if (result == true) {
                await controller.loadLastPostContainer();
              }
            } else {
              Get.dialog(RestrictedAccessDialog());
            }
          },
        ),
        // MenuItem(
        //   icon: Icons.calendar_today,
        //   label: "Agenda UCV",
        //   iconBackgroundColor: Colors.purple.shade300,
        //   onTap: () =>
        //       Get.offAllNamed("/events", arguments: controller.space.value),
        // ),
        MenuItem(
          icon: Icons.group,
          label: "Lo que dice la comunidad",
          iconBackgroundColor: Colors.orange,
          onTap: () async {
            final result = await Get.toNamed(
              "/community_forum",
              arguments: controller.space.value,
            );

            if (result == true) {
              await controller.loadLastPostContainer();
            }
          },
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: ResponsiveSize.getHeight(Get.context!, 40),
      left: ResponsiveSize.getWidth(Get.context!, 10),
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xFF9D4EDD),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
    );
  }
}
