import 'dart:ui';

import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/widgets/text_fields.dart';
import 'package:comunidadesucv/features/profile_configuration/controllers/profile_configuration_controller.dart';
import 'package:comunidadesucv/features/profile_configuration/presentation/widgets/interest_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileConfigurationPage extends GetView<ProfileConfigurationController> {
  const ProfileConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter, // Changed direction to match Reddit
                  colors: [
                    const Color(0xFF1A237E), // Darker blue at bottom
                    const Color(0xFF3949AB), // Lighter blue at top
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Obx(
                    () => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 60, left: 16, right: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.user.value.profile!.firstname} ${controller.user.value.profile!.lastname}", // Replace with actual username
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${controller.user.value.profile!.filial}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -45,
                    left: 30,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF7FFFD4),
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 4,
                        ),
                      ),
                      child: ClipOval(
                        child: Obx(() =>
                            controller.user.value.profile?.imageUrl != null
                                ? Image.network(
                                    controller.user.value.profile!.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.white,
                                  )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Carrera',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => MyTextField(
                      hintText: "${controller.user.value.profile!.carrera}",
                      bgcolor: AppTheme.isLightTheme
                          ? HexColor('#FFFFFF')
                          : HexColor('#0E0847'),
                      enabled: false,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ciclo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    hintText: "8",
                    bgcolor: AppTheme.isLightTheme
                        ? HexColor('#FFFFFF')
                        : HexColor('#0E0847'),
                    enabled: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Nombre visible en tu perfil',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: AppTheme.isLightTheme
                          // ignore: deprecated_member_use
                          ? HexColor('#FFFFFF').withOpacity(0.8)
                          // ignore: deprecated_member_use
                          : HexColor('#0E0847').withOpacity(0.6),
                    ),
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.isLightTheme
                            ? HexColor("#1A1167")
                            : HexColor('#E5E3FC'),
                      ),
                      controller: controller.preferenceName,
                      decoration: InputDecoration(
                        hintText: "Ingresa un nombre de preferencia",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.isLightTheme
                                ? HexColor("#1A1167")
                                : HexColor('#E5E3FC')),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Antes de empezar, selecciona tus intereses:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Obx(() => Wrap(
                          spacing: 10,
                          runSpacing: 15,
                          children: controller.tags.map((tagData) {
                            return InterestTag(
                              tag: tagData['tag'],
                              isSelected: tagData['isSelected'],
                              onPress: controller.handleTagPress,
                            );
                          }).toList(),
                        )),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Obx(() => Expanded(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : () async {
                                        controller.isLoading.value = true;
                                        try {
                                          await controller
                                              .loadCommunitiesScreen();
                                          Get.offAllNamed("/communities");
                                        } finally {
                                          controller.isLoading.value = false;
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  backgroundColor: HexColor('#635FF6'),
                                  disabledBackgroundColor:
                                      // ignore: deprecated_member_use
                                      HexColor('#635FF6').withOpacity(0.6),
                                ),
                                child: controller.isLoading.value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Aceptar",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        "Aceptar",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlassEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.3, size.width * 0.6,
          size.height * 0.25)
      ..quadraticBezierTo(
          size.width * 0.8, size.height * 0.2, size.width, size.height * 0.3)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
