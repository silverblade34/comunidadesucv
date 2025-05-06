import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/models/space_summary.dart';
import 'package:comunidadesucv/core/models/user_friendship.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:comunidadesucv/features/perfil/controllers/perfil_controller.dart';

class PerfilPage extends GetView<PerfilController> {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = HexColor('#5E35B1');
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
                  padding: EdgeInsets.only(top: 10, bottom: 0),
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
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
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
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: primaryColor.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(
                        icon: Ionicons.school_outline,
                        title: "Carrera",
                        value: controller.user.value.profile?.carrera ?? "",
                        color: primaryColor,
                        textColor: textColor,
                      ),
                      Divider(
                          height: 15,
                          thickness: 1,
                          color: primaryColor.withOpacity(0.1)),
                      _buildInfoRow(
                        icon: Ionicons.location_outline,
                        title: "Campus",
                        value: controller.user.value.profile?.filial ?? "",
                        color: primaryColor,
                        textColor: textColor,
                      ),
                      Divider(
                          height: 15,
                          thickness: 1,
                          color: primaryColor.withOpacity(0.1)),
                      _buildInfoRow(
                        icon: Ionicons.time_outline,
                        title: "Ciclo",
                        value: "8",
                        color: primaryColor,
                        textColor: textColor,
                      ),
                      Divider(
                          height: 15,
                          thickness: 1,
                          color: primaryColor.withOpacity(0.1)),
                      _buildInfoRow(
                        icon: Ionicons.mail_outline,
                        title: "Correo",
                        value: controller.user.value.account?.email ?? "",
                        color: primaryColor,
                        textColor: textColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Ionicons.pricetag_outline,
                            size: 18,
                            color: primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Mis intereses",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      controller.user.value.account?.tags != null &&
                              controller.user.value.account!.tags.isNotEmpty
                          ? Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: controller.user.value.account!.tags
                                  .map((tagData) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: primaryColor.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    tagData,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          255, 189, 189, 189),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : Text(
                              "No se han agregado intereses",
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor.withOpacity(0.5),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                    ],
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
                                Ionicons.people_outline,
                                size: 18,
                                color: primaryColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Mis comunidades",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      controller.user.value.spaces.isNotEmpty
                          ? SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.user.value.spaces.length,
                                itemBuilder: (context, index) {
                                  final space =
                                      controller.user.value.spaces[index];
                                  return _buildCommunityCard(
                                      space, primaryColor);
                                },
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "No se han unido a comunidades",
                                  style: TextStyle(
                                    fontSize: 14,
                                    // ignore: deprecated_member_use
                                    color: textColor.withOpacity(0.5),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                    ],
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
                              // Navigate to all contacts/friends page
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
                color: textColor.withOpacity(0.5),
                fontStyle: FontStyle.italic,
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
      UserFriendship friend, Color primaryColor, Color textColor) {
    return Container(
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
    );
  }

  Widget _buildFriendAvatar(UserFriendship friend, Color primaryColor) {
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
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
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
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
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
      children: [
        Icon(
          icon,
          size: 20,
          color: color,
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: textColor.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 3),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommunityCard(SpaceSummary space, Color primaryColor) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/community_detail", arguments: space.id);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(space.profileImage),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                space.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                "${space.membersCount} miembros",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
