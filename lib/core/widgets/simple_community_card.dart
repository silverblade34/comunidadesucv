import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/models/space_summary.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class SimpleCommunityCard extends StatelessWidget {
  final List<SpaceSummary> spaces;
  final Color primaryColor;
  final String description;
  final bool isLoading;

  const SimpleCommunityCard({
    super.key,
    required this.spaces,
    required this.primaryColor,
    required this.description,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.isLightTheme ? Colors.black87 : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Ionicons.people_outline,
                  size: 18,
                  color: primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  description,
                  style: AppFonts.subtitleCommunity,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 15),
        if (isLoading)
          _buildShimmerEffect()
        else if (spaces.isNotEmpty)
          SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: spaces.length,
              itemBuilder: (context, index) {
                final space = spaces[index];
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(space.profileImage),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            space.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${space.membersCount} miembros",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        else
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "No se ha unido a comunidades",
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withOpacity(0.5),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildShimmerEffect() {
    return SizedBox(
      height: 150,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4, // Show 4 placeholder items while loading
          itemBuilder: (_, __) => Container(
            margin: EdgeInsets.only(right: 15),
            width: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
