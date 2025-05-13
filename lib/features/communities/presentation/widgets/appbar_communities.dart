import 'package:comunidadesucv/config/constants/constance.dart';
import 'package:flutter/material.dart';

class AppBarCommunities extends StatelessWidget {
  const AppBarCommunities({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          ConstanceData.LogoUcv,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
          cacheWidth: 48,
          cacheHeight: 48,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Comunidades Digitales',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
