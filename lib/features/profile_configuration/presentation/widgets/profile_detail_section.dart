import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/fonts.dart';
import 'package:comunidadesucv/features/profile_configuration/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ProfileDetailsSection extends StatelessWidget {
  final String career;
  final String cycle;
  final TextEditingController preferenceNameController;

  const ProfileDetailsSection({
    super.key,
    required this.career,
    required this.cycle,
    required this.preferenceNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Carrera'),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: career,
          enabled: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        const SizedBox(height: 10),
        _buildSectionTitle('Ciclo'),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: cycle,
          enabled: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        const SizedBox(height: 10),
        _buildSectionTitle('Nombre visible en tu perfil'),
        const SizedBox(height: 10),
        _buildPreferenceNameField(context),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppFonts.intermediateLabel,
    );
  }

  Widget _buildPreferenceNameField(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: AppColors.backgroundDark,
        border: Border.all(
          color: AppColors.primary,
          width: 0.5,
        ),
      ),
      child: TextFormField(
        controller: preferenceNameController,
        cursorColor: AppColors.primary,
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Ingresa un nombre de preferencia",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: const Color.fromARGB(184, 183, 183, 183),
          ),
          enabledBorder: _buildInputBorder(Colors.black54),
          focusedBorder: _buildInputBorder(AppColors.backgroundDark),
          // border: _buildInputBorder(Colors.black54),
        ),
      ),
    );
  }

  InputBorder _buildInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(17),
    );
  }
}
