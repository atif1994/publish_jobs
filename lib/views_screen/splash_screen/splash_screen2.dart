import 'dart:async';

import 'package:firstapp/views_screen/splash_screen/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';
import '../home_screen/Jobs_screen.dart';
import '../on boarding/on_boarding_screen.dart';



class SplashScreen2 extends StatefulWidget {
SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  checkIfOnBoardingSaved()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('onBoardingSaved')!='yes'){
      Get.offAll(OnBoardingScreen());
    }
    else{
      Get.offAll(Bar(id: 0,));
    }
  }
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      checkIfOnBoardingSaved();

    });
  }
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
      isDarkMode == true ?ColorApp.colorprimary: ColorApp.colorprimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(ImangeAssests.splashImage2, width: 150),
          ),

        ],
      ),
    );
  }
}

