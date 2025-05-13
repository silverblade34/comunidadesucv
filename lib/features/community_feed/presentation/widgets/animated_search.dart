import 'package:flutter/material.dart';

class AnimatedSearch extends StatefulWidget {
  final Function(String) onSearch;
  final bool isSearchActive;
  final VoidCallback onSearchTap;

  const AnimatedSearch({
    Key? key,
    required this.onSearch,
    required this.isSearchActive,
    required this.onSearchTap,
  }) : super(key: key);

  @override
  State<AnimatedSearch> createState() => _AnimatedSearchState();
}

class _AnimatedSearchState extends State<AnimatedSearch> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    

    _searchController.addListener(() {
      widget.onSearch(_searchController.text);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSearchActive && !oldWidget.isSearchActive) {
      _animationController.forward();
      _focusNode.requestFocus();
    } else if (!widget.isSearchActive && oldWidget.isSearchActive) {
      _animationController.reverse();
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSearchTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(128, 149, 117, 205),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return widget.isSearchActive
                      ? TextField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: 'Buscar',
                            hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
                            border: InputBorder.none,
                          ),
                        )
                      : Text(
                          'Buscar',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        );
                },
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return widget.isSearchActive
                    ? IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          widget.onSearchTap();
                        },
                      )
                    : Container(
                        margin: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 18,
                        ),
                      );
              },
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}