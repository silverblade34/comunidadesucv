import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/features/community_feed/controllers/community_feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CommunityTitle extends StatelessWidget {
  final CommunityFeedController controller;

  const CommunityTitle({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back(result: true);
            },
            child: Icon(
              Ionicons.chevron_back,
              size: 24,
              color: AppTheme.isLightTheme
                  ? HexColor("#120C45")
                  : HexColor('#FFFFFF'),
            ),
          ),
          Text(
            controller.space.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: controller.space.lastMemberships.isEmpty
                      ? 0
                      : controller.space.lastMemberships.length == 1
                          ? 28
                          : controller.space.lastMemberships.length == 2
                              ? 28 + 13
                              : controller.space.lastMemberships.length >= 3
                                  ? 28 + 13 + 13
                                  : 0,
                  height: 28,
                  child: Stack(
                    children: [
                      if (controller.space.lastMemberships.isNotEmpty)
                        Positioned(
                          right: 0,
                          child: ClipOval(
                            child: Image.network(
                              controller.space.lastMemberships[0].user.imageUrl,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if (controller.space.lastMemberships.length > 1)
                        Positioned(
                          right: 15, // 32 * 0.7 = aproximadamente 22
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                controller
                                    .space.lastMemberships[1].user.imageUrl,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      if (controller.space.lastMemberships.length > 2)
                        Positioned(
                          right: 30, // (32 * 0.7) * 2 = aproximadamente 44
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                controller
                                    .space.lastMemberships[2].user.imageUrl,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
