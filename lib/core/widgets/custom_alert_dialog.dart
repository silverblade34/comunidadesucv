import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog {
  /// Muestra un diálogo de alerta personalizado
  ///
  /// [status]: Estado de la alerta ('success', 'warning', 'error', 'info')
  /// [message]: Mensaje principal que se mostrará
  /// [description]: Descripción adicional opcional
  /// [buttonText]: Texto para el botón (por defecto "Aceptar")
  /// [onAccept]: Función callback que se ejecutará al presionar el botón
  static Future<void> show({
    required String status,
    required String message,
    String? description,
    String buttonText = "Aceptar",
    Function()? onAccept,
  }) async {
    // Configuración según el status
    late IconData statusIcon;
    late List<Color> gradientColors;
    late Color accentColor;

    switch (status.toLowerCase()) {
      case 'success':
        statusIcon = Icons.check_circle;
        gradientColors = [
          Color(0xFF8FBF99),
          Color(0xFF6FA87A)
        ]; // verde pastel oscuro
        accentColor = Color(0xFF5C9966);
        break;
      case 'warning':
        statusIcon = Icons.warning_amber;
        gradientColors = [
          Color(0xFFF2C98A),
          Color(0xFFE5A94D)
        ]; // ámbar pastel oscuro
        accentColor = Color(0xFFD18E36);
        break;
      case 'error':
        statusIcon = Icons.error;
        gradientColors = [Color(0xFFF28B82), Color(0xFFE57373)]; // rojo pastel
        accentColor = Color(0xFFCC5C5C);
        break;
      case 'info':
      default:
        statusIcon = Icons.info;
        gradientColors = [
          Color(0xFFA79ABF),
          Color(0xFF8E7BAA)
        ]; // morado grisáceo pastel
        accentColor = Color(0xFF7B699A);
        break;
    }

    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10.0)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ícono con animación
              SizedBox(
                height: 80,
                width: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                      ),
                    ),
                    Icon(statusIcon, size: 30, color: accentColor),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12),
              if (description != null) ...[
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8),
              ],
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Get.back();
                    if (onAccept != null) onAccept();
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 16,
                      color: gradientColors[0],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
