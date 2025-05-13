import 'package:comunidadesucv/config/constants/responsive.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconBackgroundColor;
  final Function() onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.iconBackgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSize.getWidth(context, 20),
          vertical: ResponsiveSize.getHeight(context, 6),
        ),
        child: Row(
          children: [
            Container(
              width: ResponsiveSize.getWidth(context, 40),
              height: ResponsiveSize.getHeight(context, 40),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: ResponsiveSize.getWidth(context, 15)),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: ResponsiveSize.getFontSize(context, 13),
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }
}