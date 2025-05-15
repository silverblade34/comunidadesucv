import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:flutter/material.dart';

class InterestTag extends StatelessWidget {
  final String tag;
  final bool isSelected;
  final Function(String) onPress;
  
  const InterestTag({
    super.key,
    required this.tag,
    required this.isSelected,
    required this.onPress,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(tag),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? HexColor('#635FF6')
              : AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tag,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                if (!isSelected) ...[
                  const SizedBox(height: 2),
                  Container(
                    width: 40,
                    height: 3,
                    decoration: BoxDecoration(
                      color: HexColor('#FF5D7E'),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ],
            ),
            if (isSelected) ...[
              const SizedBox(width: 10),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.check,
                  color: HexColor('#635FF6'),
                  size: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}