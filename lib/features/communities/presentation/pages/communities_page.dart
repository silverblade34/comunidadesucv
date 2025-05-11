import 'package:comunidadesucv/features/communities/controllers/communities_controller.dart';
import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comunidadesucv/features/communities/presentation/widgets/appbar_communities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:ui';

class CommunitiesPage extends GetView<CommunitiesController> {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: false,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015, 
                bottom: 0
              ),
              child: Column(
                children: [
                  AppBarCommunities(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  _buildAnimatedSearchBar(theme),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              key: controller.refreshIndicatorKey,
              onRefresh: controller.refreshCommunities,
              color: theme.colorScheme.onPrimary,
              backgroundColor: theme.colorScheme.primary,
              child: Stack(
                children: [
                  _buildMainContent(theme, context),
                  const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomNavigationBar(context, theme),
    );
  }

  Widget _buildMainContent(ThemeData theme, BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      clipBehavior: Clip.hardEdge,
      slivers: [
        Obx(
          () => SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                  _buildSectionHeader(
                    icon: controller.searchQuery.value.isEmpty
                        ? Icons.people
                        : Icons.search,
                    iconColor: theme.colorScheme.primary,
                    title: controller.searchQuery.value.isEmpty
                        ? 'Explora y únete'
                        : 'Resultados',
                    theme: theme,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04
          ),
          sliver: Obx(() {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.02,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.04,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final community = controller.filteredCommunities[index];
                  return _buildCommunityCard(community, theme, context);
                },
                childCount: controller.filteredCommunities.length,
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ),
      ],
    );
  }

  Widget _buildAnimatedSearchBar(ThemeData theme) {
    return TextField(
      controller: controller.searchController,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: theme.colorScheme.onSurface,
          size: 22,
        ),
        suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, color: theme.colorScheme.onSurface.withOpacity(0.6), size: 22),
                onPressed: controller.clearSearch,
              )
            : const SizedBox()),
        hintText: 'Buscar comunidad',
        hintStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.6)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: theme.colorScheme.surface.withOpacity(0.2),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
      onChanged: (value) {
        controller.searchQuery.value = value;
      },
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required Color iconColor,
    required String title,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCommunityCard(Space space, ThemeData theme, BuildContext context) {
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
                  memCacheWidth: (MediaQuery.of(context).size.width).toInt(),
                  memCacheHeight: (MediaQuery.of(context).size.width).toInt(),
                  placeholder: (context, url) => Container(
                    color: theme.colorScheme.surface.withOpacity(0.3),
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: theme.colorScheme.error),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
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
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    _buildMembersWidget(space, membersText, theme, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMembersWidget(Space space, String membersText, ThemeData theme, BuildContext context) {
    final double avatarSize = MediaQuery.of(context).size.width * 0.05;
    final double spacing = avatarSize * 0.65;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (space.lastMemberships.isNotEmpty)
          SizedBox(
            width: space.lastMemberships.length == 1
                ? avatarSize
                : space.lastMemberships.length == 2
                    ? avatarSize + spacing
                    : space.lastMemberships.length >= 3
                        ? avatarSize + spacing * 2
                        : 0,
            height: avatarSize,
            child: Stack(
              children: [
                for (int i = 0; i < space.lastMemberships.length && i < 3; i++)
                  Positioned(
                    right: i * spacing,
                    child: Container(
                      decoration: i > 0
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: theme.colorScheme.onPrimary, width: 1),
                            )
                          : null,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: space.lastMemberships[i].user.imageUrl,
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                          memCacheWidth: (avatarSize * 2).toInt(),
                          memCacheHeight: (avatarSize * 2).toInt(),
                          placeholder: (context, url) => Container(
                            color: theme.colorScheme.surface.withOpacity(0.3),
                            width: avatarSize,
                            height: avatarSize,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: theme.colorScheme.surface.withOpacity(0.3),
                            width: avatarSize,
                            height: avatarSize,
                            child: Icon(Icons.person,
                                size: avatarSize * 0.6, 
                                color: theme.colorScheme.onSurface.withOpacity(0.7)),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            membersText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, ThemeData theme) {
    final double navigationBarHeight = MediaQuery.of(context).size.height * 0.075;
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.06;
    final double bottomPadding = MediaQuery.of(context).size.height * 0.02;
    final double iconSize = MediaQuery.of(context).size.width * 0.07;
    
    return Container(
      margin: EdgeInsets.only(
        left: horizontalPadding, 
        right: horizontalPadding, 
        bottom: bottomPadding
      ),
      height: navigationBarHeight,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.85),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(navigationBarHeight * 0.15),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Ionicons.home,
                  color: theme.colorScheme.onPrimary,
                  size: iconSize,
                ),
              ),
              Container(
                padding: EdgeInsets.all(navigationBarHeight * 0.15),
                child: Icon(
                  Icons.add_box_outlined,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  size: iconSize,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed("/perfil"),
                child: Container(
                  padding: EdgeInsets.all(navigationBarHeight * 0.15),
                  child: Icon(
                    Ionicons.person,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                    size: iconSize,
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