import 'dart:ui';

import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/features/community_feed/controllers/community_feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ResponsiveNavigationFeed extends StatelessWidget {
  final CommunityFeedController controller;

  const ResponsiveNavigationFeed({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final double navigationBarHeight = _calculateNavbarHeight(screenSize);
    final double iconSize = _calculateIconSize(screenSize);
    final double buttonPadding = navigationBarHeight * 0.15;

    return Container(
      height: navigationBarHeight,
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: AppColors.backgroundDark.withOpacity(0.85),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
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
              _buildNavButton(
                context: context,
                icon: Ionicons.home,
                isActive: false,
                padding: buttonPadding,
                iconSize: iconSize,
                onTap: () => Get.toNamed("/communities"),
              ),
              _buildNavButton(
                context: context,
                icon: Icons.add_box_outlined,
                isActive: true,
                padding: buttonPadding,
                iconSize: iconSize,
                onTap: () async {
                  final result = await Get.toNamed("/registered_post",
                      arguments: controller.space);

                  if (result == true) {
                    await controller.loadInitialPosts();
                  }
                },
              ),
              _buildNavButton(
                context: context,
                icon: Ionicons.person,
                isActive: false,
                padding: buttonPadding,
                iconSize: iconSize,
                onTap: () => Get.toNamed("/perfil"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateNavbarHeight(Size screenSize) {
    final double height = screenSize.height * 0.075;

    if (height < 56) {
      return 56;
    } else if (height > 80) {
      return 80;
    }
    return height;
  }

  double _calculateIconSize(Size screenSize) {
    final double size = screenSize.width * 0.07;

    if (size < 24) {
      return 24;
    } else if (size > 32) {
      return 32;
    }
    return size;
  }

  Widget _buildNavButton({
    required BuildContext context,
    required IconData icon,
    required bool isActive,
    required double padding,
    required double iconSize,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Icon(
          icon,
          color: isActive
              ? Colors.white
              // ignore: deprecated_member_use
              : theme.colorScheme.onSurface.withOpacity(0.7),
          size: iconSize,
        ),
      ),
    );
  }
}
