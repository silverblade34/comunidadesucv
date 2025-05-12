import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const ProfileActionButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: HexColor('#635FF6'),
                // ignore: deprecated_member_use
                disabledBackgroundColor: HexColor('#635FF6').withOpacity(0.6),
              ),
              child: _buildButtonContent(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Guardando...",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      );
    }
    return const Text(
      "Aceptar",
      style: TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}