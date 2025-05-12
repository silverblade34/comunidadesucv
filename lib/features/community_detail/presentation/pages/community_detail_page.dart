import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/features/community_detail/controllers/community_detail_controller.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/community_image_loading.dart';
import 'package:comunidadesucv/features/community_detail/presentation/widgets/community_rules.dart';
import 'package:comunidadesucv/features/community_member/presentation/widgets/members_avatar_row.dart';
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
              CommunityImageLoading(
                controller: controller,
              ),
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
                                SizedBox(height: 15),
                                Obx(() => CommunityRulesWidget(
                                      rules: controller.space.value.about,
                                      isExpanded:
                                          controller.isRulesExpanded.value,
                                      onToggle: controller.toggleRulesExpanded,
                                    )),
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
                          label: "Publicaciones",
                          iconBackgroundColor: Colors.blue,
                          onTap: () async {
                            if (controller.isButtonMember.value) {
                              final result = await Get.toNamed(
                                  "/community_feed",
                                  arguments: controller.space.value);

                              if (result == true) {
                                await controller.loadLastPostContainer();
                              }
                            } else {
                              showCustomDialog();
                            }
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.calendar_today,
                          label: "Agenda UCV",
                          iconBackgroundColor: Colors.purple.shade300,
                          onTap: () => Get.offAllNamed("/events",
                              arguments: controller.space.value),
                        ),
                        _buildMenuItem(
                          icon: Icons.group,
                          label: "Lo que dice la comunidad",
                          iconBackgroundColor: Colors.orange,
                          onTap: () async {
                            final result = await Get.toNamed("/community_forum",
                                arguments: controller.space.value);

                            if (result == true) {
                              await controller.loadLastPostContainer();
                            }
                          },
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

  void showCustomDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.backgroundDialogDark,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10.0)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.lock, size: 40, color: Colors.red),
              ),
              SizedBox(height: 16),
              Text(
                "Acceso restringido",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Esta sección es exclusiva para miembros de la comunidad.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundDarkLigth,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                onPressed: () => Get.back(),
                child: Text("Entendido", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
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
      if (controller.isLoadingLastPost.value) {
        return _buildPublicationsLoadingShimmer();
      }

      // Si no hay publicaciones después de cargar
      if (controller.dataPost.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              "No hay publicaciones con imagenes",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        );
      }

      // Filtrar solo las publicaciones que tienen archivos
      final postsWithFiles = controller.dataPost
          .where((post) => post.content.files.isNotEmpty)
          .toList();

      // Si después de filtrar no hay publicaciones con archivos
      if (postsWithFiles.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              "No hay publicaciones con imagenes",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        );
      }

      return SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: postsWithFiles.length,
          itemBuilder: (context, index) {
            final fileInfo = postsWithFiles[index].content.files[0];
            final int idFile = fileInfo['id'] ?? 0;

            if (idFile == 0) return SizedBox.shrink();

            return _buildRecentPublicationItem(idFile);
          },
        ),
      );
    });
  }

// Método para mostrar shimmer mientras se cargan las publicaciones
  Widget _buildPublicationsLoadingShimmer() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(right: 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
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

  Widget _buildRecentPublicationItem(int idFile) {
    if (!controller.imagesMap.containsKey(idFile)) {
      controller.loadImage(idFile,
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3NDMzODA1MjQsImlzcyI6Imh0dHA6Ly9jb211bmlkYWRlc3Vjdi51dmN2LmVkdS5wZSIsIm5iZiI6MTc0MzM4MDUyNCwidWlkIjoxLCJlbWFpbCI6IndlYm1hc3RlckB1Y3YuZWR1LnBlIn0.TlA5yxow3ugHd0rX3SjvhEL1W6ntQTeOHOnWR-9mncnXkpPNf2mU489GnyS5BFjNuzQS64ItfYL3PGTQ436-3w");
    }

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
          color: Colors.transparent,
        ),
        child: !controller.imagesMap.containsKey(idFile)
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
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
