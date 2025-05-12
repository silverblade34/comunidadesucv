import 'package:comunidadesucv/features/community_member/controllers/community_member_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FriendOptionsSheet extends StatelessWidget {
  final CommunityMemberController controller;
  final int userId;
  final String name;

  const FriendOptionsSheet({
    super.key,
    required this.controller,
    required this.userId,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Opciones de amistad",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Ionicons.person_remove_outline, color: Colors.red),
            title:
                Text("Eliminar amistad", style: TextStyle(color: Colors.red)),
            onTap: () {
              controller.deleteFriend(userId.toString());
            },
          ),
        ],
      ),
    );
  }
}

class FriendRequestOptionsSheet extends StatelessWidget {
  final int userId;
  final String name;

  const FriendRequestOptionsSheet({
    super.key,
    required this.userId,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Solicitud de amistad de $name",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.snackbar(
                      "Solicitud aceptada",
                      "Ahora eres amigo de $name",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  icon: Icon(Ionicons.checkmark_outline, color: Colors.white),
                  label: Text("Aceptar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.snackbar(
                      "Solicitud rechazada",
                      "Has rechazado la solicitud de $name",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  icon: Icon(Ionicons.close_outline, color: Colors.white),
                  label: Text("Rechazar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }
}
