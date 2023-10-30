import 'package:firstapp/utils/app_color.dart';
import 'package:firstapp/utils/app_string.dart';
import 'package:firstapp/views_screen/splash_screen/create_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/color_app.dart';
import '../Login_screen/login_screen.dart';

class SplashScreen4 extends StatefulWidget {
  const SplashScreen4({Key? key}) : super(key: key);

  @override
  State<SplashScreen4> createState() => _SplashScreen4State();
}

class _SplashScreen4State extends State<SplashScreen4> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isDarkMode == true ? ColorApp.colorblack : Colors.white,
        body: Column(
          children: [
            Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDarkMode == true
                          ? Container(
                              height: s.height * 0.159,
                              width: s.width * 0.40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(100)),
                                color: ColorApp.colorblack,
                              ),
                              child: Text(""))
                          : Container(
                              height: s.height * 0.159,
                              width: s.width * 0.40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(100)),
                                color: ColorApp.colorgray,
                              ),
                              child: Text("")),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (Context) => LogInScreen(checkNav: 'company',)));
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
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            "Find Top Companies",
                            style: TextStyle(
                              color: isDarkMode == true
                                  ? AppColors.colorwhite
                                  : AppColors.colorblack,
                              fontSize: 29,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            "find top most comapnies and get a ",
                            style: TextStyle(
                              fontSize: 17,
                              color: isDarkMode == true
                                  ? ColorApp.colorwhite
                                  : ColorApp.colorblackgalf,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            "chance to work ",
                            style: TextStyle(
                              fontSize: 17,
                              color: isDarkMode == true
                                  ? ColorApp.colorwhite
                                  : ColorApp.colorblackgalf,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen5()),
                                (Route<dynamic> route) => false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              height: s.height * 0.043,
                              width: s.width * 0.3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Explore",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.deepPurple,
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.colorindigo,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                              height: s.height * 0.30,
                              child: Image.asset("images/ch.png")),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: s.height * 0.1,
                      width: s.height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(130)),
                        color: AppColors.colorindigo,
                      ),
                      child: Center(
                        child: Text(""),
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
