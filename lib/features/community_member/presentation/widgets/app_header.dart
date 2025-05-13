import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final Widget? trailingWidget;

  const AppHeader({
    super.key,
    required this.title,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back(result: true);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
              child: Icon(
                Ionicons.chevron_back,
                size: 24,
                color: AppTheme.isLightTheme
                    ? HexColor("#120C45")
                    : HexColor('#FFFFFF'),
              ),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          trailingWidget ?? SizedBox(),
        ],
      ),
    );
  }
}
