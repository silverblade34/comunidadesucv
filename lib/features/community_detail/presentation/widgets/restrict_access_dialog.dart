import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestrictedAccessDialog extends StatelessWidget {
  const RestrictedAccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(ResponsiveSize.getWidth(context, 20)),
        decoration: BoxDecoration(
          color: AppColors.backgroundDialogDark,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10.0),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveSize.getWidth(context, 12)),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock, 
                size: ResponsiveSize.getWidth(context, 40), 
                color: Colors.red,
              ),
            ),
            SizedBox(height: ResponsiveSize.getHeight(context, 16)),
            Text(
              "Acceso restringido",
              style: TextStyle(
                fontSize: ResponsiveSize.getFontSize(context, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: ResponsiveSize.getHeight(context, 8)),
            Text(
              "Esta sección es exclusiva para miembros de la comunidad.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveSize.getFontSize(context, 16),
              ),
            ),
            SizedBox(height: ResponsiveSize.getHeight(context, 20)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundDarkLigth,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.getWidth(context, 30),
                  vertical: ResponsiveSize.getHeight(context, 12),
                ),
              ),
              onPressed: () => Get.back(),
              child: Text(
                "Entendido", 
                style: TextStyle(
                  fontSize: ResponsiveSize.getFontSize(context, 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}