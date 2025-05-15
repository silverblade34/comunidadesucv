import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PerfilInterests extends StatelessWidget {
  final List<dynamic> tags;
  final String description;

  const PerfilInterests({
    super.key,
    required this.tags,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.isLightTheme ? Colors.black87 : Colors.white;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Ionicons.pricetag_outline,
              size: 18,
              color: AppColors.backgroundDarkLigth,
            ),
            SizedBox(width: 8),
            Text(
              description,
              style: AppFonts.subtitleCommunity,
            ),
          ],
        ),
        SizedBox(height: 15),
        tags.isNotEmpty
            ? Wrap(
                spacing: 10,
                runSpacing: 10,
                children: tags.map((tagData) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: AppColors.backgroundDarkLigth.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        // ignore: deprecated_member_use
                        color: AppColors.backgroundDarkLigth.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      tagData,
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 189, 189, 189),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              )
            : Text(
                "No se han agregado intereses",
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withOpacity(0.5)
                ),
              ),
      ],
    );
  }
}
