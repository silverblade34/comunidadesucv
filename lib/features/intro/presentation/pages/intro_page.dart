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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child:
                Image.asset(ConstanceData.backgroundIntro, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                Container(height: AppBar().preferredSize.height),
                Image.asset(
                  ConstanceData.ucvito,
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Una comunidad que vibra contigo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: HexColor('#E5E3FC'),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Descubre espacios donde compartir conocimientos, experiencias y pasiones se vuelve parte de tu día a día. Aquí, tus intereses académicos y extracurriculares encuentran una comunidad que los potencia.',
                        textAlign: TextAlign.center,
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
