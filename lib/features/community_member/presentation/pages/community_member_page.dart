import 'package:comunidadesucv/features/community_member/controllers/community_member_controller.dart';
import 'package:comunidadesucv/features/community_member/presentation/widgets/app_header.dart';
import 'package:comunidadesucv/features/community_member/presentation/widgets/member_listitem_shimmer.dart';
import 'package:comunidadesucv/features/community_member/presentation/widgets/members_list_section.dart';
import 'package:comunidadesucv/features/community_member/presentation/widgets/recommended_section_shimmer.dart';
import 'package:comunidadesucv/features/community_member/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityMemberPage extends GetView<CommunityMemberController> {
  const CommunityMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            // Componente Header
            AppHeader(title: "Miembros"),

            // Componente de buscar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(controller: controller),
            ),

            SizedBox(height: 20),

            Expanded(
              child: controller.isInitialLoading.value
                  ? _buildInitialLoadingShimmer(context)
                  : controller.memberships.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.group_off_outlined,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "No hay miembros disponibles",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : MembersListView(controller: controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialLoadingShimmer(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        RecommendedMembersSectionShimmer(),

        SizedBox(height: 25),
        Container(
          width: 150,
          height: 18,
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        for (int i = 0; i < 8; i++) MemberListItemShimmer(),
      ],
    );
  }
}
