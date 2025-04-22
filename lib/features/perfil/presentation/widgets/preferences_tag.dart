import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:flutter/material.dart';

class PreferencesTag extends StatelessWidget {
  final String tag;
  final String imagePath;

  const PreferencesTag({
    super.key,
    required this.tag,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: HexColor('#0B0742'),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: HexColor('#4540CF'),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                height: 20.0,
                width: 20.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tag,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
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
          ),
        ],
      ),
    );
  }
}
