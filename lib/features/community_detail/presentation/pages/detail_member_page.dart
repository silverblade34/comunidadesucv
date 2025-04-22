import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/models/space_summary.dart';
import 'package:comunidadesucv/features/community_detail/controllers/detail_member_controller.dart';
import 'package:comunidadesucv/features/perfil/presentation/widgets/preferences_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

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
              Obx(
                () => Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: controller.user.value.profile?.imageUrl != null
                              ? Image.network(
                                  controller.user.value.profile!.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.grey[600],
                                      ),
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.grey[600],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 5.0, right: 15.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Ionicons.chevron_back,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: [
              Obx(
                () => Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${controller.user.value.profile?.firstname ?? ""} ${controller.user.value.profile?.lastname ?? ""}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 18),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              Get.snackbar(
                                "Agregar contacto",
                                "Función para agregar contacto activada",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.isLightTheme
                                    ? HexColor('#F5F5F5')
                                    : HexColor('#1A1167'),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person_add,
                                size: 24,
                                color: AppTheme.isLightTheme
                                    ? HexColor('#1A1167')
                                    : HexColor('#FFFFFF'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Carrera',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 13),
                      ),
                      Text(
                        controller.user.value.profile?.carrera ??
                            "No especificada",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 12,
                            color: Theme.of(context).disabledColor),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Campus',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 13),
                      ),
                      Text(
                        controller.user.value.profile?.filial ??
                            "No especificado",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 12,
                            color: Theme.of(context).disabledColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mis intereses: ",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0.0,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Obx(
                              () => Wrap(
                                spacing: 10,
                                runSpacing: 15,
                                children:
                                    (controller.user.value.account?.tags !=
                                            null)
                                        ? controller.user.value.account!.tags
                                            .map((tagData) {
                                            return PreferencesTag(
                                              tag: tagData,
                                              imagePath: "assets/image/a3.png",
                                            );
                                          }).toList()
                                        : [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'Sin tags',
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              ),
                                            )
                                          ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mis comunidades",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Obx(
                      () => SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.user.value.spaces.length,
                          itemBuilder: (context, index) {
                            final item = controller.user.value.spaces[index];
                            return _buildCommunity(
                                item.name, item.profileImage, item);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildCommunity(String title, String imagePath, SpaceSummary space) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/community_detail", arguments: space.id);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color.fromRGBO(0, 0, 0, 0.5),
          ),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
