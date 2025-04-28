import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class MediaAttachment {
  final String? url;
  final String? path; // For local files
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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final RxList<MediaAttachment> mediaAttachments = <MediaAttachment>[].obs;
  final Rx<Community?> selectedCommunity = Rx<Community?>(null);

  @override
  void onInit() {
    super.onInit();
    // Initialize with a default community if needed
    selectedCommunity.value =
        Community(id: '1', name: 'Cualquier...', imageUrl: null);
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
      print("=============================");
      print(e.toString());
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
      print("=============================");
      print(e.toString());
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

  void showMoreOptions() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.poll),
              title: Text('Crear encuesta'),
              onTap: () {
                Get.back();
                // Implement poll creation
              },
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('Añadir enlace'),
              onTap: () {
                Get.back();
                // Implement link addition
              },
            ),
            ListTile(
              leading: Icon(Icons.document_scanner),
              title: Text('Añadir documento'),
              onTap: () {
                Get.back();
                // Implement document addition
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  void publishPost() {
    // Implement post publishing logic
    if (titleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Por favor, añade un título a tu publicación',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Here you would upload the media files and create the post
    Get.snackbar(
      'Éxito',
      'Publicación creada correctamente',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.back();
  }

  void schedulePost() {
    // Implement post scheduling logic
    Get.dialog(
      AlertDialog(
        title: Text('Programar publicación'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Esta función te permite programar tu publicación para una fecha y hora específicas.'),
            SizedBox(height: 16),
            // Add date and time pickers here
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement scheduling logic
              Get.back();
            },
            child: Text('Programar'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }
}
