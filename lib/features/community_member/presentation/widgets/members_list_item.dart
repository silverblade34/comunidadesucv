import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/core/enum/friendship_state.dart';
import 'package:comunidadesucv/features/community_member/controllers/community_member_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MemberListItem extends StatelessWidget {
  final CommunityMemberController controller;
  final int id;
  final String name;
  final String details;
  final String avatar;
  final String Function(String) getDisplayName;
  final Function(int, String, dynamic) onIconTap;
  final Color? statusColor;

  const MemberListItem({
    super.key,
    required this.controller,
    required this.id,
    required this.name,
    required this.details,
    required this.avatar,
    required this.getDisplayName,
    required this.onIconTap,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final friendshipState = controller.getFriendshipState(id);

      IconData friendIcon;
      Color iconColor;
      String tooltip;

      switch (friendshipState) {
        case FriendshipState.SELF:
          friendIcon = Ionicons.person_circle_outline;
          iconColor = Colors.purple;
          tooltip = "Mi perfil";
          break;
        case FriendshipState.NO_FRIEND:
          friendIcon = Ionicons.person_add_outline;
          iconColor = Colors.blue;
          tooltip = "Enviar solicitud";
          break;
        case FriendshipState.FRIEND:
          friendIcon = Ionicons.people_outline;
          iconColor = Colors.green;
          tooltip = "Amigos";
          break;
        case FriendshipState.REQUEST_SENT:
          friendIcon = Ionicons.hourglass_outline;
          iconColor = Colors.orange;
          tooltip = "Solicitud pendiente";
          break;
        case FriendshipState.REQUEST_RECEIVED:
          friendIcon = Ionicons.hourglass_outline;
          iconColor = Colors.purple;
          tooltip = "Responder solicitud";
          break;
      }

      return GestureDetector(
        onTap: () async {
          if (friendshipState == FriendshipState.SELF) {
            Get.toNamed("/perfil");
          } else {
            final result = await Get.toNamed("/detail_member", arguments: {
              "friendId": id.toString(),
              "state": friendshipState,
            });

            if (result == true) {
              await controller.init();
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: friendshipState == FriendshipState.SELF
                // ignore: deprecated_member_use
                ? AppColors.backgroundDialogDark.withOpacity(0.7)
                : AppColors.backgroundDialogDark,
            borderRadius: BorderRadius.circular(20),
            border: friendshipState == FriendshipState.SELF
                // ignore: deprecated_member_use
                ? Border.all(color: Colors.purple.withOpacity(0.5), width: 1)
                : null,
          ),
          child: Row(
            children: [
              _buildAvatar(context, friendshipState),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNameRow(context, friendshipState),
                    Text(
                      details,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: friendshipState == FriendshipState.REQUEST_SENT
                    ? null
                    : () => onIconTap(id, name, friendshipState),
                child: Tooltip(
                  message: tooltip,
                  child: Icon(
                    friendIcon,
                    size: 18,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAvatar(BuildContext context, FriendshipState friendshipState) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(avatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (friendshipState == FriendshipState.SELF)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.star,
                size: 10,
                color: Colors.white,
              ),
            ),
          )
        else if (statusColor != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNameRow(BuildContext context, FriendshipState friendshipState) {
    return Row(
      children: [
        Text(
          getDisplayName(name),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: friendshipState == FriendshipState.SELF
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
        ),
        if (friendshipState == FriendshipState.SELF)
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "(Tú)",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.purple,
                  ),
            ),
          ),
      ],
    );
  }
}
