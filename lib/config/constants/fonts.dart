import 'package:flutter/material.dart';

class AppFonts {
  static const String fontFamily = 'Montserrat';

  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 56, 56, 56),
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle titleForm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 19,
    fontWeight: FontWeight.normal,
    color: Color.fromARGB(255, 56, 56, 56),
  );

  static const TextStyle labelForm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: Color.fromARGB(255, 56, 56, 56),
  );

  static const TextStyle titleAppBar = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
