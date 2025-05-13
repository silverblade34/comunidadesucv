import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/responsive.dart';
import 'package:comunidadesucv/features/community_detail/controllers/community_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RecentPublicationsList extends StatelessWidget {
  final CommunityDetailController controller;

  const RecentPublicationsList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingLastPost.value) {
        return _buildPublicationsLoadingShimmer(context);
      }

      // Si no hay publicaciones después de cargar
      if (controller.dataPost.isEmpty) {
        return _buildEmptyPublicationsMessage(context);
      }

      // Filtrar solo las publicaciones que tienen archivos
      final postsWithFiles = controller.dataPost
          .where((post) => post.content.files.isNotEmpty)
          .toList();

      // Si después de filtrar no hay publicaciones con archivos
      if (postsWithFiles.isEmpty) {
        return _buildEmptyPublicationsMessage(context);
      }

      return SizedBox(
        height: ResponsiveSize.getHeight(context, 90),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: postsWithFiles.length,
          itemBuilder: (context, index) {
            final fileInfo = postsWithFiles[index].content.files[0];
            final int idFile = fileInfo['id'] ?? 0;

            if (idFile == 0) return SizedBox.shrink();

            return _buildRecentPublicationItem(context, idFile);
          },
        ),
      );
    });
  }

  Widget _buildPublicationsLoadingShimmer(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.getHeight(context, 90),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: ResponsiveSize.getWidth(context, 100),
            height: ResponsiveSize.getHeight(context, 90),
            margin: EdgeInsets.only(right: ResponsiveSize.getWidth(context, 10)),
            child: Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.shimmerHighlightColor,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyPublicationsMessage(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ResponsiveSize.getHeight(context, 30)),
        child: Text(
          "No hay publicaciones con imagenes",
          style: TextStyle(
            fontSize: ResponsiveSize.getFontSize(context, 12),
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildRecentPublicationItem(BuildContext context, int idFile) {
    if (!controller.imagesMap.containsKey(idFile)) {
      controller.loadImage(idFile,
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3NDMzODA1MjQsImlzcyI6Imh0dHA6Ly9jb211bmlkYWRlc3Vjdi51dmN2LmVkdS5wZSIsIm5iZiI6MTc0MzM4MDUyNCwidWlkIjoxLCJlbWFpbCI6IndlYm1hc3RlckB1Y3YuZWR1LnBlIn0.TlA5yxow3ugHd0rX3SjvhEL1W6ntQTeOHOnWR-9mncnXkpPNf2mU489GnyS5BFjNuzQS64ItfYL3PGTQ436-3w");
    }

    return Obx(
      () => Container(
        width: ResponsiveSize.getWidth(context, 100),
        height: ResponsiveSize.getHeight(context, 90),
        margin: EdgeInsets.only(right: ResponsiveSize.getWidth(context, 10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: controller.imagesMap.containsKey(idFile)
              ? DecorationImage(
                  image: MemoryImage(controller.imagesMap[idFile]!),
                  fit: BoxFit.cover,
                )
              : null,
          color: Colors.transparent,
        ),
        child: !controller.imagesMap.containsKey(idFile)
            ? Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}