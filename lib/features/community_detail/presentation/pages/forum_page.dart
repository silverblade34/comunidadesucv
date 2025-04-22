import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/features/community_detail/controllers/forum_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ForumPage extends GetView<ForumController> {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;

    final textPrimary = isDarkMode ? Colors.white : Colors.black87;
    final textSecondary = isDarkMode ? Colors.white70 : Colors.black54;

    final universityPrimary = Color(0xFF003366);
    final universitySecondary = Color(0xFFCC9933);

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/image/logo-ucv.png',
              height: 20,
              errorBuilder: (context, error, stackTrace) => CircleAvatar(
                backgroundColor: universitySecondary,
                radius: 15,
                child: Text('U', style: TextStyle(color: universityPrimary)),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Foro comunidad UCV',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Acción de búsqueda
            },
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundDark,
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(defaultPadding),
        children: [
          Text(
            "Tu única competencia es quien fuiste ayer—mantente enfocado.",
            style: textStyle17Bold,
          ),
          const SizedBox(height: 8.0),
          Text(
            "Excelencia académica, un día a la vez.",
            style: textStyle10Regular.copyWith(color: textPrimary),
          ),
          SizedBox(height: 16),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: universitySecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "CREAR NUEVO TEMA",
                  style: TextStyle(
                    color: universityPrimary,
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
                  "user": "Prof. Garcia",
                  "title": "Anuncio: Cambio en horario de clases"
                },
                {
                  "user": "Maria Sánchez",
                  "title": "Pregunta sobre examen parcial"
                },
                {"user": "Juan Pérez", "title": "Recursos para investigación"},
                {
                  "user": "Dr. Martínez",
                  "title": "Recordatorio: Entrega de proyecto"
                },
                {
                  "user": "Estudiante Anónimo",
                  "title": "Dudas sobre la tarea 3"
                },
              ];

              return Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: AppColors.textBlackUCV,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: index == 0 ? universitySecondary : textSecondary,
                    width: index == 0 ? 2.0 : 1.0,
                  ),
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
                          "https://picsum.photos/id/${(index + 10) * 5}/200/300",
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
                          color:
                              index == 0 ? universitySecondary : textSecondary,
                          fontWeight:
                              index == 0 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      trailing: index == 0
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: universitySecondary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Importante",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: universitySecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Icon(Icons.forum, color: textSecondary),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      index == 0
                          ? "Estimados estudiantes, se informa que a partir de la próxima semana el horario de clases será modificado debido a actividades institucionales."
                          : "Lorem ipsum dolor sit amet consectetur. Tortor aenean suspendisse pretium nunc non facilisi.",
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
                              Icon(Icons.thumb_up, color: textSecondary),
                              const SizedBox(width: 4.0),
                              Text(
                                "${(30 * (index + 1))}",
                                style: textStyle10Regular,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.chat, color: textSecondary),
                              const SizedBox(width: 4.0),
                              Text(
                                "${12 * (5 - index)}",
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
