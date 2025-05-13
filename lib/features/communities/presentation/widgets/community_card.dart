import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommunityCard extends StatelessWidget {
  final Space space;
  final VoidCallback onTap;

  const CommunityCard({
    super.key,
    required this.space,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String membersText = space.membersCount == 1
        ? '1 miembro'
        : '${space.membersCount} miembros';

    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildCommunityImage(context, theme),
              _buildGradientOverlay(),
              _buildCommunityInfo(context, theme, membersText),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommunityImage(BuildContext context, ThemeData theme) {
    final screenSize = MediaQuery.of(context).size;
    final int cacheSize = (screenSize.width * 1.5).toInt();

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Opacity(
        opacity: 0.9,
        child: CachedNetworkImage(
          imageUrl: space.profileImage,
          fit: BoxFit.cover,
          memCacheWidth: cacheSize,
          memCacheHeight: cacheSize,
          placeholder: (context, url) => Container(
            // ignore: deprecated_member_use
            color: theme.colorScheme.surface.withOpacity(0.3),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  // ignore: deprecated_member_use
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            // ignore: deprecated_member_use
            color: theme.colorScheme.surface.withOpacity(0.3),
            child: Icon(
              Icons.error,
              color: theme.colorScheme.error,
              size: screenSize.width * 0.08,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black54,
            Colors.black87,
          ],
          stops: [0.6, 0.8, 1.0],
        ),
      ),
    );
  }

  Widget _buildCommunityInfo(
      BuildContext context, ThemeData theme, String membersText) {
    final screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.03;

    return Positioned(
      bottom: padding,
      left: padding,
      right: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            space.name,
            style:AppFonts.subtitleCommunity,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          _buildMembersWidget(context, theme, membersText),
        ],
      ),
    );
  }

  Widget _buildMembersWidget(
      BuildContext context, ThemeData theme, String membersText) {
    final screenSize = MediaQuery.of(context).size;
    final double avatarSize = screenSize.width * 0.045;
    final double spacing = avatarSize * 0.65;
    final double textSize = screenSize.width < 400 ? 12 : 11;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (space.lastMemberships.isNotEmpty)
          SizedBox(
            width: space.lastMemberships.length == 1
                ? avatarSize + 5
                : space.lastMemberships.length == 2
                    ? avatarSize + spacing + 5
                    : space.lastMemberships.length >= 3
                        ? avatarSize + spacing * 2 + 5
                        : 0,
            height: avatarSize + 3,
            child: Stack(
              children: [
                for (int i = 0; i < space.lastMemberships.length && i < 3; i++)
                  Positioned(
                    right: i * spacing,
                    child: _buildAvatarImage(context, theme, i, avatarSize),
                  ),
              ],
            ),
          ),
        SizedBox(width: screenSize.width * 0.02),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            membersText,
            style: TextStyle(
              color: Colors.white,
              fontSize: textSize - 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarImage(
      BuildContext context, ThemeData theme, int index, double avatarSize) {
    return Container(
      decoration: index > 0
          ? BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.colorScheme.onPrimary, width: 1),
            )
          : null,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: space.lastMemberships[index].user.imageUrl,
          width: avatarSize,
          height: avatarSize,
          fit: BoxFit.cover,
          memCacheWidth: (avatarSize * 2).toInt(),
          memCacheHeight: (avatarSize * 2).toInt(),
          placeholder: (context, url) => Container(
            // ignore: deprecated_member_use
            color: theme.colorScheme.surface.withOpacity(0.3),
            width: avatarSize,
            height: avatarSize,
          ),
          errorWidget: (context, url, error) => Container(
            // ignore: deprecated_member_use
            color: theme.colorScheme.surface.withOpacity(0.3),
            width: avatarSize,
            height: avatarSize,
            child: Icon(
              Icons.person,
              size: avatarSize * 0.6,
              // ignore: deprecated_member_use
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
