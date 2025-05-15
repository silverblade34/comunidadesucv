import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/widgets/avatar_image.dart';
import 'package:comunidadesucv/core/widgets/perfil_interests.dart';
import 'package:comunidadesucv/core/widgets/simple_community_card.dart';
import 'package:comunidadesucv/features/community_member/controllers/detail_member_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:comunidadesucv/core/enum/friendship_state.dart';

class DetailMemberPage extends GetView<DetailMemberController> {
  const DetailMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipOval(
                          child: AvatarImage(
                              avatar:
                                  'https://trilce.ucv.edu.pe/Fotos/Mediana/${controller.membership.user.codigo}.jpg',
                              avatarError: controller.membership.user.imageUrl,
                              width: 180,
                              height: 180)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Get.back(result: true);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 5.0, right: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Ionicons.chevron_back,
                          size: 24,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: AppTheme.isLightTheme
                        ? HexColor('#FFFFFF')
                        : HexColor('#0E0847'),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          controller.membership.user.displayName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 16),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Carrera',
                            style: AppFonts.subtitleCommunity,
                          ),
                          Spacer(),
                          buildFriendshipButton(context),
                        ],
                      ),
                      Text(
                        controller.membership.user.carrera ?? "No especificada",
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).disabledColor),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Campus',
                        style: AppFonts.subtitleCommunity,
                      ),
                      Text(
                        controller.membership.user.filial ?? "No especificado",
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).disabledColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: PerfilInterests(
                    tags: controller.membership.user.tags,
                    description: "Intereses",
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SimpleCommunityCard(
                      spaces: controller.user.value.spaces,
                      primaryColor: AppColors.backgroundDarkLigth,
                      description: "Comunidades",
                      isLoading: controller.isLoading.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFriendshipButton(BuildContext context) {
    return GetBuilder<DetailMemberController>(
      builder: (controller) {
        IconData buttonIcon;
        String buttonText;
        Color buttonColor;
        Color textColor;
        VoidCallback onTapAction;

        switch (controller.state) {
          case FriendshipState.SELF:
            buttonIcon = Icons.edit;
            buttonText = "Editar perfil";
            buttonColor = Theme.of(context).primaryColor;
            textColor = Colors.white;
            onTapAction = () {
              Get.toNamed("/edit_profile");
            };
            break;
          case FriendshipState.NO_FRIEND:
            buttonIcon = Icons.person_add;
            buttonText = "Enviar solicitud";
            buttonColor = Theme.of(context).primaryColor;
            textColor = Colors.white;
            onTapAction = () {
              controller
                  .sendAndAcceptRequestFriend(FriendshipState.REQUEST_SENT);
            };
            break;
          case FriendshipState.FRIEND:
            buttonIcon = Icons.check_circle;
            buttonText = "Amigos";
            buttonColor = Colors.green;
            textColor = Colors.white;
            onTapAction = () {
              _showFriendOptions(context);
            };
            break;
          case FriendshipState.REQUEST_SENT:
            buttonIcon = Icons.hourglass_top;
            buttonText = "Solicitud enviada";
            buttonColor = Colors.orange;
            textColor = Colors.white;
            onTapAction = () {
              controller.deleteFriend();
            };
            break;
          case FriendshipState.REQUEST_RECEIVED:
            buttonIcon = Icons.hourglass_bottom;
            buttonText = "Solicitud recibida";
            buttonColor = Colors.purple;
            textColor = Colors.white;
            onTapAction = () {
              _showFriendRequestOptions(context);
            };
            break;
        }

        return InkWell(
          onTap: onTapAction,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(buttonIcon, size: 16, color: textColor),
                SizedBox(width: 4),
                Obx(() {
                  return controller.isSendingRequest.value
                      ? SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(textColor),
                          ),
                        )
                      : Text(
                          buttonText,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFriendRequestOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundDialogDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Solicitud de amistad",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.check, color: Colors.green),
              title: Text("Aceptar solicitud"),
              onTap: () {
                controller.sendAndAcceptRequestFriend(FriendshipState.FRIEND);
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.close, color: Colors.red),
              title: Text("Rechazar solicitud"),
              onTap: () {
                controller.deleteFriend();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFriendOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundDialogDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Opciones de amistad",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person_remove, color: Colors.red),
              title:
                  Text("Eliminar amigo", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                controller.deleteFriend();
              },
            ),
          ],
        ),
      ),
    );
  }
}
