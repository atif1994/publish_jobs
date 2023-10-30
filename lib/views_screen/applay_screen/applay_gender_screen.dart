import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../App Services/global_vars.dart';
import '../../AppWidgets/Effect_button.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobseeker_gender_controller.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/job_seeker_gender_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';

import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../profile_screen/profile_add_gender_screen.dart';
import 'applay_ready_to_work_screen.dart';

class ApplayGenderScreen extends StatefulWidget {
  int indecator;
  String? image;
   ApplayGenderScreen({Key? key,required this.indecator,this.image}) : super(key: key);

  @override
  State<ApplayGenderScreen> createState() => _ApplayGenderScreenState();
}

class _ApplayGenderScreenState extends State<ApplayGenderScreen> {
  String? jobName;
  String? companyName;
  String? cityName;
  String? salaryShow;
  String? postedTime;
  String? imageUrl;
  String? jobDescription;

  getJobCardValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      jobName = prefs.getString('jobName').toString();
      companyName = prefs.getString('companyName').toString();
      cityName = prefs.getString('cityName').toString();
      salaryShow = prefs.getString('salaryShow').toString();
      postedTime = prefs.getString('postedTime').toString();
      imageUrl = prefs.getString('imageUrl').toString();
      jobDescription = prefs.getString('jobDescription').toString();
    });
  }
  callPersonalInfoAfterUpdation() {
    if (GlobalVarData.genderStatus == 'not null') {
      GlobalVarData.genderListFuture =
          GetJobSeekerGenderController().getJobSeekerGender();

      GlobalVarData.genderStatus = 'null';
    }
  }
  callSalaryUpdation() {
    if (GlobalVarData.salaryStatus== 'not null') {
      GlobalVarData.genderListFuture =
          GetJobSeekerGenderController().getJobSeekerGender();

      GlobalVarData.salaryStatus = 'null';
    }
  }
  @override
  void initState() {

    GlobalVarData.genderListFuture =
        GetJobSeekerGenderController().getJobSeekerGender();

    // _future = abd.jobSeekerEducation();

    getJobCardValues();
    super.initState();
    print('init value is printed');
  }
  @override
  Widget build(BuildContext context) {
    callPersonalInfoAfterUpdation();
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:isDarkMode == true
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
      backgroundColor:
      isDarkMode == true ? Color(0xff343434) : Colors.white,

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
                      "Gender Information",
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
                padding: EdgeInsets.only(top: 8, left: s.width * 0.04, right: s.width * 0.04 ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Column(
                        children: [
                          Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            color: isDarkMode == false
                                ? Colors.white
                                : ColorApp.colorblackgalf.withOpacity(0.2),
                            elevation: 1,
                            child: FutureBuilder<JobSeekerGenderModel>(
                              future: GlobalVarData.genderListFuture,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Shimmer.fromColors(
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
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
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
                                                        .fromLTRB(
                                                        8, 10, 5, 5),
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
                                                        .fromLTRB(
                                                        8, 5, 5, 10),
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
                                    ),
                                  );
                                } else if (snapshot.data?.title.toString() ==
                                    'null') {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 14, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppString.gender,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                  : ColorApp.colorblackgalf,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 0, bottom: 0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddGender()));
                                            },
                                            child: Material(
                                              color: isDarkMode == false
                                                  ? ColorApp.colorgray
                                                  : ColorApp.colorblackgalf
                                                  .withOpacity(0.2),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: isDarkMode == false
                                                      ? ColorApp.colorgray
                                                      : ColorApp
                                                      .colorblackgalf
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                ),
                                                height: 25,
                                                width: 33,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp.colorblack,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 0, 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3),
                                              child: Text(
                                                AppString.gender,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                        .colorblackgalf,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: s.width * 0.04),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddGender()));
                                                },
                                                child: Material(
                                                  color: isDarkMode == false
                                                      ? ColorApp.colorgray
                                                      : ColorApp
                                                      .colorblackgalf
                                                      .withOpacity(0.2),
                                                  elevation: 0,
                                                  shape:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: isDarkMode ==
                                                          false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                          .colorblackgalf
                                                          .withOpacity(
                                                          0.2),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(5),
                                                    ),
                                                    height: 25,
                                                    width: 33,
                                                    child: Center(
                                                      child: Image.asset(
                                                          width: 17,
                                                          height: 16,
                                                          ImangeAssests
                                                              .eImage,
                                                          color: isDarkMode ==
                                                              true
                                                              ? Colors.white
                                                              : ColorApp
                                                              .colorblack,
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding:
                                            const EdgeInsets.only(top: 1),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(right: 5),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: ColorApp
                                                                .colorprimary,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                4)),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(2),
                                                          child: Container(
                                                            width: s.width *
                                                                0.10,
                                                            height: 30,
                                                            decoration:
                                                            BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  3),
                                                              color: Colors
                                                                  .white,
                                                              border: Border.all(
                                                                  color: ColorApp
                                                                      .colorprimary),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsets
                                                                  .all(2),
                                                              child: Material(
                                                                color: ColorApp
                                                                    .colorprimary,
                                                                elevation: 1,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        2)),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .person_outline,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(left: 10),
                                                      child: Text(
                                                        snapshot.data!.title
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 14,
                                                          color: isDarkMode ==
                                                              true
                                                              ? Colors.white
                                                              : ColorApp
                                                              .colornewblack,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: s.height*0.04),
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
                                backGroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
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
                                                  ApplayReadyToWorkScreen(indecator: widget.indecator  + 1, image: widget.image,)));
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
