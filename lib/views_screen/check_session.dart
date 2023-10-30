
import 'package:flutter/material.dart';

import '../App Services/api_services_provider.dart';
import '../api/api.dart';
import '../constants/color_app.dart';
import '../constants/image_assets.dart';
import '../utils/app_color.dart';
import '../widgets/buttonSubmit_widget.dart';
import 'Login_screen/login_screen.dart';
class CheckSession extends StatefulWidget {
  const CheckSession({Key? key}) : super(key: key);

  @override
  State<CheckSession> createState() => _CheckSessionState();
}

class _CheckSessionState extends State<CheckSession> {
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    DataServices dataServices = DataServices();
    ABD abd = ABD();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode == true
          ? ColorApp.colorblack
          : ColorApp.colorbackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode == true
            ? ColorApp.colorblack
            : ColorApp.colorbackground,
        elevation: 0,
        actions: [
          Container(

            width: s.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.asset(
                    fit: BoxFit.contain,
                    "images/abc.png",
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Container(
                            decoration: BoxDecoration(
                              color: ColorApp.colorwhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: s.width * 0.099,
                            height: s.height * 0.044,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: Icon(
                                color: Colors.grey,
                                size: 18,
                                Icons.notification_add_outlined,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 7),
                      child: Container(
                        child: Image.asset(
                          fit: BoxFit.contain,
                          height: 80,
                          ImangeAssests.personImage,
                          width: s.width * 0.099,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: s.height*0.029,),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(

              height: s.height*0.4,
              width: s.width,
              child: Image.asset(ImangeAssests.pic2ImageOnBoarding,fit: BoxFit.fill),
            ),
          ),
          SizedBox(height: s.height*0.019,),
          Text("A Little Atemp Here",style: TextStyle(

            color: isDarkMode == true
                ? AppColors.colorwhite
                : AppColors.colorblack,

            fontWeight: FontWeight.w600,
            fontFamily: "Montserrat",
          ),),
          SizedBox(height: s.height*0.019,),
          Text("Please Login to see Profile",style:TextStyle(

            color: isDarkMode == true
                ? AppColors.colorwhite
                : AppColors.colorblack,

            fontWeight: FontWeight.w500,
            fontFamily: "Montserrat",
          ), ),
          SizedBox(height: s.height*0.019,),
          SubmitButton(
            textColor:
            isDarkMode == true ? AppColors.colorwhite :AppColors.colorwhite,
            backGroundColor: ColorApp.colorprimary,

            borderRadius: BorderRadius.circular(22),
            widthButton: s.width*0.499,
            heightButton: s.height*0.054,
            textButton: 'Login Now', onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (
                        context) =>
                        LogInScreen(checkNav: 'check',)));
          },)
        ],
      ),
    );
  }
}
