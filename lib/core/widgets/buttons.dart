// ignore_for_file: deprecated_member_use, prefer_const_constructors, duplicate_ignore, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MyButton extends StatelessWidget {
  final String btnName;
  final VoidCallback click;
  const MyButton({
    super.key,
    required this.btnName,
    required this.click,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        click();
      },
      hoverColor: Colors.white,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff635FF6),
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Center(
          child: Text(
            btnName,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }
}

class MyIcon extends StatelessWidget {
  final VoidCallback click;
  const MyIcon({
    super.key,
    required this.click,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        click();
      },
      hoverColor: Colors.white,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Color(0xff635FF6),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        child: Center(
            child: Icon(
          Ionicons.chevron_forward,
          size: 20,
          color: Colors.white,
        )),
      ),
    );
  }
}

class MyIcon1 extends StatelessWidget {
  final Color bg;
  final IconData icon;
  final Color icolor;
  final VoidCallback click;
  const MyIcon1({
    super.key,
    required this.bg,
    required this.click,
    required this.icon,
    required this.icolor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        click();
      },
      hoverColor: Colors.white,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        child: Center(
            child: Icon(
          icon,
          size: 20,
          color: icolor,
        )),
      ),
    );
  }
}
