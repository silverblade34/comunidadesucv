import 'package:comunidadesucv/config/constants/responsive.dart';
import 'package:flutter/material.dart';

class CommunityRulesWidget extends StatelessWidget {
  final String? rules;
  final bool isExpanded;
  final Function() onToggle;

  const CommunityRulesWidget({
    super.key,
    required this.rules,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (rules == null || rules!.isEmpty) {
      return SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onToggle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reglas de la comunidad",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveSize.getFontSize(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,
              ),
            ],
          ),
        ),
        if (isExpanded)
          Padding(
            padding: EdgeInsets.only(top: ResponsiveSize.getHeight(context, 10)),
            child: Text(
              rules!,
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveSize.getFontSize(context, 14),
              ),
            ),
          ),
      ],
    );
  }
}