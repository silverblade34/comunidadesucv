import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/features/community_detail/controllers/community_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommunityImageLoading extends StatelessWidget {
  final CommunityDetailController controller;

  const CommunityImageLoading({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.29,
      width: double.infinity,
      child: Stack(
        children: [
          Stack(
            children: [
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                ),
              ),
              Image.network(
                controller.space.coverImage !=
                        "http://comunidadesucv.uvcv.edu.pe/static/img/default_banner.jpg"
                    ? controller.space.coverImage
                    : controller.space.profileImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container();
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey[700],
                    ),
                  );
                },
              ),
            ],
          ),
          Container(
            // ignore: deprecated_member_use
            color: Colors.purple.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
