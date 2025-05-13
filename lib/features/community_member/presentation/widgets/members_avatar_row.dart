import 'dart:math';
import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class MembersAvatarRow extends StatelessWidget {
  final List memberships;
  final int totalMembersCount;
  final int spaceId;
  final bool isLoading;

  const MembersAvatarRow({
    super.key,
    required this.memberships,
    required this.totalMembersCount,
    required this.spaceId,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading || memberships.isEmpty) {
      return _buildShimmerPlaceholder();
    }

    return _buildMembersList();
  }

  Widget _buildShimmerPlaceholder() {
    const double baseWidth = 31;
    const double stepWidth = 20;
    double totalWidth = baseWidth + stepWidth * 2 + stepWidth;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: totalWidth,
          height: 35,
          child: Stack(
            children: [
              for (int i = 0; i < 3; i++) _buildShimmerAvatar(i, 3),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.shimmerHighlightColor,
              child: Container(
                height: 12,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.shimmerHighlightColor,
              child: Container(
                height: 12,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShimmerAvatar(int index, int totalVisible) {
    final rightPosition = (totalVisible - index) * 18.0;
    
    return Positioned(
      right: rightPosition,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.shimmerHighlightColor,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMembersList() {
    final memberCount = memberships.length;
    final int visibleMembers = min(memberCount, 3);
    final double baseWidth = 31;
    final double stepWidth = 20;
    double totalWidth = 0;
    
    if (visibleMembers >= 1) totalWidth += baseWidth;
    if (visibleMembers >= 2) totalWidth += stepWidth;
    if (visibleMembers >= 3) totalWidth += stepWidth;
    totalWidth += stepWidth;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: totalWidth,
          height: 35,
          child: Stack(
            children: [
              for (int i = 0; i < visibleMembers; i++)
                _buildMemberAvatar(i, visibleMembers),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              totalMembersCount == 1 ? '1 miembro' : '$totalMembersCount miembros',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/community_member', arguments: spaceId);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    child: Center(
                      child: Text(
                        'Ver todos',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 2),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMemberAvatar(int index, int totalVisible) {
    final rightPosition = (totalVisible - index) * 18.0;
    
    return Positioned(
      right: rightPosition,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: ClipOval(
          child: Image.network(
            memberships[index].user.imageUrl,
            width: 30,
            height: 30,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              width: 30,
              height: 30,
              color: Colors.grey[850],
              child: const Icon(Icons.person, color: Colors.white70, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}