import 'package:comunidadesucv/config/constants/constance.dart';
import 'package:comunidadesucv/features/profile_configuration/controllers/profile_configuration_controller.dart';
import 'package:comunidadesucv/features/profile_configuration/presentation/widgets/interests_section.dart';
import 'package:comunidadesucv/features/profile_configuration/presentation/widgets/profile_action_button.dart';
import 'package:comunidadesucv/features/profile_configuration/presentation/widgets/profile_detail_section.dart';
import 'package:comunidadesucv/features/profile_configuration/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileConfigurationPage extends GetView<ProfileConfigurationController> {
  const ProfileConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Banner
                _buildBannerImage(constraints),

                // Main
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      ProfileHeader(
                        firstName:
                            controller.user.value.profile?.firstname ?? '',
                        lastName: controller.user.value.profile?.lastname ?? '',
                        filial: controller.user.value.profile?.filial ?? '',
                        profileImageUrl:
                            'https://trilce.ucv.edu.pe/Fotos/Mediana/${controller.user.value.profile?.codigo}.jpg',
                      ),

                      // Details
                      ProfileDetailsSection(
                        career: controller.user.value.profile?.carrera ?? '',
                        cycle: '8',
                        preferenceNameController: controller.preferenceName,
                      ),

                      // Interests
                      Obx(
                        () => InterestsSection(
                          // ignore: invalid_use_of_protected_member
                          tags: controller.tags.value,
                          onTagPress: (tag) => controller.handleTagPress(tag),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Button
                      Obx(
                        () => ProfileActionButton(
                          isLoading: controller.isLoading.value,
                          onPressed: () async {
                            controller.isLoading.value = true;
                            try {
                              await controller.loadCommunitiesScreen();
                              Get.offAllNamed("/communities");
                            } finally {
                              controller.isLoading.value = false;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBannerImage(BoxConstraints constraints) {
    return SizedBox(
      width: double.infinity,
      height: constraints.maxWidth * 0.35,
      child: Opacity(
        opacity: 0.4,
        child: Image.asset(
          ConstanceData.bannerUcvConnect,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
