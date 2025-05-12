import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ionicons/ionicons.dart';

class CommunityRulesWidget extends StatelessWidget {
  final String rules;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(10),
              // ignore: deprecated_member_use
              color: Colors.deepPurple.withOpacity(0.1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Ionicons.information_circle_outline,
                  color: Color(0xFF9D4EDD),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  "Reglas de la comunidad",
                  style: TextStyle(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Color(0xFF9D4EDD),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 400),
          height: isExpanded ? null : 0,
          margin: EdgeInsets.only(top: isExpanded ? 12 : 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // ignore: deprecated_member_use
                  color: Colors.deepPurple.withOpacity(0.08),
                  border: Border.all(
                    // ignore: deprecated_member_use
                    color: Colors.deepPurple.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Normas y directrices",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      // ignore: deprecated_member_use
                      color: Colors.deepPurple.withOpacity(0.3),
                      height: 24,
                    ),
                    MarkdownBody(
                      data: rules,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
