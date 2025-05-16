import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedSearchForum extends StatelessWidget {
  final Function(String) onSearch;
  final bool isSearchActive;
  final VoidCallback onSearchTap;

  const AnimatedSearchForum({
    super.key,
    required this.onSearch,
    required this.isSearchActive,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    final backgroundColor = isDarkMode ? Colors.grey[800] : Colors.grey[200];
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final hintColor = isDarkMode ? Colors.white60 : Colors.black54;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.search,
              color: hintColor,
              size: 20,
            ),
          ),
          Expanded(
            child: isSearchActive
                ? TextField(
                    autofocus: true,
                    style: TextStyle(color: textColor, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Buscar en el foro...',
                      hintStyle: TextStyle(color: hintColor, fontSize: 14),
                      border: InputBorder.none,
                    ),
                    onChanged: onSearch,
                  )
                : GestureDetector(
                    onTap: onSearchTap,
                    child: Container(
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Buscar en el foro...',
                          style: TextStyle(color: hintColor, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
          ),
          if (isSearchActive)
            IconButton(
              icon: Icon(Icons.close, color: hintColor, size: 20),
              onPressed: onSearchTap,
              constraints: BoxConstraints.tightFor(width: 32, height: 32),
              padding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }
}