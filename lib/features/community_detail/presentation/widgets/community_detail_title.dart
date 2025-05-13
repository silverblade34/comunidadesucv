import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommunityDetailTitle extends StatelessWidget {
  final String? name;
  final bool isLoading;

  const CommunityDetailTitle({
    super.key,
    required this.name,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading || name == null || name!.isEmpty) {
      return _buildShimmerTitle(context);
    }

    return Text(
      name!,
      style: AppFonts.titleCommunityDetail
    );
  }

  Widget _buildShimmerTitle(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Container(
        height: 33,
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
