import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Color? backgroundColor;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.backgroundColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: backgroundColor,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: AppColors.backgroundDarkLigth,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: AppColors.backgroundDarkLigth,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}