import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/features/community_member/controllers/community_member_controller.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final CommunityMemberController controller;

  const SearchBarWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final double fontSize = screenSize.width * 0.038;
    final double iconSize = screenSize.width * 0.045;

    return TextField(
      controller: controller.searchController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search,
            color: theme.colorScheme.onSurface, size: iconSize),
        suffixIcon: controller.searchController.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  controller.searchController.clear();
                  controller.update();
                },
              )
            : SizedBox(),
        hintText: 'Buscar miembros',
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          // ignore: deprecated_member_use
          color: theme.colorScheme.onSurface.withOpacity(0.6),
          fontSize: fontSize,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.backgroundDarkLigth,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
      ),
      onChanged: (_) => controller.update(),
    );
  }
}
