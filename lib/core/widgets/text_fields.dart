// ignore_for_file: file_names, override_on_non_overriding_member, unused_import, deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, prefer_if_null_operators, unnecessary_null_comparison

import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardtype;
  final bool hideTextfild;
  final Color bgcolor;
  final bool enabled; // New parameter for enabling/disabling the field

  MyTextField({
    super.key,
    required this.hintText,
    this.keyboardtype = TextInputType.text,
    this.hideTextfild = false,
    Color? bgcolor,
    this.enabled = true, // Enabled by default
  }) : bgcolor = bgcolor ?? _getBgColor();

  static Color _getBgColor() {
    // Call your AppTheme logic here
    return AppTheme.isLightTheme ? HexColor("#F5F4FF") : HexColor('#220C61');
  }

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: widget.enabled
            ? widget.bgcolor
            : (AppTheme.isLightTheme
                ? widget.bgcolor.withOpacity(0.8)
                : widget.bgcolor.withOpacity(0.6)),
      ),
      child: TextFormField(
        keyboardType: widget.keyboardtype,
        cursorColor: Theme.of(context).primaryColor,
        enabled: widget.enabled,
        style: TextStyle(
          fontSize: 13,
          color:
              AppTheme.isLightTheme ? HexColor("#1A1167") : HexColor('#E5E3FC'),
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.isLightTheme
                  ? HexColor("#1A1167")
                  : HexColor('#E5E3FC')),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey, // puedes personalizar el color
              width: 0.5, // borde delgado
            ),
            borderRadius: BorderRadius.circular(17),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(17),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }
}

class SearchTextField extends StatefulWidget {
  final String hintText;
  final VoidCallback sclick;

  const SearchTextField({
    super.key,
    required this.hintText,
    required this.sclick,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 12),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color:
            AppTheme.isLightTheme ? HexColor("#FFFFFF") : HexColor('#0E0847'),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Theme.of(context).primaryColor,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: 12,
                  color: AppTheme.isLightTheme
                      ? HexColor("#120C45")
                      : HexColor('#FFFFFF')),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                suffixIcon: InkWell(
                  onTap: () {
                    widget.sclick;
                  },
                  child: Icon(
                    Ionicons.search,
                    size: 22,
                    color: AppTheme.isLightTheme
                        ? HexColor("#120C45")
                        : HexColor('#FFFFFF'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
