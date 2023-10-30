import 'package:firstapp/utils/app_color.dart';
import 'package:firstapp/utils/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:slider_button/slider_button.dart';

import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../Login_screen/login_screen.dart';
import '../home_screen/Jobs_screen.dart';



class SplashScreen5 extends StatefulWidget {
  const SplashScreen5({Key? key}) : super(key: key);

  @override
  State<SplashScreen5> createState() => _SplashScreen5State();
}

class _SplashScreen5State extends State<SplashScreen5> {
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
                          Navigator.push(context, MaterialPageRoute(builder: (Context)=>LogInScreen(checkNav: 'splash',)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 45),
                          child: Container(
                            height: s.height * 0.1,
                            width: s.width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(100)),
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
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Create your Account",
                            style: TextStyle( color: isDarkMode == true ? AppColors.colorwhite : AppColors.colorblack,
                                fontSize: 29,  fontWeight:FontWeight.w500,
                              fontFamily: "Montserrat",),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "create your account free and find ",
                            style: TextStyle(fontSize: 17, color: isDarkMode == true ? AppColors.colorwhite : AppColors.colorblack, fontWeight:FontWeight.w400,
                              fontFamily: "Montserrat",),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Text(
                            "your dream job ",
                            style: TextStyle(fontSize: 17, color: isDarkMode == true ? AppColors.colorwhite : AppColors.colorblack, fontWeight:FontWeight.w400,
                              fontFamily: "Montserrat",),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.colorprimary,
                                borderRadius: BorderRadius.circular(18)),
                            height: s.height * 0.045,
                            width: s.width * 0.49,
                            child: SliderButton(
                                buttonColor: AppColors.colorprimary,
                                backgroundColor: AppColors.colorindigo,
                                action: () {
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      Bar(id: 0,)), (Route<dynamic> route) => false);
                                },
                                label: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: AppColors.colorwhite,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                                icon: Icon(
                                    color: Colors.white,
                                    Icons.arrow_forward_ios_rounded)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child:isDarkMode==true?

                          Container(
                              height: s.height * 0.39,
                              width: s.width*0.9,
                              child: Image.asset(ImangeAssests.createImage)): Container(
                              height: s.height * 0.40,
                              width: s.width*0.90,
                              child: Image.asset(ImangeAssests.createImage)),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            )),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: s.height * 0.065,
                      width: s.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(130)),
                        color: ColorApp.colorprimary,
                      ),
                      child: Center(

                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
