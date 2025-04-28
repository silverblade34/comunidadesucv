// ignore_for_file: prefer_const_constructors, unnecessary_import, sized_box_for_whitespace

import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/constance.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:comunidadesucv/core/widgets/buttons.dart';
import 'package:comunidadesucv/features/intro/presentation/pages/intro2.dart';
import 'package:comunidadesucv/features/intro/presentation/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';


class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 17, 61),
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
                  ConstanceData.S4,
                  height: 270,
                  width: MediaQuery.of(context).size.width,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Comparte y aprende',
                        style: TextStyle(
                          color: HexColor('#E5E3FC'),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Publica ideas, participa en conversaciones y mantente al día con lo que más te apasiona en tu vida universitaria. Este espacio es tuyo.',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: 15,
                          color:
                              AppTheme.isLightTheme
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
                        bg:
                            AppTheme.isLightTheme
                                ? HexColor('#E8E5FF')
                                : HexColor('#352A8F'),
                        click: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => IntroPage()),
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
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: HexColor('#635FF6'),
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
                            MaterialPageRoute(builder: (_) => Intro2()),
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
