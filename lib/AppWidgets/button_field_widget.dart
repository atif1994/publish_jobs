import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class BtnFieldWidgets extends StatefulWidget {
  final String? text;

  final dynamic? Ontap;

  const BtnFieldWidgets({Key? key, required this.text, required this.Ontap})
      : super(key: key);

  @override
  State<BtnFieldWidgets> createState() => _BtnFieldWidgetsState();
}

class _BtnFieldWidgetsState extends State<BtnFieldWidgets> {
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return GestureDetector(
      onTap: widget.Ontap,
      child: Container(
          height: s.height * 0.066,
          width: s.width * 0.270,
          decoration: BoxDecoration(
              color: isDarkMode == true
                  ? AppColors.colorprimary
                  : AppColors.colorprimary,
              // border: Border.all(width: 1, color: AppColors.colorprimary),
              borderRadius: BorderRadius.circular(8)

          ),
          padding: EdgeInsets.all(6),
          child: Center(
              child: Text(
            "${widget.text}",
            textAlign: TextAlign.center,
            style: TextStyle(color: isDarkMode == true
                ? Colors.black
                : AppColors.colorwhite,
            fontWeight: FontWeight.bold),
          )
          )),
    );
  }
}
