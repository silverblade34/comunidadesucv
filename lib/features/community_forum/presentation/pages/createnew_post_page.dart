import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/features/community_forum/controllers/createnew_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CreateNewPostPage extends GetView<CreateNewPostController> {
  const CreateNewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final petPrimary = AppColors.backgroundDark;
    final petSecondary = AppColors.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: petPrimary,
        title: Text('Crear nuevo tema',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        leading: IconButton(
          icon: Icon(Ionicons.chevron_back, color: Colors.white),
          onPressed: () => Get.back(result: true),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                hintText: 'Título del tema',
                filled: true,
                fillColor: AppColors.backgroundDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: controller.bodyController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Comparte tu experiencia, pregunta o consejo...',
                  filled: true,
                  fillColor: AppColors.backgroundDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Obx(() => controller.isUploading.value
                ? LinearProgressIndicator(
                    // ignore: deprecated_member_use
                    backgroundColor: petPrimary.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(petSecondary),
                  )
                : SizedBox.shrink()),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => controller.simulatePublishPost(),
                    icon: Obx(() => controller.isPublishing.value
                        ? SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(Icons.send, color: Colors.white)),
                    label: Text('Publicar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: petSecondary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
