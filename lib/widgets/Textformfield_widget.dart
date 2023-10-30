import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../constants/color_app.dart';
import '../utils/app_color.dart';

class FormTextForm extends StatefulWidget {
  String? TextName;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final AutovalidateMode? autovalidateMode;
  final TextInputAction? actionKeyboard;
  final String? Function(String?)? onValidate;
  final String? Function(String?)? onChange;
  final bool obsecure;
  final TextEditingController controller;

  FormTextForm(
      {Key? key,
      this.TextName,
       this.prefixIcon,
      this.onValidate,
      this.onChange,
      this.obsecure = false,
      this.suffixIcon,
      this.hintText,
      required this.controller,
      this.actionKeyboard,
      this.autovalidateMode})
      : super(key: key);

  @override
  State<FormTextForm> createState() => _FormTextFormState();
}

class _FormTextFormState extends State<FormTextForm> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(

      ),

      width: s.width * 0.80,
      height: s.height*0.05,
      child: TextFormField(
        obscureText: widget.obsecure,
        onChanged: widget.onChange,
        validator: widget.onValidate,
        textInputAction: widget.actionKeyboard,
        autovalidateMode: widget.autovalidateMode,
        controller: widget.controller,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            hintStyle: TextStyle(
              fontSize: 14,
             color: isDarkMode == true
                  ? ColorApp.colorblackgalf
                  : ColorApp.colorblackgalf,
            ),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            prefixIconColor: Colors.white,

            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }
}
