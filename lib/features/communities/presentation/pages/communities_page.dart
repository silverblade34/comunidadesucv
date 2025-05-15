import 'package:comunidadesucv/features/communities/controllers/communities_controller.dart';
import 'package:comunidadesucv/features/communities/presentation/widgets/appbar_communities.dart';
import 'package:comunidadesucv/features/communities/presentation/widgets/communities_grid.dart';
import 'package:comunidadesucv/features/communities/presentation/widgets/responsive_navigationbar.dart';
import 'package:comunidadesucv/features/communities/presentation/widgets/searchbar_communities.dart';
import 'package:comunidadesucv/features/communities/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunitiesPage extends GetView<CommunitiesController> {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width * 0.04;
 
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    const AppBarCommunities(),
                    SizedBox(height: screenSize.height * 0.025),
                    SearchBarCommunities(
                      controller: controller.searchController,
                      onChanged: (value) =>
                          controller.searchQuery.value = value,
                      onClear: controller.clearSearch,
                      searchQuery: controller.searchQuery,
                      hintext: 'Buscar comunidad',
                    ),
                    SizedBox(height: screenSize.height * 0.012),
                  ],
                ),
              ),

              // Main
              Expanded(
                child: Obx(() {
                  // Si está cargando y no hay datos todavía, indicador de carga
                  if (controller.isLoading.value &&
                      controller.filteredCommunities.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return RefreshIndicator(
                    onRefresh: controller.refreshCommunities,
                    color: theme.colorScheme.onPrimary,
                    backgroundColor: theme.colorScheme.primary,
                    child: _buildMainContent(theme, context),
                  );
                }),
              ),
            ],
          ),
          bottomNavigationBar: const ResponsiveBottomNavigationBar(),
        ),
      ),
    );
  }

  Widget _buildMainContent(ThemeData theme, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width * 0.04;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Section header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.012),
                Obx(() => SectionHeader(
                      icon: controller.searchQuery.value.isEmpty
                          ? Icons.people
                          : Icons.search,
                      iconColor: theme.colorScheme.primary,
                      title: controller.searchQuery.value.isEmpty
                          ? 'Explora y únete'
                          : 'Resultados',
                    )),
                SizedBox(height: screenSize.height * 0.02),
              ],
            ),
          ),

          // Communities grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Obx(() => CommunitiesGrid(
                communities: controller.filteredCommunities.value,
                onTap: (space) async {
                  await Get.toNamed("/community_detail", arguments: space);
                })),
          ),

          // Bottom padding
          SizedBox(height: screenSize.height * 0.03),
        ],
      ),
    );
  }
}
