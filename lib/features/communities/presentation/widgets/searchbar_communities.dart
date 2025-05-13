import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarCommunities extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;
  final RxString searchQuery;
  final String hintext;

  const SearchBarCommunities({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.searchQuery,
    required this.hintext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final double fontSize = screenSize.width * 0.034;
    final double iconSize = screenSize.width * 0.045;

    return Container(
      height: screenSize.height * 0.06,
      constraints: BoxConstraints(
        minHeight: 48,
        maxHeight: 56,
      ),
      child: TextField(
        controller: controller,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface,
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.onSurface,
            size: iconSize,
          ),
          suffixIcon: Obx(() => searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    // ignore: deprecated_member_use
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    size: iconSize,
                  ),
                  onPressed: onClear,
                )
              : const SizedBox()),
          hintText: hintext,
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
          // ignore: deprecated_member_use
          fillColor: AppColors.backgroundDarkLigth,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
