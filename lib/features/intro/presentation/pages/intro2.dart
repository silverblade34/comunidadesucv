// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/constance.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/widgets/buttons.dart';
import 'package:comunidadesucv/features/intro/presentation/pages/intro1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class Intro2 extends StatefulWidget {
  const Intro2({super.key});

  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                        'Personaliza tu experiencia',
                        style: TextStyle(
                          color: HexColor('#E5E3FC'),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Selecciona tus temas de interés y recibe contenido relevante para aprovechar al máximo tu vida universitaria.',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontSize: 14,
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
                      MyIcon1(
                        bg: AppTheme.isLightTheme
                            ? HexColor('#E8E5FF')
                            : HexColor('#352A8F'),
                        click: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Intro1()),
                          );
                        },
                        icon: Ionicons.chevron_back,
                        icolor: HexColor('#635FF6'),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: HexColor('#E8E5FF'),
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
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: HexColor('#635FF6'),
                            ),
                          ),
                        ],
                      ),
                      MyIcon(
                        click: () {
                          Get.toNamed("profile_configuration");
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
