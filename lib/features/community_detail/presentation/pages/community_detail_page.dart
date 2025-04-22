import 'package:comunidadesucv/features/community_detail/controllers/community_detail_controller.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/members_avatar_row.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:math';

import 'package:shimmer/shimmer.dart';

class CommunityDetailPage extends GetView<CommunityDetailController> {
  const CommunityDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              buildProfileImageWithLoading(context),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.space.value.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MembersAvatarRow(
                                      memberships: controller
                                          .space.value.lastMemberships,
                                      totalMembersCount:
                                          controller.space.value.membersCount,
                                      spaceId: controller.space.value.id,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Text(
                                  controller.space.value.description,
                                  style: TextStyle(
                                      // ignore: deprecated_member_use
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Publicaciones recientes",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(height: 15),
                              buildRecentPublicationsList(),
                            ],
                          ),
                        ),
                        _buildMenuItem(
                          icon: Icons.bookmark_border,
                          label: "Timeline",
                          iconBackgroundColor: Colors.blue,
                          onTap: () => Get.offAllNamed("/community_feed",
                              arguments: controller.space.value),
                        ),
                        _buildMenuItem(
                          icon: Icons.calendar_today,
                          label: "Eventos",
                          iconBackgroundColor: Colors.purple.shade300,
                          onTap: () => Get.toNamed("/events",
                              arguments: controller.space.value),
                        ),
                        _buildMenuItem(
                          icon: Icons.group,
                          label: "Foros",
                          iconBackgroundColor: Colors.orange,
                          onTap: () => Get.toNamed("/forum",
                              arguments: controller.space.value),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 10,
            child: GestureDetector(
              onTap: () => Get.offAllNamed("/communities"),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF9D4EDD),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: MediaQuery.of(context).size.height * 0.3 - 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ConfettiWidget(
                  confettiController: controller.confettiController,
                  blastDirection: -pi / 2,
                  blastDirectionality: BlastDirectionality.explosive,
                  emissionFrequency: 0.05,
                  numberOfParticles: 50,
                  maxBlastForce: 100,
                  minBlastForce: 50,
                  gravity: 0.1,
                  colors: const [
                    Colors.purple,
                    Colors.deepPurple,
                    Colors.pink,
                    Colors.blueAccent,
                    Colors.yellow,
                    Colors.green,
                  ],
                ),
                Obx(
                  () => GestureDetector(
                    onTap: controller.toggleButton,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.deepPurple.shade400,
                      ),
                      child: Row(
                        children: [
                          controller.isLoading.value
                              ? SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Icon(
                                  controller.isButtonMember.value
                                      ? Icons.check
                                      : Ionicons.person_add_outline,
                                  color: Colors.white,
                                  size: 18,
                                ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            controller.isLoading.value
                                ? "Procesando..."
                                : controller.isButtonMember.value
                                    ? "Miembro"
                                    : "Unirte",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required Color iconBackgroundColor,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: 15),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget buildRecentPublicationsList() {
    return Obx(() {
      if (controller.dataPost.isEmpty) {
        return Center(
          child: Text("No hay publicaciones con archivos",
              style: TextStyle(fontSize: 12)),
        );
      }

      return SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.dataPost.length,
          itemBuilder: (context, index) {
            if (controller.dataPost[index].content.files.isNotEmpty) {
              final fileInfo = controller.dataPost[index].content.files[0];
              final int idFile = fileInfo['id'] ?? '';
              return _buildRecentPublicationItem(idFile);
            }
            return SizedBox.shrink();
          },
        ),
      );
    });
  }

  Widget _buildRecentPublicationItem(int idFile) {
    controller.loadImage(idFile,
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3NDMzODA1MjQsImlzcyI6Imh0dHA6Ly9jb211bmlkYWRlc3Vjdi51dmN2LmVkdS5wZSIsIm5iZiI6MTc0MzM4MDUyNCwidWlkIjoxLCJlbWFpbCI6IndlYm1hc3RlckB1Y3YuZWR1LnBlIn0.TlA5yxow3ugHd0rX3SjvhEL1W6ntQTeOHOnWR-9mncnXkpPNf2mU489GnyS5BFjNuzQS64ItfYL3PGTQ436-3w");

    return Obx(
      () => Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: controller.imagesMap.containsKey(idFile)
              ? DecorationImage(
                  image: MemoryImage(controller.imagesMap[idFile]!),
                  fit: BoxFit.cover,
                )
              : null,
          color: Colors.grey[300],
        ),
        child: !controller.imagesMap.containsKey(idFile)
            ? Center(child: CircularProgressIndicator())
            : null,
      ),
    );
  }

  Widget buildProfileImageWithLoading(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: Stack(
        children: [
          Obx(() {
            if (controller.space.value.profileImage.isEmpty) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                ),
              );
            }

            return Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                  ),
                ),
                Image.network(
                  controller.space.value.profileImage,
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
            );
          }),
          Container(
            color: Colors.purple.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
