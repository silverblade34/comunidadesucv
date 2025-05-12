import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/core/enum/friendship_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:comunidadesucv/core/models/user_friendship.dart';
import 'package:comunidadesucv/features/perfil/controllers/friendships_controller.dart';

class FriendshipsPage extends GetView<FriendshipsController> {
  const FriendshipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.primary;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Contactos y Amigos',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.backgroundDarkIntense,
      ),
      backgroundColor: AppColors.backgroundDarkIntense,
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundDarkIntense,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TabBar(
                labelColor: primaryColor,
                // ignore: deprecated_member_use
                unselectedLabelColor: textColor.withOpacity(0.5),
                indicatorColor: primaryColor,
                indicatorWeight: 3,
                labelStyle: TextStyle(fontSize: 15),
                tabs: const [
                  Tab(
                    icon: Icon(Icons.people),
                    text: "Amigos",
                  ),
                  Tab(
                    icon: Icon(Icons.person_add),
                    text: "Recibidas",
                  ),
                  Tab(
                    icon: Icon(Icons.how_to_reg),
                    text: "Enviadas",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildFriendsTab(primaryColor, textColor),
                  _buildReceivedRequestsTab(primaryColor, textColor),
                  _buildSentRequestsTab(primaryColor, textColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsTab(Color primaryColor, Color textColor) {
    return Obx(() {
      if (controller.dataUserFriendship.isEmpty) {
        return _buildEmptyState("No tienes contactos agregados",
            "Cuando agregues amigos, aparecerán aquí");
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.dataUserFriendship.length,
        itemBuilder: (context, index) {
          final friend = controller.dataUserFriendship[index];
          return _buildFriendCard(
              friend: friend,
              primaryColor: primaryColor,
              textColor: textColor,
              actions: [
                _buildActionButton(
                  icon: Icons.visibility,
                  label: "Ver",
                  color: primaryColor,
                  onTap: () async {
                    final result =
                        await Get.toNamed("/detail_member", arguments: {
                      "friendId": friend.id.toString(),
                      "state": FriendshipState.FRIEND,
                    });

                    if (result == true) {
                      await controller.initData();
                    }
                  },
                ),
                _buildActionButton(
                  icon: Icons.person_remove,
                  label: "Eliminar",
                  color: Colors.red,
                  onTap: () {
                    _showConfirmDialog(
                        id: friend.id,
                        context: Get.context!,
                        title: "Eliminar contacto",
                        message:
                            "¿Estás seguro que deseas eliminar a ${friend.displayName} de tus contactos?",
                        onConfirm: () {
                          controller.deleteFriend(friend.id.toString());
                        });
                  },
                ),
              ]);
        },
      );
    });
  }

  Widget _buildReceivedRequestsTab(Color primaryColor, Color textColor) {
    return Obx(() {
      if (controller.dataUserFriendshipReceived.isEmpty) {
        return _buildEmptyState("No tienes solicitudes recibidas",
            "Las solicitudes de amistad aparecerán aquí");
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.dataUserFriendshipReceived.length,
        itemBuilder: (context, index) {
          final request = controller.dataUserFriendshipReceived[index];
          return _buildRequestCard(
              friend: request,
              primaryColor: primaryColor,
              textColor: textColor,
              subtitle: "Quiere ser tu amigo",
              actions: [
                _buildActionButton(
                  icon: Icons.check_circle,
                  label: "Aceptar",
                  color: Colors.green,
                  onTap: () {
                    // Implementar la acción para aceptar solicitud
                  },
                ),
                _buildActionButton(
                  icon: Icons.cancel,
                  label: "Rechazar",
                  color: Colors.red,
                  onTap: () {
                    controller.deleteFriend(request.id.toString());
                  },
                ),
              ]);
        },
      );
    });
  }

  Widget _buildSentRequestsTab(Color primaryColor, Color textColor) {
    return Obx(() {
      if (controller.dataUserFriendshipSent.isEmpty) {
        return _buildEmptyState("No tienes solicitudes enviadas",
            "Las solicitudes que envíes aparecerán aquí");
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.dataUserFriendshipSent.length,
        itemBuilder: (context, index) {
          final request = controller.dataUserFriendshipSent[index];
          return _buildRequestCard(
              friend: request,
              primaryColor: primaryColor,
              textColor: textColor,
              subtitle: "Solicitud pendiente",
              actions: [
                _buildActionButton(
                  icon: Icons.cancel,
                  label: "Cancelar",
                  color: Colors.orange,
                  onTap: () {
                    // Implementar la acción para cancelar solicitud enviada
                    _showConfirmDialog(
                        id: request.id,
                        context: Get.context!,
                        title: "Cancelar solicitud",
                        message:
                            "¿Estás seguro que deseas cancelar la solicitud enviada a ${request.displayName}?",
                        onConfirm: () {
                          controller.deleteFriend(request.id.toString());
                        });
                  },
                ),
              ]);
        },
      );
    });
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search,
            size: 80,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendCard({
    required UserFriendship friend,
    required Color primaryColor,
    required Color textColor,
    required List<Widget> actions,
  }) {
    return Card(
      color: AppColors.backgroundDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildFriendAvatar(friend, primaryColor, size: 80),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              friend.displayName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Amigo",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: actions,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard({
    required UserFriendship friend,
    required Color primaryColor,
    required Color textColor,
    required String subtitle,
    required List<Widget> actions,
  }) {
    return Card(
      color: AppColors.backgroundDark,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _buildFriendAvatar(friend, primaryColor, size: 60),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.displayName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: actions,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendAvatar(UserFriendship friend, Color primaryColor,
      {required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          // ignore: deprecated_member_use
          color: primaryColor.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Stack(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: size,
                height: size,
                color: Colors.white,
              ),
            ),
            Image.network(
              friend.imageUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.person,
                size: size * 0.4,
                color: primaryColor,
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: size,
                    height: size,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmDialog({
    required BuildContext context,
    required String title,
    required int id,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundDark,
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
