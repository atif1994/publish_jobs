import 'package:flutter/cupertino.dart';

import '../constants/color_app.dart';

class AddAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? appBarText;



  AddAppBar(
      {Key? key,
        this.appBarText,

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
        child: Padding(
          padding: const EdgeInsets.only(top: 15,bottom: 15),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 25,top: 0),
              child: Text(appBarText.toString(),style: TextStyle(
                  color: isDarkMode == false
                      ? ColorApp.colorwhite
                      : ColorApp.colorwhite,
                  fontSize: 19,
                  fontWeight: FontWeight.w500
              ),),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {

    return Size.fromHeight(90);
  }
}