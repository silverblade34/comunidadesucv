import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DescriptionText extends StatelessWidget {
  final String? description;
  final bool isLoading;

  const DescriptionText({
    super.key,
    required this.description,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading || description == null || description!.isEmpty) {
      return _buildShimmerDescription(context);
    }

    return Text(
      description!,
      style: AppFonts.descriptionCommunityDetail,
    );
  }

  Widget _buildShimmerDescription(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 14,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}