import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:comunidadesucv/features/community_feed/data/repository/registered_post_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class MediaAttachment {
  final String? url;
  final String? path;
  final bool isFile;
  final MediaType type;

  MediaAttachment({
    this.url,
    this.path,
    required this.isFile,
    required this.type,
  });
}

enum MediaType { image, video }

class Community {
  final String? id;
  final String? name;
  final String? imageUrl;

  Community({this.id, this.name, this.imageUrl});
}

class RegisteredPostController extends GetxController {
  final Space space = Get.arguments;

  final TextEditingController bodyController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final RxBool isPublishing = false.obs;
  final RxList<MediaAttachment> mediaAttachments = <MediaAttachment>[].obs;
  RegisteredPostRepository registeredPostRepository =
      RegisteredPostRepository();

  @override
  void onInit() {
    super.onInit();
    // Initialize with a default community if needed
  }

  Future<void> pickImageFromGallery() async {
    try {
      if (await _pedirPermisoCamara()) {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );

        if (image != null) {
          mediaAttachments.add(MediaAttachment(
            path: image.path,
            isFile: true,
            type: MediaType.image,
          ));
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo seleccionar la imagen: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> _pedirPermisoCamara() async {
    if (await Permission.camera.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (photo != null) {
        mediaAttachments.add(MediaAttachment(
          path: photo.path,
          isFile: true,
          type: MediaType.image,
        ));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo tomar la foto: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: Duration(minutes: 5),
      );

      if (video != null) {
        mediaAttachments.add(MediaAttachment(
          path: video.path,
          isFile: true,
          type: MediaType.video,
        ));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo seleccionar el video: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeMedia(int index) {
    if (index >= 0 && index < mediaAttachments.length) {
      mediaAttachments.removeAt(index);
    }
  }

  void editMedia(int index) {
    Get.snackbar(
      'Editar',
      'Función de edición no implementada aún',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> publishPost() async {
    if (bodyController.text.isEmpty) {
      return;
    }

    try {
      isPublishing.value = true;

      Post publishedPost = await registeredPostRepository.publishPostMessage(
          bodyController.text, space.contentContainerId);

      if (mediaAttachments.isNotEmpty) {
        try {
          await uploadFilesForPost(publishedPost.id);
        } catch (fileError) {}
      } else {}
      bodyController.clear();
      mediaAttachments.clear();
      await _showPendingApprovalDialogWithAnimation();

      Get.back(result: true);
    } catch (e) {
      isPublishing.value = false;
    }
  }

  Future<void> _showPendingApprovalDialogWithAnimation() async {
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF7B2CBF),
                Color(0xFF5A189A),
              ],
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10.0)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animación de "en revisión"
              SizedBox(
                height: 80,
                width: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF9D4EDD).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF9D4EDD)),
                      ),
                    ),
                    Icon(Ionicons.document_text_outline,
                        size: 30, color: Color(0xFF9D4EDD)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "¡Publicación Enviada!",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 12),
              Text(
                "Tu publicación ha sido enviada al administrador para su revisión y aprobación.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        size: 16, color: Colors.white.withOpacity(0.7)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Te notificaremos cuando sea aprobada.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Get.back(),
                  child: Text("Continuar",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF7B2CBF),
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Future<void> uploadFilesForPost(int postId) async {
    try {
      await registeredPostRepository.uploadFilesPost(mediaAttachments, postId);
    } catch (e) {
      throw Exception("Error al subir archivos: $e");
    }
  }

  @override
  void onClose() {
    bodyController.dispose();
    super.onClose();
  }
}
