import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class TxtFieldWidget extends StatefulWidget {
  final bool obscuretxt;
  final String? hintTxt;
  final IconData? IconLeft;
  final IconData? IconRight;
  final AutovalidateMode?autovalidateMode;
  final TextEditingController? textEditingController;
  final bool? enabled;
  final TextInputType? textInputType;
  final String? Function(String?)? onValidate;
  final String? Function(String?)? onChange;
  final Color? fillcolor;
  final String? initialvalue;
  final InputDecoration? inputDecoration;


  const TxtFieldWidget(
      {Key? key,
      this.obscuretxt = false,
      required this.hintTxt,
      this.IconLeft,
      this.IconRight,
        this.textEditingController,
      this.enabled = true,
      this.textInputType,
      this.onValidate,
      this.fillcolor,
      this.initialvalue, this.inputDecoration,this.onChange,this.autovalidateMode  })
      : super(key: key);

  @override
  _TxtFieldWidgetState createState() => _TxtFieldWidgetState();
}

class _TxtFieldWidgetState extends State<TxtFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SizedBox(

      child: TextFormField(
        enableInteractiveSelection: false,
        onChanged: widget.onChange,
        autovalidateMode:widget.autovalidateMode ,
        initialValue: widget.initialvalue,
        keyboardType: widget.textInputType,
        controller: widget.textEditingController,
        validator: widget.onValidate,
        enabled: widget.enabled,
        style: TextStyle(
            color: isDarkMode == false ? Colors.black : Colors.white),
        decoration: InputDecoration(
            isDense: true,
            fillColor: widget.fillcolor,
            focusedBorder:OutlineInputBorder(
              borderSide:  BorderSide(
                  color: isDarkMode == true
                  ? AppColors.colorpurpal
                  : AppColors.colorprimary, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: isDarkMode == true
              ? AppColors.appBgLight
                  : AppColors.colorprimary, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            hintText: widget.hintTxt,
            hintStyle: TextStyle(
                color: isDarkMode == true
                    ? Colors.white70
                    : AppColors.colorhalfgray),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
