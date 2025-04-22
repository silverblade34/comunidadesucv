import 'package:flutter/material.dart';

class MyIcon3 extends StatelessWidget {
  final Color bg; // Color de fondo
  final IconData icon; // Icono
  final Color iconColor; // Color del icono

  const MyIcon3({
    super.key,
    required this.bg,
    required this.icon,
    this.iconColor = Colors.white, // Color del icono por defecto blanco
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: bg, // Fondo con el color que se pasa
        borderRadius: BorderRadius.all(Radius.circular(35)),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 16,
          color: iconColor, // Usa el color del icono que se pasa
        ),
      ),
    );
  }
}

class MyIcon3Png extends StatelessWidget {
  final Color bg; // Color de fondo
  final String imagePath; // Ruta del archivo PNG
  final Color
      iconColor; // Color del icono (no necesario para PNG, pero lo dejamos por compatibilidad)

  const MyIcon3Png({
    super.key,
    required this.bg,
    required this.imagePath, // Ahora se recibe una ruta de imagen PNG
    this.iconColor =
        Colors.white, // Color del icono por defecto blanco (no se usa en PNG)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: bg, // Fondo con el color que se pasa
        borderRadius: BorderRadius.all(Radius.circular(35)),
      ),
      child: Center(
        child: Image.asset(
          imagePath, // Carga el PNG desde la ruta proporcionada
          height: 16, // Tamaño de la imagen
          width: 16, // Tamaño de la imagen
        ),
      ),
    );
  }
}
