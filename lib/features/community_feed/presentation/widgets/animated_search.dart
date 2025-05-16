import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedSearch extends StatefulWidget {
  final Function(String) onSearch;
  final bool isSearchActive;
  final VoidCallback onSearchTap;
  final String hintText;

  const AnimatedSearch({
    super.key,
    required this.onSearch,
    required this.isSearchActive,
    required this.onSearchTap,
    this.hintText = 'Buscar',
  });

  @override
  State createState() => _AnimatedSearchState();
}

class _AnimatedSearchState extends State<AnimatedSearch> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final RxString searchQuery = ''.obs;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      searchQuery.value = _searchController.text;
      widget.onSearch(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSearchActive && !oldWidget.isSearchActive) {
      _focusNode.requestFocus();
    } else if (!widget.isSearchActive && oldWidget.isSearchActive) {
      _focusNode.unfocus();
      _searchController.clear();
      searchQuery.value = '';
    }
  }

  void _clearSearch() {
    _searchController.clear();
    searchQuery.value = '';
    widget.onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final double fontSize = screenSize.width * 0.038;
    final double iconSize = screenSize.width * 0.045;

    return GestureDetector(
      onTap: widget.isSearchActive ? null : widget.onSearchTap,
      child: Container(
        height: screenSize.height * 0.06,
        constraints: const BoxConstraints(
          minHeight: 48,
          maxHeight: 56,
        ),
        child: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          enabled: widget.isSearchActive,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontSize: fontSize,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: theme.colorScheme.onSurface.withOpacity(widget.isSearchActive ? 1.0 : 0.6),
              size: iconSize,
            ),
            suffixIcon: Obx(() => (searchQuery.value.isNotEmpty && widget.isSearchActive)
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      size: iconSize,
                    ),
                    onPressed: _clearSearch,
                  )
                : const SizedBox()),
            hintText: widget.hintText,
            hintStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontSize: fontSize,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.backgroundDarkLigth, // Reemplaza esto con AppColors.backgroundDarkLigth
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            // Evita que el cursor se muestre cuando no está activo
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: widget.isSearchActive ? widget.onSearch : null,
        ),
      ),
    );
  }
}