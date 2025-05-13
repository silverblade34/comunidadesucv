import 'package:flutter/material.dart';

class ResponsiveSize {
  // Factor base para dispositivos de tamaño mediano (como un teléfono de 5.5")
  static const double _designScreenWidth = 380.0;
  static const double _designScreenHeight = 740.0;
  
  // Obtiene el ancho proporcional según el tamaño de la pantalla
  static double getWidth(BuildContext context, double width) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / _designScreenWidth;
    return width * scaleFactor;
  }
  
  // Obtiene el alto proporcional según el tamaño de la pantalla
  static double getHeight(BuildContext context, double height) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = screenHeight / _designScreenHeight;
    return height * scaleFactor;
  }
  
  // Obtiene el tamaño de fuente proporcional
  static double getFontSize(BuildContext context, double fontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / _designScreenWidth;
    
    // Limitamos el factor para evitar textos muy grandes en tablets
    final limitedFactor = scaleFactor < 1.5 ? scaleFactor : 1.5;
    return fontSize * limitedFactor;
  }
  
  // Verifica si el dispositivo es un teléfono pequeño
  static bool isSmallPhone(BuildContext context) {
    return MediaQuery.of(context).size.width < 340;
  }
  
  // Verifica si el dispositivo es una tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }
  
  // Devuelve un padding adaptativo según el tamaño del dispositivo
  static EdgeInsets getAdaptivePadding(BuildContext context, {
    double small = 8.0,
    double medium = 16.0,
    double large = 24.0,
  }) {
    if (isSmallPhone(context)) {
      return EdgeInsets.all(small);
    } else if (isTablet(context)) {
      return EdgeInsets.all(large);
    } else {
      return EdgeInsets.all(medium);
    }
  }
  
  // Obtiene un espaciado vertical adaptativo
  static Widget getVerticalSpacing(BuildContext context, double height) {
    return SizedBox(height: getHeight(context, height));
  }
  
  // Obtiene un espaciado horizontal adaptativo
  static Widget getHorizontalSpacing(BuildContext context, double width) {
    return SizedBox(width: getWidth(context, width));
  }
}