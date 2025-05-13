import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:comunidadesucv/features/communities/data/dto/membership_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedMembersSection extends StatelessWidget {
  final List<MembershipInfo> recommendedMemberships;
  final Function(int) getFriendshipState;

  const RecommendedMembersSection({
    super.key,
    required this.recommendedMemberships,
    required this.getFriendshipState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Intereses en común',
          style: AppFonts.subtitleCommunity,
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildInterestingMembers(context),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildInterestingMembers(BuildContext context) {
    final widgets = <Widget>[];

    for (var i = 0; i < recommendedMemberships.length; i++) {
      final member = recommendedMemberships[i];
      widgets.add(
          _buildPinnedContact(context, member.user.imageUrl, member.user.id));

      if (i < recommendedMemberships.length - 1) {
        widgets.add(const SizedBox(width: 10));
      }
    }

    return widgets;
  }

  Widget _buildPinnedContact(
      BuildContext context, String avatarUrl, int userId) {
    return GestureDetector(
      onTap: () => Get.toNamed("/detail_member", arguments: {
        "friendId": userId.toString(),
        "state": getFriendshipState(userId)
      }),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(avatarUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
