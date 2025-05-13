import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/responsive.dart';
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
      style: TextStyle(
        color: Colors.white,
        fontSize: ResponsiveSize.getFontSize(context, 30),
        fontWeight: FontWeight.bold,
      ),
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
          color: Colors.grey[600],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
