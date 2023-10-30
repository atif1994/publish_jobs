import 'dart:async';
import 'package:firstapp/component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import 'package:firstapp/views_screen/Login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../home_screen/Jobs_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // final controller = PageController();
  bool isLastPage = false;
  int _currentPage = 0;
  late Timer _timer;
  PageController controller = PageController(
    initialPage: 0,
  );
  bool lastPage = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 1) {
        lastPage = true;
        _currentPage++;
      } else {
        _currentPage = 2;
        lastPage = false;
      }

      if (controller.hasClients) {
        controller.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          isDarkMode == true ? ColorApp.colornewblack : Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 80),
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            controller: controller,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: s.height * 0.07,
                  ),
                  Container(
                    height: s.height * 0.10,
                    width: s.width * 0.28,
                    decoration: BoxDecoration(),
                    child: isDarkMode == true
                        ? Image.asset(
                      ImangeAssests.pic1ImageOnBoarding,
                    )
                        : Image.asset(
                      ImangeAssests.pic1ImageOnBoarding,
                    ),
                  ),
                  Text(
                    "Publish Jobs",
                    style: TextStyle(
                        color: ColorApp.colorprimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),

                  SizedBox(
                    height: s.height * 0.05,
                  ),
                  Container(
                    // height: s.height * 0.10,
                    // width: s.width*0.28,
                    decoration: BoxDecoration(),
                    child: isDarkMode == true
                        ? Image.asset(
                            ImangeAssests.picSplash1,
                          )
                        : Image.asset(
                            ImangeAssests.picSplash1,
                          ),
                  ),
                  SizedBox(
                    height: s.height * 0.03,
                  ),
                  Text(
                    "Welcome to Publish Jobs",
                    style: TextStyle(
                        color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblack,
                        fontWeight: FontWeight.w600, fontSize: 21),
                  ),
                  SizedBox(
                    height: s.height * 0.015,
                  ),
                  Text(
                    "Get ready to embark on an exciting",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblackgalf),
                  ),
                  Text(
                    "journey towards finding your",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblackgalf),
                  ),
                  Text(
                    "dream job",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblackgalf),
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: s.height * 0.07,
                  ),
                  Container(
                    height: s.height * 0.10,
                    width: s.width * 0.28,
                    decoration: BoxDecoration(),
                    child: isDarkMode == true
                        ? Image.asset(
                      ImangeAssests.pic1ImageOnBoarding,
                    )
                        : Image.asset(
                      ImangeAssests.pic1ImageOnBoarding,
                    ),
                  ),
                  Text(
                    "Publish Jobs",
                    style: TextStyle(
                        color: ColorApp.colorprimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                    ],
                  ),
                  SizedBox(
                    height: s.height * 0.05,
                  ),
                  Container(
                    // height: s.height * 0.10,
                    // width: s.width*0.28,
                    decoration: BoxDecoration(),
                    child: isDarkMode == true
                        ? Image.asset(
                            ImangeAssests.picdark1ImageOnBoarding,
                          )
                        : Image.asset(
                            ImangeAssests.picdark1ImageOnBoarding,
                          ),
                  ),
                  SizedBox(
                    height: s.height * 0.03,
                  ),
                  Column(
                    children: [
                      Text(
                        "Find The One That’s Right",
                        style: TextStyle(
                            color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblack,
                            fontWeight: FontWeight.w600, fontSize: 21),
                      ),
                      Text(
                        "For You",
                        style: TextStyle(
                            color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblack,
                            fontWeight: FontWeight.w600, fontSize: 21),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: s.height * 0.015,
                  ),
                  Text(
                    "Find top most companies and get",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblackgalf),
                  ),
                  Text(
                    "a chance to work with",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblackgalf),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: s.height * 0.07,
                  ),
                  Container(
                    height: s.height * 0.10,
                    width: s.width * 0.28,
                    decoration: BoxDecoration(),
                    child: isDarkMode == true
                        ? Image.asset(
                      ImangeAssests.pic1ImageOnBoarding,
                    )
                        : Image.asset(
                      ImangeAssests.pic1ImageOnBoarding,
                    ),
                  ),
                  Text(
                    "Publish Jobs",
                    style: TextStyle(
                        color: ColorApp.colorprimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),

                  SizedBox(
                    height: s.height * 0.05,
                  ),
                  Container(
                    // height: s.height * 0.10,
                    // width: s.width*0.28,
                    decoration: BoxDecoration(),
                    child: isDarkMode == true
                        ? Image.asset(
                            ImangeAssests.picSplash3,
                          )
                        : Image.asset(
                            ImangeAssests.picSplash3,
                          ),
                  ),
                  SizedBox(
                    height: s.height * 0.03,
                  ),
                  Text(
                    "Get Professional Resume",
                    style: TextStyle(color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblack,
                        fontWeight: FontWeight.w600, fontSize: 21),
                  ),
                  SizedBox(
                    height: s.height * 0.04,
                  ),
                  Text(
                    "Create your profile and get",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblackgalf),
                  ),
                  Text(
                    "Professional resume Free",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblackgalf),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: isLastPage
          ? InkWell(
              onTap: () async {
                // final pref = await SharedPreferences.getInstance();
                //     pref.setBool('show home', true);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Bar(id: 0,)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: isDarkMode == true ? ColorApp.colornewblack : Colors.white,
                  borderRadius: BorderRadius.circular(0)
                ),

                child: Padding(
                  padding: EdgeInsets.only(
                      left: s.width * 0.036, right: s.width * 0.036,bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorApp.colorprimary,
                      borderRadius: BorderRadius.circular(5)
                    ),

                      height:30,
                      width: s.width,
                      child: Center(
                          child: Text(
                        "Lets Start",
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              ))
          : Container(
              color:isDarkMode == true ? ColorApp.colornewblack : Colors.white,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.jumpToPage(3);
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color:isDarkMode==true?ColorApp.colorwhite: ColorApp.colorblackgalf,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )),
                    Center(
                      child: SmoothPageIndicator(

                        onDotClicked: (index) {
                          controller.animateToPage(index,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeInOut);
                        },
                        count: 3,
                        controller: controller,
                        effect: WormEffect(
                          radius: 12,
                          dotHeight: s.height*0.017,
                            dotColor: ColorApp.colorblackgalf,
                            activeDotColor: ColorApp.colorprimary),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: s.width * 0.05),
                      child: InkWell(
                        onTap: () {
                          controller.nextPage(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeInOut);
                        },
                        child: Container(
                          height: s.height*0.04,
                          width: s.width*0.3,
                          decoration: BoxDecoration(
                              color: ColorApp.colorprimary,
                            borderRadius: BorderRadius.circular(6)
                          ),

                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Next",style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
