import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';

class ApplicationSent extends StatefulWidget {
  int indecator;
  ApplicationSent({Key? key,required this.indecator}) : super(key: key);

  @override
  State<ApplicationSent> createState() => _ApplicationSentState();
}

class _ApplicationSentState extends State<ApplicationSent> {
  String? jobName;
  String? companyName;
  String? cityName;
  String? salaryShow;
  String? postedTime;
  String? imageUrl;
  String? jobDescription;
  String? profileImage;

  getJobCardValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      profileImage = prefs.getString('profileImage').toString();
      jobName = prefs.getString('jobName').toString();
      companyName = prefs.getString('companyName').toString();
      cityName = prefs.getString('cityName').toString();
      salaryShow = prefs.getString('salaryShow').toString();
      postedTime = prefs.getString('postedTime').toString();
      imageUrl = prefs.getString('imageUrl').toString();
      jobDescription = prefs.getString('jobDescription').toString();
    });
  }

  @override
  void initState() {
    getJobCardValues();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode == true
            ? ColorApp.colornewblack
            : ColorApp.colorbackground ,
        actions: [
          AppBarShow(),
        ],
      ),
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child:Column(
            children: [

              SizedBox(
                height: s.height * 0.013,
              ),
            AppCardWidget(),
              Padding(
                padding:
                EdgeInsets.only(left: s.width * 0.06, top: 20, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.indecator.toString() + "/" + "10",
                      style: TextStyle(
                          color: isDarkMode == false
                              ? ColorApp.colorblackgalf.withOpacity(0.7)
                              : ColorApp.colorwhite.withOpacity(0.68)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: s.width * 0.05),
                      child: Text(
                        "Skip & processed application",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: ColorApp.colorprimary),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: LinearPercentIndicator(
                  //leaner progress bar
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 6.0,
                  percent: widget.indecator / 10,

                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: AppColors.colorprimary,
                  backgroundColor: isDarkMode == true
                      ? ColorApp.colorwhite
                      : ColorApp.colorblackgalf.withOpacity(0.5),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(bottom: 10, top: 10, left: s.width * 0.049),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose / update Resume",
                      style: TextStyle(
                          color: isDarkMode == false
                              ? ColorApp.colorblackgalf.withOpacity(0.7)
                              : ColorApp.colorwhite.withOpacity(0.68),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.fromLTRB(s.width*0.08, 2, 0, 0),
                    child: Container(

                      child:isDarkMode==true? Image.asset(
                        ImangeAssests.starimgdark,
                      ):Image.asset(
                        ImangeAssests.starimgdark,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(s.width*0.2, 0, s.width*0.7, 0),
                    child: Container(

                      child:isDarkMode==true? Image.asset(
                        ImangeAssests.starimg,
                      ):Image.asset(
                        ImangeAssests.starimg,
                      ),
                    ),
                  ),

                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Application sent !",style: TextStyle(
                    color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblack
                        ,
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),),
                  SizedBox(height: s.height*0.02,),

                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Your Application for the position',style: TextStyle(
                            color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf
                            ,
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                        )),
                        TextSpan(
                          text:" "+ '"$jobName"',
                          style: TextStyle( color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf
                              ,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),

                      ],
                    ),
                  ),
                  Text("has been sent to the employeer",style: TextStyle(
                      color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf
                      ,
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                  ),),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: s.height*0.04,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Center(
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        color: ColorApp.colorprimary,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            splashColor:
                            AppColors.colorindigo.withOpacity(0.8),
                            onTap: () {
                              Navigator.of(context ,rootNavigator: true).push(MaterialPageRoute(builder: (context) => Bar(id: 0,)));
                          

                            },
                            child: Container(
                                height: s.height * 0.06,
                                width: s.width*0.9 ,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(3)),
                                child: Center(
                                    child: Text(
                                      "Back to job search",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isDarkMode == false
                                              ? AppColors.colorwhite
                                              : Colors.white),
                                    )))),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
