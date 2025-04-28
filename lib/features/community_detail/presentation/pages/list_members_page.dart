import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/features/community_detail/controllers/list_members_controller.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
            Container(
              height: AppBar().preferredSize.height,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Ionicons.chevron_back,
                      size: 24,
                      color: AppTheme.isLightTheme
                          ? HexColor("#120C45")
                          : HexColor('#FFFFFF'),
                    ),
                  ),
                  Text(
                    "Miembros",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          color: AppTheme.isLightTheme
                              ? HexColor("#1A1167")
                              : HexColor('#E5E3FC'),
                        ),
                  ),
                  SizedBox()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  suffixIcon: controller.searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            controller.searchController.clear();
                          },
                        )
                      : SizedBox(),
                  hintText: 'Buscar miembros',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.backgroundDarkLigth,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                onChanged: (_) => controller.update(),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: controller.memberships.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _buildMembersList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersList(BuildContext context) {
    return CustomScrollView(
      controller: controller.scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sección de "Intereses en común" - Solo mostrar si no hay búsqueda
                if (controller.searchController.text.isEmpty &&
                    controller.recommendedMemberships.isNotEmpty) ...[
                  Text(
                    'Intereses en común',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _buildInterestingMembers(context),
                      ),
                    ),
                  ),
                ],

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    controller.searchController.text.isEmpty
                        ? 'Todos los miembros'
                        : 'Resultados',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Lista principal con paginación
        SliverPadding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom + 20),
          sliver: SliverList.builder(
            itemCount: controller.filteredMemberships.length +
                1, // +1 para indicador de carga
            itemBuilder: (context, index) {
              // Si llegamos al final y hay más datos, mostrar indicador de carga
              if (index == controller.filteredMemberships.length) {
                return Obx(
                    () => controller.isLoading.value && controller.hasMore.value
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SizedBox());
              }

              // Renderizar el item de miembro
              final membership = controller.filteredMemberships[index];
              return _buildContactTile(
                context,
                id: membership.user.id,
                name: membership.user.displayName,
                phone: '${membership.user.carrera}',
                avatar: membership.user.imageUrl,
                statusColor: null,
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildInterestingMembers(BuildContext context) {
    final interestingMembers = controller.recommendedMemberships.toList();

    final widgets = <Widget>[];

    for (var i = 0; i < interestingMembers.length; i++) {
      final member = interestingMembers[i];
      widgets.add(
          _buildPinnedContact(context, member.user.imageUrl, member.user.id));

      if (i < interestingMembers.length - 1) {
        widgets.add(const SizedBox(width: 10));
      }
    }
    
    return widgets;
  }

  Widget _buildPinnedContact(
      BuildContext context, String avatarUrl, int userId) {
    return GestureDetector(
        onTap: () =>
            Get.toNamed("/detail_member", arguments: userId.toString()),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget _buildContactTile(
    BuildContext context, {
    required int id,
    required String name,
    required String phone,
    required String avatar,
    Color? statusColor,
  }) {
    return GestureDetector(
      onTap: () => Get.toNamed("/detail_member", arguments: id.toString()),
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.textBlackUCV,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (statusColor != null)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  Text(
                    phone,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              Ionicons.person_add_outline,
              size: 18,
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
