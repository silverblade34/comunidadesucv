// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/constance.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/widgets/buttons.dart';
import 'package:comunidadesucv/features/intro/controllers/intro_controller.dart';
import 'package:comunidadesucv/features/intro/presentation/pages/intro1.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class IntroPage extends GetView<IntroController> {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(ConstanceData.backgroundIntro, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                Container(height: AppBar().preferredSize.height),
                Image.asset(
                  ConstanceData.S3,
                  height: 270,
                  width: MediaQuery.of(context).size.width,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Descubre tu comunidad',
                        style: TextStyle(
                          color: HexColor('#E5E3FC'),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Únete a espacios donde se comparten ideas, eventos y conocimientos según tus intereses académicos y extracurriculares.',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontSize: 15,
                              color: AppTheme.isLightTheme
                                  ? HexColor('#857FB4')
                                  : HexColor('#E5E3FC'),
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 60),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: HexColor('#635FF6'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            height: 10,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: HexColor('#E8E5FF'),
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: HexColor('#E8E5FF'),
                            ),
                          ),
                        ],
                      ),
                      MyIcon(
                        click: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Intro1()),
                          );
                        },
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
