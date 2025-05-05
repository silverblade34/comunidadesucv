import 'package:comunidadesucv/features/community_feed/controllers/registered_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:ionicons/ionicons.dart';

class RegisteredPostPage extends GetView<RegisteredPostController> {
  const RegisteredPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () =>
              Get.offAllNamed("/community_feed", arguments: controller.space),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Crear publicación',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        actions: [
          Icon(Ionicons.people_outline),
          SizedBox(
            width: 10,
          )
        ],
        elevation: 0,
        backgroundColor: const Color(0xFF8260F2),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    TextField(
                      controller: controller.bodyController,
                      decoration: InputDecoration(
                        hintText: '¿Sobre qué quieres hablar?',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      maxLines: null,
                    ),
                    Obx(
                      () => controller.mediaAttachments.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: controller.mediaAttachments.length,
                                itemBuilder: (context, index) {
                                  final media =
                                      controller.mediaAttachments[index];
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: media.isFile
                                              ? Image.file(
                                                  File(media.path!),
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                )
                                              : Image.network(
                                                  media.url!,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Colors.black54,
                                                child: IconButton(
                                                  icon: Icon(Icons.edit,
                                                      size: 16,
                                                      color: Colors.white),
                                                  onPressed: () => controller
                                                      .editMedia(index),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Colors.black54,
                                                child: IconButton(
                                                  icon: Icon(Icons.close,
                                                      size: 16,
                                                      color: Colors.white),
                                                  onPressed: () => controller
                                                      .removeMedia(index),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5),
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () => controller.pickImageFromGallery(),
                        tooltip: 'Seleccionar imagen',
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt_outlined),
                        onPressed: () => controller.takePhoto(),
                        tooltip: 'Tomar foto',
                      ),
                      IconButton(
                        icon: Icon(Icons.videocam_outlined),
                        onPressed: () => controller.pickVideo(),
                        tooltip: 'Seleccionar video',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isPublishing.value
                              ? null // Deshabilitar el botón mientras se está publicando
                              : () => controller.publishPost(),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Color(0xFF8260F2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: controller.isPublishing.value
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Publicando',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      width: 16,
                                      height: 16,
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
                                  'Publicar',
                                  style: TextStyle(color: Colors.white),
                                ),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
