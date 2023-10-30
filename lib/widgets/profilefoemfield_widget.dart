import 'package:firstapp/constants/color_app.dart';
import 'package:firstapp/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileFormField extends StatelessWidget {
  final IconData? icon;

  final String? textName;
  final String? initialName;
  final String? hintText;
  final String? mustText;
  final dynamic? controller;
  final int? line;
  final image;

  final ImageIcon? imageIcon;

  final ValueChanged<String>? onChanged;
  final bool? disable;
  dynamic? keyBordType;

  final String? Function(String?)? onValidate;

  ProfileFormField(
      {Key? key,
      this.icon,

      this.textName,
      this.initialName,
      this.onChanged,
      this.disable,
      this.keyBordType,
      this.onValidate,
      this.hintText,
      this.controller,
      this.mustText,
      this.image,
      this.imageIcon,
      this.line})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        top: 10,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6, bottom: 5),
            child: Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  child: Image.asset("$image",
                      color: isDarkMode == true
                          ? ColorApp.colorwhite
                          : Colors.black,
                      fit: BoxFit.fill),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      textName!,
                      style: TextStyle(
                          color: isDarkMode == false
                              ? ColorApp.colorblackgalf.withOpacity(0.7)
                              : ColorApp.colorwhite.withOpacity(0.68),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Text(
                  mustText!,
                  style: TextStyle(
                      color: isDarkMode == false
                          ? ColorApp.colorblackgalf
                          : ColorApp.colorwhite.withOpacity(0.7),
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(
            height: 3,
          ),
          TextFormField(
              style: TextStyle(
                color: isDarkMode == true
                    ? Colors.white
                    : Colors.black.withOpacity(0.71),
              ),
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLines: line,
              validator: onValidate,
              keyboardType: keyBordType,
              onChanged: onChanged,
              enabled: disable,
              initialValue: initialName,
              decoration: InputDecoration(

                focusedBorder:
                OutlineInputBorder(
                  borderSide:
                  BorderSide(

                      color:ColorApp.colorprimary
                  ),

                ),
                filled: true,
                fillColor:
                    isDarkMode == true ? Color(0xff343434) : Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkMode == true
                            ? Colors.white.withOpacity(0.3)
                            : Colors.black54.withOpacity(0.3))),
                hintText: hintText,
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: isDarkMode == true
                        ? AppColors.colorwhite.withOpacity(0.69)
                        : Colors.grey,
                    fontWeight: FontWeight.w300),
                contentPadding: EdgeInsets.only(
                    left: 10.0, top: 13.0, bottom: 13.0, right: 10),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ))
        ],
      ),
    );
  }
}
