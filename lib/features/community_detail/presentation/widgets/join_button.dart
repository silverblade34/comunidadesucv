import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/features/community_detail/controllers/community_detail_controller.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:math';

class JoinButton extends StatelessWidget {
  final CommunityDetailController controller;
  final double top;
  final double right;

  const JoinButton({
    super.key,
    required this.controller,
    required this.top,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ConfettiWidget(
            confettiController: controller.confettiController,
            blastDirection: -pi / 2,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            maxBlastForce: 100,
            minBlastForce: 50,
            gravity: 0.1,
            colors: const [
              Colors.purple,
              Colors.deepPurple,
              Colors.pink,
              Colors.blueAccent,
              Colors.yellow,
              Colors.green,
            ],
          ),
          Obx(
            () => GestureDetector(
              onTap: controller.toggleButton,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: AppColors.primary,
                ),
                child: Row(
                  children: [
                    controller.isLoadingButton.value
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(
                            controller.isButtonMember.value
                                ? Icons.check
                                : Ionicons.person_add_outline,
                            color: Colors.white,
                            size: 18,
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      controller.isLoadingButton.value
                          ? "Procesando..."
                          : controller.isButtonMember.value
                              ? "Miembro"
                              : "Unirte",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
