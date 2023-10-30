import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../App Services/global_vars.dart';
import '../../AppWidgets/Effect_button.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_relocation_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_relocation_controller.dart';
import '../../constants/color_app.dart';
import '../../model/job_seeker_job_location_model.dart';
import '../../model/job_seeker_relocation_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../profile_screen/profile_add_prefer_job_location_screen.dart';
import 'applay_career_level_screen.dart';
import 'applay_gender_screen.dart';

class ApplayRelocationScreen extends StatefulWidget {
  int indecator;
  String ?image;

  ApplayRelocationScreen({Key? key, required this.indecator,this.image}) : super(key: key);

  @override
  State<ApplayRelocationScreen> createState() => _ApplayRelocationScreenState();
}

class _ApplayRelocationScreenState extends State<ApplayRelocationScreen> {
  @override
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

  void initState() {
    GlobalVarData.pereferredJobSeekerRelocationlist =
        GetRelocationController().getJobRelocation();
    getJobCardValues();
    super.initState();
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Are you Available to relocate for this job",
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
                padding: EdgeInsets.only(
                    top: 8, left: s.width * 0.04, right: s.width * 0.04),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Material(
                        elevation: 2,
                        color: isDarkMode == true
                            ? Color(0xff787777).withOpacity(0.2)
                            : ColorApp.colorwhite,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isDarkMode == true
                                  ? Color(0xff787777).withOpacity(0.2)
                                  : Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        child: FutureBuilder<JobSeekerRelocationModel>(
                            future:
                                GlobalVarData.pereferredJobSeekerRelocationlist,
                            builder: (BuildContext context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                    width: s.width,
                                    height: s.height * 0.16,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              } else {
                                bool _relaction =
                                    (snapshot.data?.checked ?? 'false') ==
                                            'false'
                                        ? false
                                        : true;
                                return Material(
                                  color: isDarkMode == true
                                      ? Color(0xff787777).withOpacity(0.2)
                                      : ColorApp.colorwhite,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: isDarkMode == true
                                            ? Color(0xff787777).withOpacity(0.2)
                                            : Colors.black54.withOpacity(0.3),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Column(
                                      children: [
                                        // FutureBuilder(
                                        //   builder: (context, snapshot) {
                                        //     return Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           bottom: 10),
                                        //       child: Column(
                                        //         children: [
                                        //           Row(
                                        //             mainAxisAlignment:
                                        //                 MainAxisAlignment.start,
                                        //             children: [
                                        //               Padding(
                                        //                 padding:
                                        //                     const EdgeInsets
                                        //                             .fromLTRB(
                                        //                         13, 10, 0, 5),
                                        //                 child: Text(
                                        //                   AppString.relocation,
                                        //                   style: TextStyle(
                                        //                       color: isDarkMode ==
                                        //                               true
                                        //                           ? ColorApp
                                        //                               .colorwhite
                                        //                           : ColorApp
                                        //                               .colorblackgalf,
                                        //                       fontWeight:
                                        //                           FontWeight
                                        //                               .w500,
                                        //                       fontSize: 15),
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //           Padding(
                                        //             padding: const EdgeInsets
                                        //                 .fromLTRB(0, 0, 0, 10),
                                        //             child: Consumer<
                                        //                 PostRelocationController>(
                                        //               builder: (context, val,
                                        //                   child) {
                                        //                 return Row(
                                        //                   mainAxisAlignment:
                                        //                       MainAxisAlignment
                                        //                           .spaceBetween,
                                        //                   children: [
                                        //                     Padding(
                                        //                       padding:
                                        //                           const EdgeInsets
                                        //                                   .only(
                                        //                               left: 10),
                                        //                       child:
                                        //                           _relaction ==
                                        //                                   false
                                        //                               ? Text(
                                        //                                   "I'm not willing to relocate",
                                        //                                   style: TextStyle(
                                        //                                       fontWeight: FontWeight.w500,
                                        //                                       fontSize: 14,
                                        //                                       color: isDarkMode == true ? ColorApp.colorwhite : ColorApp.colorblack.withOpacity(0.5)),
                                        //                                 )
                                        //                               : Text(
                                        //                                   "I'm willing to relocate",
                                        //                                   style: TextStyle(
                                        //                                       fontWeight: FontWeight.w500,
                                        //                                       fontSize: 14,
                                        //                                       color: isDarkMode == true ? ColorApp.colorwhite : ColorApp.colorblack.withOpacity(0.5)),
                                        //                                 ),
                                        //                     ),
                                        //                     Padding(
                                        //                       padding:
                                        //                           const EdgeInsets
                                        //                                   .only(
                                        //                               right:
                                        //                                   13),
                                        //                       child: val.loadingRelocation ==
                                        //                               false
                                        //                           ? FlutterSwitch(
                                        //                               height: s
                                        //                                       .height *
                                        //                                   0.035,
                                        //                               width: s.width *
                                        //                                   0.175,
                                        //                               inactiveColor:
                                        //                                   ColorApp
                                        //                                       .colorblackgalf,
                                        //                               activeColor:
                                        //                                   ColorApp
                                        //                                       .colorprimary,
                                        //                               value:
                                        //                                   _relaction,
                                        //                               onToggle:
                                        //                                   (value) {
                                        //                                 setState(
                                        //                                     () {
                                        //                                   val.jobSeekerRelocationAdd(
                                        //                                       value.toString(),
                                        //                                       context);
                                        //                                 });
                                        //
                                        //                                 Timer(
                                        //                                     Duration(seconds: 1),
                                        //                                     () => setState(() {
                                        //                                           GlobalVarData.pereferredJobSeekerRelocationlist = GetRelocationController().getJobRelocation();
                                        //                                         }));
                                        //                               },
                                        //                             )
                                        //                           : SizedBox(
                                        //                               height:
                                        //                                   25,
                                        //                               width: 25,
                                        //                               child:
                                        //                                   CircularProgressIndicator()),
                                        //                     ),
                                        //                   ],
                                        //                 );
                                        //               },
                                        //             ),
                                        //           )
                                        //         ],
                                        //       ),
                                        //     );
                                        //   }, future: null,
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: s.height * 0.04,
                          left: s.width * 0.005,
                          right: s.width * 0.005),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: SubmitButton(
                                border: Border.all(
                                    color: isDarkMode == true
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.black54.withOpacity(0.3)),
                                textColor: isDarkMode == true
                                    ? AppColors.colorwhite
                                    : AppColors.colorblack,
                                backGroundColor: isDarkMode == true
                                    ? Color(0xff343434)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                heightButton: s.height * 0.05,
                                widthButton: s.width * 0.30,
                                textButton: "Previous",
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Center(
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                color: ColorApp.colorprimary,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    splashColor:
                                        AppColors.colorindigo.withOpacity(0.8),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ApplayGenderScreen(
                                                    indecator:
                                                        widget.indecator + 1,
                                                    image: widget.image,
                                                  )));
                                    },
                                    child: Container(
                                        height: s.height * 0.05,
                                        width: s.width * 0.36,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Center(
                                            child: Text(
                                          "Next",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode == false
                                                  ? AppColors.colorwhite
                                                  : Colors.white),
                                        )))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
