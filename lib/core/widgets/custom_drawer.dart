import 'package:comunidadesucv/core/controllers/theme_controller.dart';
import 'package:comunidadesucv/core/widgets/my_icon3.dart';
import 'package:comunidadesucv/features/communities/controllers/communities_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:comunidadesucv/config/constants/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunitiesController controller = Get.find<CommunitiesController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Drawer(
      backgroundColor: HexColor('#635FF6'),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            InkWell(
              onTap: (){
                Get.offAllNamed("/home");
              },
              child: ClipOval(
                child: controller.user.value.profile?.imageUrl != null &&
                        controller.user.value.profile!.imageUrl.isNotEmpty
                    ? Image.network(
                        controller.user.value.profile!.imageUrl,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person, size: 40, color: Colors.grey);
                        },
                      )
                    : Icon(Icons.person, size: 40, color: Colors.grey),
              ),
            ),
            SizedBox(height: 7),
            Obx(
              () => Text(
                "${controller.user.value.profile?.firstname ?? ""} ${controller.user.value.profile?.lastname ?? ""}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      color: AppColors.textBlackUCV,
                    ),
              ),
            ),
            Text(
              'Gestión',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 12,
                    color: AppColors.textBlackUCV,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Administración | 8° Ciclo',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 10,
                    color: AppColors.textBlackUCV,
                  ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(
                    context,
                    icon: Ionicons.person_outline,
                    title: 'Mi perfil',
                    bgColor: '#31C6EE',
                    onTap: () {
                      Get.offAndToNamed("/perfil");
                    },
                  ),
                  SizedBox(height: 15),
                  _buildDrawerItem(
                    context,
                    imagePath: 'assets/image/comunities.png',
                    title: 'Comunidades digitales',
                    bgColor: '#9130EF',
                    onTap: () {
                      Get.offAndToNamed("/communities");
                    },
                  ),
                  SizedBox(height: 15),
                  _buildDrawerItem(
                    context,
                    imagePath: 'assets/image/contacts.png',
                    title: 'Contactos',
                    bgColor: '#3CE3B1',
                    onTap: () {},
                  ),
                  SizedBox(height: 15),
                  _buildDrawerItem(
                    context,
                    imagePath: 'assets/image/comment.png',
                    title: 'Mensajes',
                    bgColor: '#FFB200',
                    onTap: () {},
                  ),
                  SizedBox(height: 40),
                  _buildDrawerItem(
                    context,
                    icon: Ionicons.notifications_outline,
                    title: 'Notificaciones',
                    bgColor: '#F98C3E',
                    onTap: () {},
                  ),
                  SizedBox(height: 15),
                  _buildDrawerItem(
                    context,
                    imagePath: 'assets/image/setting.png',
                    title: 'Ajustes',
                    bgColor: '#9852F6',
                    onTap: () {},
                  ),
                  SizedBox(height: 30),
                  _buildDrawerItem(
                    context,
                    icon: Ionicons.log_in_outline,
                    title: 'Logout',
                    bgColor: '#F93888',
                    iconColor: Colors.white,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(Ionicons.moon_outline, size: 24, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  'Modo oscuro',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                ),
                Spacer(),
                Obx(() => CupertinoSwitch(
                      value: !themeController.isLightTheme,
                      activeTrackColor: Color(0xff857FB4),
                      inactiveTrackColor: Color(0xff857FB4),
                      onChanged: (bool value) {
                        themeController.toggleTheme();
                      },
                    )),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    IconData? icon,
    String? imagePath,
    required String title,
    required String bgColor,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (icon != null)
            MyIcon3(
              bg: HexColor(bgColor),
              icon: icon,
              iconColor: iconColor,
            ),
          if (imagePath != null)
            MyIcon3Png(
              bg: HexColor(bgColor),
              imagePath: imagePath,
              iconColor: AppColors.textBlackUCV,
            ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 13,
                    color: AppColors.textBlackUCV,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
