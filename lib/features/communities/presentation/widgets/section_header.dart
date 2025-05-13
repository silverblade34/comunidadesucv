import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double iconSize = screenSize.width * 0.045;
    
    return Row(
      children: [
        Icon(icon, color: iconColor, size: iconSize),
        SizedBox(width: screenSize.width * 0.02),
        Text(
          title,
          style: AppFonts.subtitleCommunity,
        ),
      ],
    );
  }
}