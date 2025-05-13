import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:comunidadesucv/features/communities/presentation/widgets/community_card.dart';
import 'package:flutter/material.dart';

// Corrección del CommunitiesGrid
class CommunitiesGrid extends StatelessWidget {
  final List<Space> communities;
  final Function(int) onTap;
  
  const CommunitiesGrid({
    super.key,
    required this.communities,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    int crossAxisCount = _getCrossAxisCount(screenSize.width);
    double childAspectRatio = _getChildAspectRatio(screenSize);
    
    // Cambiado de SliverGrid a GridView
    return GridView.builder(
      // Importante: desactiva el scroll interno del GridView
      physics: const NeverScrollableScrollPhysics(),
      // Hacer que el GridView tome el tamaño de sus hijos
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: screenSize.height * 0.02,
        crossAxisSpacing: screenSize.width * 0.04,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        final community = communities[index];
        return CommunityCard(
          space: community,
          onTap: () => onTap(community.id),
        );
      },
      itemCount: communities.length,
    );
  }

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth < 400) {
      return 1;
    } else if (screenWidth < 700) {
      return 2;
    } else if (screenWidth < 1000) {
      return 3;
    } else {
      return 4;
    }
  }

  double _getChildAspectRatio(Size screenSize) {
    if (screenSize.width < 400) {
      return 1.6;
    } else if (screenSize.height < 700) {
      return 0.95;
    } else {
      return 0.85;
    }
  }
}