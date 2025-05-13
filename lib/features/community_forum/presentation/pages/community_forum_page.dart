import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/features/community_forum/controllers/community_forum_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CommunityForumPage extends GetView<CommunityForumController> {
  const CommunityForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;

    final textSecondary = isDarkMode ? Colors.white70 : Colors.black54;

    final petPrimary = AppColors.backgroundDarkIntense;
    final petSecondary = AppColors.backgroundDarkLigth;

    final textStyle17Bold = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: textSecondary,
    );

    final textStyle14Bold = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: textSecondary,
    );

    final textStyle10Regular = TextStyle(
      fontSize: 10,
      color: textSecondary,
    );

    const defaultPadding = 16.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: petPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(result: true),
        ),
        title: Row(
          children: [
            Obx(() => Icon(
                  controller.spaceIcon.value,
                  color: Colors.white,
                  size: 24,
                )),
            SizedBox(width: 8),
            Text(
              'Foro ${controller.space.name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(defaultPadding),
        children: [
          Text(
            "Lo que dice la comunidad de ${controller.space.name}.",
            style: textStyle17Bold,
          ),
          SizedBox(height: 16),
          InkWell(
            onTap: () {
              // Aquí dirigiría a la página de creación de nuevo tema
              Get.toNamed('/create_forum', arguments: controller.space.id);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "CREAR NUEVO TEMA",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16.0);
            },
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final forumTopics = [
                {
                  "user": "Dr. Veterinario",
                  "title": "Anuncio: Campaña de vacunación canina",
                  "content":
                      "Estimados miembros, les informamos que la próxima semana iniciaremos una campaña gratuita de vacunación para perros en el parque central. Traigan a sus mascotas para recibir las vacunas anuales."
                },
                {
                  "user": "Laura Gómez",
                  "title": "Nutrición para gatos mayores",
                  "content":
                      "Hola a todos, mi gato tiene 12 años y estoy buscando consejos sobre la mejor alimentación para su edad."
                },
                {
                  "user": "Carlos Ruiz",
                  "title": "Adopción responsable: Mi experiencia",
                  "content":
                      "Quiero compartir mi experiencia adoptando a mi perrito Toby y algunos consejos para quienes estén considerando adoptar."
                },
                {
                  "user": "María Pet Shop",
                  "title": "Recomendaciones: Juguetes para perros activos",
                  "content":
                      "¿Alguien tiene recomendaciones de juguetes resistentes para perros que mastican mucho? Mi labrador destruye todo en minutos."
                },
                {
                  "user": "Animalista123",
                  "title": "Cuidados básicos para hámsters",
                  "content":
                      "Acabo de adoptar mi primer hámster y me gustaría saber qué cuidados especiales necesita para mantenerlo feliz y saludable."
                },
              ];

              return Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.backgroundDialogDark
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: index == 0 ? petSecondary : textSecondary,
                    width: index == 0 ? 2.0 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 24.0,
                        backgroundImage: NetworkImage(
                          "https://picsum.photos/id/${200 + (index * 10)}/200/300",
                        ),
                      ),
                      title: Text(
                        forumTopics[index]["user"] ?? "Usuario",
                        style: textStyle14Bold,
                      ),
                      subtitle: Text(
                        forumTopics[index]["title"] ?? "Título del tema",
                        style: TextStyle(
                          fontSize: 12,
                          color: index == 0 ? petSecondary : textSecondary,
                          fontWeight:
                              index == 0 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      trailing: index == 0
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: petSecondary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Importante",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: petSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Icon(
                              index % 2 == 0 ? Icons.pets : Icons.forum,
                              color: textSecondary,
                            ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      forumTopics[index]["content"] ?? "",
                      style: textStyle10Regular,
                    ),
                    const SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        // Acción para interactuar con la publicación
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.favorite,
                                  color: petPrimary.withOpacity(0.7)),
                              const SizedBox(width: 4.0),
                              Text(
                                "${(25 * (index + 1))}",
                                style: textStyle10Regular,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.chat, color: textSecondary),
                              const SizedBox(width: 4.0),
                              Text(
                                "${10 * (5 - index)}",
                                style: textStyle10Regular,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  size: 16, color: textSecondary),
                              const SizedBox(width: 4.0),
                              Text(
                                "Hace ${index + 1} día${index > 0 ? "s" : ""}",
                                style: textStyle10Regular,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Controlador para la página de creación de nuevo tema
