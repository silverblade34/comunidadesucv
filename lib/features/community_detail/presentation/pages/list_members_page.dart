import 'package:comunidadesucv/features/community_detail/controllers/list_members_controller.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/app_header.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/members_list_section.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ListMembersPage extends GetView<ListMembersController> {
  const ListMembersPage({super.key});

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
            
            // Listado de miembros
            Expanded(
              child: controller.memberships.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : MembersListView(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}