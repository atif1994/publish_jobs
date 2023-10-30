import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_app.dart';
import '../utils/app_color.dart';

class SubmitButton extends StatelessWidget {
  String textButton;
  final GestureTapCallback onPressed;
  final double? widthButton;
  final double? heightButton;
  Icon? icon;
  BorderRadius? borderRadius;
  final Color? backGroundColor;
  final Color? textColor;
  final Border? border;
  bool? loading = false;

  SubmitButton(
      {Key? key,
      required this.textButton,
      required this.onPressed,
      this.widthButton,
      this.icon,
      this.borderRadius,
      this.heightButton,
      this.backGroundColor,
      this.textColor,
      this.border,
      this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery.of(context).size;

    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: heightButton,
        width: widthButton,
        decoration: BoxDecoration(
            border: border, color: backGroundColor, borderRadius: borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textButton,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Montserrat"),
            ),
            Padding(padding:  EdgeInsets.only(left: s.width*0.04), child: icon)
          ],
        ),
      ),
    );
  }
}
