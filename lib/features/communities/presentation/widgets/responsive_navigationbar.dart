import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:ui';

class ResponsiveBottomNavigationBar extends StatelessWidget {
  const ResponsiveBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    final double navigationBarHeight = _calculateNavbarHeight(screenSize);
    final double iconSize = _calculateIconSize(screenSize);
    final double buttonPadding = navigationBarHeight * 0.2;
    
    return Container(
      height: navigationBarHeight,
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: AppColors.backgroundDarkIntense.withOpacity(0.85),
        border: Border(top: BorderSide(width: 0.5, color: AppColors.backgroundDark)),
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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavButton(
                  context: context,
                  icon: Ionicons.home,
                  isActive: true,
                  padding: buttonPadding,
                  iconSize: iconSize,
                ),
                _buildNavButton(
                  context: context,
                  icon: Icons.add_box_outlined,
                  isActive: false,
                  padding: buttonPadding,
                  iconSize: iconSize,
                  onTap: () {},
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
      ),
    );
  }
  
  double _calculateNavbarHeight(Size screenSize) {
    final double height = screenSize.height * 0.05;
    
    if (height < 56) {
      return 50;
    } else if (height > 80) {
      return 75;
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
        decoration: isActive ? BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ) : null,
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