import 'package:comunidadesucv/features/profile_configuration/presentation/widgets/interest_tag.dart';
import 'package:flutter/material.dart';

class InterestsSection extends StatelessWidget {
  final List<Map<String, dynamic>> tags;
  final Function(String) onTagPress;

  const InterestsSection({
    super.key,
    required this.tags,
    required this.onTagPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Antes de empezar, selecciona tus intereses:",
          style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 15,
            children: tags.map((tagData) {
              return InterestTag(
                tag: tagData['tag'],
                isSelected: tagData['isSelected'],
                onPress: (tag) => onTagPress(tag),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}