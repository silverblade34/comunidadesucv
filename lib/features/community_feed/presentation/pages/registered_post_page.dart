import 'package:comunidadesucv/features/community_feed/controllers/registered_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

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
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            Obx(() => controller.selectedCommunity.value != null 
              ? Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: controller.selectedCommunity.value?.imageUrl != null 
                        ? NetworkImage(controller.selectedCommunity.value!.imageUrl!) 
                        : null,
                      child: controller.selectedCommunity.value?.imageUrl == null 
                        ? Icon(Icons.group, size: 15) 
                        : null,
                    ),
                    SizedBox(width: 8),
                    Text(
                      controller.selectedCommunity.value?.name ?? 'Cualquier...',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                )
              : SizedBox()),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.timer, color: Colors.white),
            onPressed: () => controller.schedulePost(),
          ),
          TextButton(
            onPressed: () => controller.publishPost(),
            child: Text(
              'Publicar',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
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
                      controller: controller.titleController,
                      decoration: InputDecoration(
                        hintText: 'Título',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    
                    // Media Attachments Section
                    Obx(() => controller.mediaAttachments.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: controller.mediaAttachments.length,
                            itemBuilder: (context, index) {
                              final media = controller.mediaAttachments[index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
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
                                              icon: Icon(Icons.edit, size: 16, color: Colors.white),
                                              onPressed: () => controller.editMedia(index),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Colors.black54,
                                            child: IconButton(
                                              icon: Icon(Icons.close, size: 16, color: Colors.white),
                                              onPressed: () => controller.removeMedia(index),
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
            
            // Bottom toolbar
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () => controller.showMoreOptions(),
                    tooltip: 'Más opciones',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}