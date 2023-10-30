import 'dart:async';
import 'package:firstapp/views_screen/splash_screen/company_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import '../../constants/color_app.dart';
import '../../utils/app_color.dart';

import '../Login_screen/login_screen.dart';

class WelComeScreen extends StatefulWidget {
  const WelComeScreen({Key? key}) : super(key: key);

  @override
  State<WelComeScreen> createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  bool colorButton = true;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode == true ? ColorApp.colorblack : Colors.white,
        body: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDarkMode == true ?  Container(
                        height: s.height * 0.159,
                        width: s.width * 0.40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100)),
                          color:ColorApp.colorblack,
                        ),
                        child:Text("")
                      ): Container(
                          height: s.height * 0.159,
                          width: s.width * 0.40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(100)),
                            color:ColorApp.colorgray,
                          ),
                          child:Text("")
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (Context)=>LogInScreen(checkNav: 'wellcome',)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 45),
                          child: Container(
                            height: s.height * 0.1,
                            width: s.width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(130)),
                              color: ColorApp.colorprimary,
                            ),
                            child: Center(
                              child: Text(
                                "Skip",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Container(
                              width: s.width * 0.30,
                              child: Image.asset("images/abc.png")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Welcome to",
                            style: TextStyle(
                              color: isDarkMode == true
                                  ? AppColors.colorwhite
                                  : ColorApp.colorblack,
                              fontSize: 26,
                              fontWeight:FontWeight.w500,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Publish Jobs",
                            style: TextStyle(
                                color: Color(0xff8477FA),
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                "Find Great ",
                                style: TextStyle(
                                    color: isDarkMode == true
                                        ? AppColors.colorwhite
                                        : ColorApp.colorblackgalf,
                                    fontWeight:FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    fontSize: 17),
                              ),
                              Text(
                                " Place ",
                                style: TextStyle(
                                    color: Color(0xff8477FA),
                                    fontSize: 17,
                                  fontWeight:FontWeight.w500,
                                  fontFamily: "Montserrat",),
                              ),
                              Text(
                                "to Work",
                                style: TextStyle(
                                    color: isDarkMode == true
                                        ? AppColors.colorwhite
                                        : ColorApp.colorblackgalf,
                                    fontSize: 17,
                                  fontWeight:FontWeight.w500,
                                  fontFamily: "Montserrat",),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.colorprimary,
                              borderRadius: BorderRadius.circular(18)),
                          height: s.height * 0.045,
                          width: s.width * 0.49,
                          child: SliderButton(
                              buttonColor: AppColors.colorprimary,
                              backgroundColor: AppColors.colorindigo,
                              action: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => SplashScreen4()),
                                    (Route<dynamic> route) => false);
                              },
                              label: Text(
                                "Get Started",
                                style: TextStyle(
                                    color: AppColors.colorwhite,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                              icon: Icon(
                                  color: Colors.white,
                                  Icons.arrow_forward_ios_rounded)),
                        ),

                      ],
                    ),
                  ],
                ),
              ],
            )),
            Expanded(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: s.height * 0.1,
                        width: s.height * 0.084,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(80)),
                          color: ColorApp.colorprimary,
                        ),
                        child: Center(
                          child: Text(""),
                        ),
                      ),
                    ],
                  ),
                  Container(

                      width: s.width * 0.798,
                      child: Image.asset("images/boy.png")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
