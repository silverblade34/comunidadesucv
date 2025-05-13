import 'package:comunidadesucv/config/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembersAvatarRow extends StatelessWidget {
  final List lastMemberships;
  final int totalMembersCount;
  final int spaceId;
  final bool isLoading;

  const MembersAvatarRow({
    super.key,
    required this.lastMemberships,
    required this.totalMembersCount,
    required this.spaceId,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: ResponsiveSize.getHeight(context, 30),
        width: ResponsiveSize.getWidth(context, 150),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(15),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed('/community_members', arguments: spaceId);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildMembersAvatars(context),
          SizedBox(width: ResponsiveSize.getWidth(context, 5)),
          Text(
            "$totalMembersCount miembros",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: ResponsiveSize.getFontSize(context, 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersAvatars(BuildContext context) {
    if (lastMemberships.isEmpty) {
      return SizedBox();
    }

    final displayCount = lastMemberships.length > 3 ? 3 : lastMemberships.length;
    final List<Widget> avatars = [];

    for (int i = 0; i < displayCount; i++) {
      final member = lastMemberships[i];
      final avatarSize = ResponsiveSize.getWidth(context, 30);
      
      avatars.add(
        Container(
          margin: EdgeInsets.only(right: -ResponsiveSize.getWidth(context, 10)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: avatarSize / 2,
            backgroundImage: member['profileImage'] != null
                ? NetworkImage(member['profileImage'])
                : null,
            backgroundColor: Colors.grey[700],
            child: member['profileImage'] == null
                ? Icon(
                    Icons.person,
                    size: avatarSize * 0.6,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
      );
    }

    if (lastMemberships.length > 3) {
      avatars.add(
        Container(
          margin: EdgeInsets.only(right: -ResponsiveSize.getWidth(context, 10)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: ResponsiveSize.getWidth(context, 15),
            backgroundColor: Colors.deepPurple,
            child: Text(
              "+${lastMemberships.length - 3}",
              style: TextStyle(
                fontSize: ResponsiveSize.getFontSize(context, 10),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: avatars,
    );
  }
}