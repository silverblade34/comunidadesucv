import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/widgets/buttons.dart';
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.27,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 148, 98, 212),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "${controller.user.value.profile!.imageUrl}",
                        fit: BoxFit.cover,
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
                  SizedBox(height: 20),
                  Text(
                    'Nombre',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => MyTextField(
                      hintText:
                          "${controller.user.value.profile!.firstname} ${controller.user.value.profile!.lastname}",
                      bgcolor: AppTheme.isLightTheme
                          ? HexColor('#FFFFFF')
                          : HexColor('#0E0847'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Carrera',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => MyTextField(
                      hintText: "${controller.user.value.profile!.carrera}",
                      bgcolor: AppTheme.isLightTheme
                          ? HexColor('#FFFFFF')
                          : HexColor('#0E0847'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Campus',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => MyTextField(
                      hintText: "${controller.user.value.profile!.filial}",
                      bgcolor: AppTheme.isLightTheme
                          ? HexColor('#FFFFFF')
                          : HexColor('#0E0847'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ciclo',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    hintText: "8",
                    bgcolor: AppTheme.isLightTheme
                        ? HexColor('#FFFFFF')
                        : HexColor('#0E0847'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Antes de empezar, selecciona tus intereses:",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 150,
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Expanded(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: MyIcon(
        click: () {
          controller.loadCommunitiesScreen();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
