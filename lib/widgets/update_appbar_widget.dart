import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_app.dart';
import '../utils/app_color.dart';

class UpdateAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? appBarText;
  dynamic? image;
  final GestureTapCallback ?onPressed;


  UpdateAppBar(
      {Key? key,
        this.appBarText,
        this.image,
        this.onPressed
       })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
        child: Container(

          color: isDarkMode == false
              ? ColorApp.colorblackgalf
              : ColorApp.colorblackgalf,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25,),
                child: Text(appBarText.toString(),style: TextStyle(
                    color: isDarkMode == false
                        ? ColorApp.colorwhite
                        : ColorApp.colorwhite,
                  fontSize: 19,
                  fontWeight: FontWeight.w500
                ),),
              ),
              GestureDetector(
                onTap:onPressed ,
                child: Padding(
                  padding: EdgeInsets.only(right: s.width*0.05),
                  child: Center(
                    child:Image.asset(image!=image?"":image,
                        color: isDarkMode == false
                            ? ColorApp.colorwhite
                            : ColorApp.colorwhite,
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Size get preferredSize {

    return Size.fromHeight(60);
  }
}
