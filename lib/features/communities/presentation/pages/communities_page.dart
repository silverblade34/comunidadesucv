import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/constance.dart';
import 'package:comunidadesucv/features/communities/controllers/communities_controller.dart';
import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:ui';

class CommunitiesPage extends GetView<CommunitiesController> {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: false,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              margin: const EdgeInsets.only(top: 10, bottom: 0),
              child: Column(
                children: [
                  _buildAppBar(),
                  const SizedBox(height: 20),
                  _buildAnimatedSearchBar(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              key: controller.refreshIndicatorKey,
              onRefresh: controller.refreshCommunities,
              color: Colors.white,
              backgroundColor: AppColors.primary,
              child: Stack(
                children: [
                  _buildMainContent(),
                  const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildMainContent() {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      clipBehavior: Clip.hardEdge,
      slivers: [
        Obx(
          () => SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Solo mostrar sección de recomendados si no hay búsqueda activa
                  if (controller.searchQuery.value.isEmpty &&
                      controller.recommendedCommunities.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    _buildSectionHeader(
                      icon: Icons.star,
                      iconColor: Colors.amber,
                      title: 'Recomendados',
                    ),
                    const SizedBox(height: 16),
                    _buildRecommendedList(),
                    const SizedBox(height: 24),
                  ],
                  const SizedBox(height: 10),
                  _buildSectionHeader(
                    icon: controller.searchQuery.value.isEmpty
                        ? Icons.people
                        : Icons.search,
                    iconColor: AppColors.primary,
                    title: controller.searchQuery.value.isEmpty
                        ? 'Explora y únete'
                        : 'Resultados',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: Obx(() {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final community = controller.filteredCommunities[index];
                  return _buildCommunityCard(community);
                },
                childCount: controller.filteredCommunities.length,
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 80),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        Image.asset(
          ConstanceData.LogoUcv,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
          cacheWidth: 48,
          cacheHeight: 48,
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          'Comunidades Digitales',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedSearchBar() {
    return SizedBox(
      child: TextField(
        controller: controller.searchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: controller.clearSearch,
                )
              : const SizedBox()),
          hintText: 'Buscar comunidad',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.backgroundDarkLigth,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: (value) {
          controller.searchQuery.value = value;
        },
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required Color iconColor,
    required String title,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedList() {
    return SizedBox(
      height: 150,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.recommendedCommunities.length,
          itemBuilder: (context, index) {
            final item = controller.recommendedCommunities[index];
            return _buildRecommendedCard(item);
          },
          cacheExtent: 300,
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
        ),
      ),
    );
  }

  Widget _buildRecommendedCard(Space space) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          Get.offAllNamed("/community_detail", arguments: space.id);
        },
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: space.profileImage,
                  fit: BoxFit.cover,
                  memCacheWidth: 280,
                  memCacheHeight: 300,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Text(
                  space.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommunityCard(Space space) {
    String membersText = space.membersCount == 1
        ? '1 miembro'
        : '${space.membersCount} miembros';

    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          Get.offAllNamed("/community_detail", arguments: space.id);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: space.profileImage,
                  fit: BoxFit.cover,
                  memCacheWidth: 400,
                  memCacheHeight: 400,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                      Colors.black87,
                    ],
                    stops: [0.6, 0.8, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      space.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    _buildMembersWidget(space, membersText),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMembersWidget(Space space, String membersText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (space.lastMemberships.isNotEmpty)
          SizedBox(
            width: space.lastMemberships.length == 1
                ? 28
                : space.lastMemberships.length == 2
                    ? 28 + 13
                    : space.lastMemberships.length >= 3
                        ? 28 + 13 + 13
                        : 0,
            height: 28,
            child: Stack(
              children: [
                for (int i = 0; i < space.lastMemberships.length && i < 3; i++)
                  Positioned(
                    right: i * 15.0,
                    child: Container(
                      decoration: i > 0
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1),
                            )
                          : null,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: space.lastMemberships[i].user.imageUrl,
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                          memCacheWidth: 40,
                          memCacheHeight: 40,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[700],
                            width: 20,
                            height: 20,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[800],
                            width: 20,
                            height: 20,
                            child: const Icon(Icons.person,
                                size: 12, color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            membersText,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      height: 60,
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: const Color(0xFF0E0745).withOpacity(0.85),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        backgroundBlendMode: BlendMode.overlay,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFF8260F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Ionicons.home,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(9),
                child: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed("/perfil"),
                child: Container(
                  padding: const EdgeInsets.all(9),
                  child: const Icon(
                    Ionicons.person,
                    color: Colors.grey,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
