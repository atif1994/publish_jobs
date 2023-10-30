import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AppWidgets/Effect_button.dart';
import '../../Network Controller/Applay Controller/post_applay.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_resume_controller.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/get_resume_model.dart';
import '../../utils/app_color.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import 'applay_application_sent.dart';

class ApplayResume extends StatefulWidget {
  int indecator;
  String? image;

  ApplayResume({Key? key, required this.indecator,this.image}) : super(key: key);

  @override
  State<ApplayResume> createState() => _ApplayResumeState();
}

class _ApplayResumeState extends State<ApplayResume> {
  String? jobName;
  String? companyName;
  String? cityName;
  String? salaryShow;
  String? postedTime;
  String? imageUrl;
  String? jobDescription;
  String ?Job_id;

  getJobCardValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      jobName = prefs.getString('jobName').toString();
      Job_id = prefs.getString('jobId').toString();
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
  String _groupValue = '';
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
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Container(
              color: isDarkMode == true ? Color(0xff343434) : Colors.white,
              width: s.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Container(
                        width: s.width * 0.07,
                        child: Image.asset('images/appLogo.png')),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: Container(
                              decoration: BoxDecoration(
                                color: isDarkMode == false
                                    ? Colors.white
                                    : ColorApp.colorblackgalf.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: s.width * 0.095,
                              height: s.height * 0.043,
                              child: Icon(
                                color: Colors.grey,
                                size: 18,
                                Icons.notification_add_outlined,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Container(
                              width: s.width * 0.095,
                              height: s.height * 0.048,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 1, color: Colors.white)),
                              child: CircleAvatar(
                                radius: 23,
                                backgroundImage: widget.image
                                    .toString() !=
                                    'null'
                                    ? NetworkImage(
                                    'https://api.publish.jobs/pjcloud/userAccountImage/' +
                                        widget.image!)
                                    : NetworkImage(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                                child: Text(""),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
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
                        "Skip & processed application ",
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(

                  width: s.width*0.9,
                  child: DottedBorder(
                    dashPattern: [7, 7, 7, 7],
                    color:ColorApp.colorprimary ,

                    child: Center(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                            child: Center(
                              child: Container(
                                height: s.height * 0.13,
                                width: s.width ,
                                child:isDarkMode==true? Image.asset(
                                  ImangeAssests.resumeimg,
                                ):Image.asset(
                                  ImangeAssests.resumeimglight,
                                ),
                              ),
                            ),
                          ),
                          Text("Drag and drop resume to upload",style: TextStyle(
                              color: isDarkMode == false
                                  ? ColorApp.colorblackgalf.withOpacity(0.7)
                                  :  ColorApp.colorbackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                          Text("or",style: TextStyle(
                              color: isDarkMode == false
                                  ? ColorApp.colorblackgalf.withOpacity(0.7)
                                  : ColorApp.colorbackground,
                              fontWeight: FontWeight.w500,
                              fontSize: 15)),
                          SizedBox(height: 12,),
                          Container(
                            height: s.height*0.05,
                            width: s.width*0.830,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                                color: ColorApp.colorprimary.withOpacity(0.2)
                            ),
                            child: Center(
                              child: Text(" +   Upload Now ",style: TextStyle(
                                color: ColorApp.colorprimary,
                                fontWeight: FontWeight.w500
                              ),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10,top: 8),
                            child: Text("supported files are ,pdf,Doc",style: TextStyle(
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf.withOpacity(0.7)
                                    : ColorApp.colorbackground,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: s.height*0.04,bottom: s.height*0.035),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Consumer<PostJobApplayController>(
                        builder: (context, val, child) {
                          return Padding(
                            padding:
                            EdgeInsets.only(top: 7, left: s.width * 0.04),
                            child: Center(
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                color: ColorApp.colorprimary,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    splashColor:
                                    AppColors.colorindigo.withOpacity(0.8),
                                    onTap: () {
                                      val.ApplayPost(Job_id.toString(), context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ApplicationSent(
                                                indecator: widget.indecator + 1,
                                              )));
                                    },
                                    child: Container(
                                        height: s.height * 0.05,
                                        width: s.width * 0.39,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(3)),
                                        child: Center(
                                          child: val.ApplayLoading ==
                                              false
                                              ? Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: isDarkMode == false
                                                    ? AppColors.colorwhite
                                                    : Colors.white),
                                          )
                                              : SizedBox(
                                            height: 25,
                                            width: 25,
                                            child:
                                            CircularProgressIndicator(
                                              strokeWidth: 3,
                                            ),
                                          ),
                                        ))),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 14),
                    //   child: Center(
                    //     child: Material(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(6)),
                    //       color: ColorApp.colorprimary,
                    //       child: InkWell(
                    //           borderRadius: BorderRadius.circular(6),
                    //           splashColor:
                    //           AppColors.colorindigo.withOpacity(0.8),
                    //           onTap: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         ApplicationSent(indecator: widget.indecator  + 1,)));
                    //
                    //           },
                    //           child: Container(
                    //               height: s.height * 0.05,
                    //               width: s.width * 0.36,
                    //               decoration: BoxDecoration(
                    //                   borderRadius:
                    //                   BorderRadius.circular(3)),
                    //               child: Center(
                    //                   child: Text(
                    //                     "Submit",
                    //                     style: TextStyle(
                    //                         fontSize: 16,
                    //                         fontWeight: FontWeight.bold,
                    //                         color: isDarkMode == false
                    //                             ? AppColors.colorwhite
                    //                             : Colors.white),
                    //                   )))),
                    //     ),
                    //   ),
                    // )
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
