import 'package:comunidadesucv/core/widgets/custom_alert_dialog.dart';
import 'package:comunidadesucv/features/community_forum/data/repository/community_forum_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPostController extends GetxController {
  final int contentContainerId = Get.arguments;
  CommunityForumRepository communityForumRepository =
      CommunityForumRepository();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final mediaAttachments = <String>[].obs;
  final isUploading = false.obs;
  final isPublishing = false.obs;

  Future<void> simulatePublishPost() async {
    if (bodyController.text.isEmpty) {
      return;
    }

    try {
      isPublishing.value = true;

      await communityForumRepository.publishQuestion(
          titleController.text, bodyController.text, contentContainerId);

      await _showPendingApprovalDialogWithAnimation();

      titleController.clear();
      bodyController.clear();
      mediaAttachments.clear();

      Get.back(result: true);
    } catch (e) {
      CustomAlertDialog.show(
        status: 'warning',
        message: '¡Atención!',
        description:
            'No se ha podido registrar su tema, intentelo de nuevo mas tarde por favor',
        buttonText: 'Aceptar',
        onAccept: () {
          Get.back(result: true);
        },
      );
    } finally {
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
                    Icon(Icons.group, size: 30, color: Color(0xFF9D4EDD)),
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
                        "Te notificaremos cuando tu publicación sea aprobada para la comunidad Pet Lovers.",
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

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }
}
