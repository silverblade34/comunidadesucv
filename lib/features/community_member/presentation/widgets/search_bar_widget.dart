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
    return TextField(
      controller: controller.searchController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white,
        ),
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