import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../constants/color_app.dart';
import '../utils/app_color.dart';

class LogInFormForm extends StatefulWidget {
  String? TextName;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final AutovalidateMode? autovalidateMode;
  final TextInputAction? actionKeyboard;
  final String? Function(String?)? onValidate;
  final String? Function(String?)? onChange;
  final bool obsecure;
  final TextEditingController? controller;

  LogInFormForm(
      {Key? key,
      this.TextName,
       this.prefixIcon,
      this.onValidate,
      this.onChange,
      this.obsecure = false,
      this.suffixIcon,
      this.hintText,
      this.controller,
      this.actionKeyboard,
      this.autovalidateMode})
      : super(key: key);

  @override
  State<LogInFormForm> createState() => _LogInFormFormState();
}

class _LogInFormFormState extends State<LogInFormForm> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery.of(context).size;
    return Container(
      width: s.width * 0.86,
      child: TextFormField(
        style: TextStyle(
          color: isDarkMode ==
              true
              ? ColorApp
              .colorwhite
              : Colors.black
        ),
        obscureText: widget.obsecure,
        onChanged: widget.onChange,
        validator: widget.onValidate,
        textInputAction: widget.actionKeyboard,
        autovalidateMode: widget.autovalidateMode,
        controller: widget.controller,
        decoration: InputDecoration(

          border: OutlineInputBorder(



            borderRadius: BorderRadius.circular(12),
          ),


            filled: true, //<-- SEE HERE
            fillColor: ColorApp.colorblackgalf.withOpacity(0.10) ,
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            hintStyle: TextStyle(
              fontSize: 14,
              color: isDarkMode == true
                  ? ColorApp.colorwhite
                  : ColorApp.colorblackgalf,
            ),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            prefixIconColor: Colors.white,
            hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode == true
                  ? ColorApp.colorwhite
                  : ColorApp.colorblackgalf.withOpacity(0.10),

            ),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide:  BorderSide(color: ColorApp.colorprimary, width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),


        ),
      ),
    );
  }
}
