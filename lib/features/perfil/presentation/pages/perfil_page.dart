import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/enum/friendship_state.dart';
import 'package:comunidadesucv/core/widgets/perfil_interests.dart';
import 'package:comunidadesucv/core/widgets/simple_community_card.dart';
import 'package:comunidadesucv/features/communities/data/dto/membership_info.dart';
import 'package:comunidadesucv/features/communities/data/dto/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:comunidadesucv/features/perfil/controllers/perfil_controller.dart';

class PerfilPage extends GetView<PerfilController> {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.backgroundDarkLigth;
    final textColor = AppTheme.isLightTheme ? Colors.black87 : Colors.white;
    final backgroundColor =
        AppTheme.isLightTheme ? Colors.white : AppColors.backgroundDarkIntense;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(() => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Ionicons.chevron_back,
                        color: textColor,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            // ignore: deprecated_member_use
                            color: primaryColor.withOpacity(0.2),
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            controller.user.value.profile?.imageUrl ??
                                'https://via.placeholder.com/120',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person,
                              size: 60,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "${controller.user.value.profile?.firstname ?? ""} ${controller.user.value.profile?.lastname ?? ""}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        controller.user.value.account?.username ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          // ignore: deprecated_member_use
                          color: textColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(
                        icon: Ionicons.school_outline,
                        title: "Carrera",
                        value: controller.user.value.profile?.carrera ?? "",
                        color: primaryColor,
                        textColor: Color.fromARGB(255, 189, 189, 189),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      _buildInfoRow(
                        icon: Ionicons.location_outline,
                        title: "Campus",
                        value: controller.user.value.profile?.filial ?? "",
                        color: primaryColor,
                        textColor: Color.fromARGB(255, 189, 189, 189),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      _buildInfoRow(
                        icon: Ionicons.time_outline,
                        title: "Ciclo",
                        value: "8",
                        color: primaryColor,
                        textColor: Color.fromARGB(255, 189, 189, 189),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      _buildInfoRow(
                        icon: Ionicons.mail_outline,
                        title: "Correo",
                        value: controller.user.value.account?.email ?? "",
                        color: primaryColor,
                        textColor: Color.fromARGB(255, 189, 189, 189),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PerfilInterests(
                      tags: controller.user.value.account!.tags,
                      description: "Mis intereses"),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SimpleCommunityCard(
                    spaces: controller.user.value.spaces,
                    primaryColor: primaryColor,
                    description: "Mis comunidades",
                    isLoading: controller.isLoading.value,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Ionicons.person_outline,
                                size: 18,
                                color: primaryColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Mis contactos",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed("/friendships");
                            },
                            child: Text(
                              "Ver todo",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      _buildFriendList(primaryColor, textColor),
                    ],
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          )),
    );
  }

  Widget _buildFriendList(Color primaryColor, Color textColor) {
    return Obx(() {
      if (controller.dataUserFriendship.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "No tienes contactos agregados",
              style: TextStyle(
                fontSize: 14,
                // ignore: deprecated_member_use
                color: textColor.withOpacity(0.5),
              ),
            ),
          ),
        );
      }

      return SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.dataUserFriendship.length,
          itemBuilder: (context, index) {
            final friend = controller.dataUserFriendship[index];
            return _buildFriendCard(friend, primaryColor, textColor);
          },
        ),
      );
    });
  }

  Widget _buildFriendCard(
      UserInfo friend, Color primaryColor, Color textColor) {
    return GestureDetector(
      onTap: () => Get.toNamed("/detail_member", arguments: {
        "membership": MembershipInfo(
            user: friend,
            role: "",
            status: 1,
            canCancelMembership: 0,
            sendNotifications: 1,
            showAtDashboard: 1,
            memberSince: "",
            updatedAt: ""),
        "state": FriendshipState.FRIEND
      }),
      child: Container(
        width: 110,
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: [
            _buildFriendAvatar(friend, primaryColor),
            SizedBox(height: 8),
            Text(
              friend.displayName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Amigo",
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendAvatar(UserInfo friend, Color primaryColor) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          // ignore: deprecated_member_use
          color: primaryColor.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Stack(
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: AppColors.shimmerHighlightColor,
              child: Container(
                width: 75,
                height: 75,
                color: Colors.white,
              ),
            ),
            Image.network(
              friend.imageUrl,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.person,
                size: 30,
                color: primaryColor,
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor,
                  child: Container(
                    width: 75,
                    height: 75,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color textColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 3,
            ),
            Icon(
              icon,
              size: 20,
              color: color,
            ),
          ],
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppFonts.subtitleCommunity,
            ),
            SizedBox(height: 3),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
