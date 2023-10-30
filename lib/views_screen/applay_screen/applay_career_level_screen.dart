import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../App Services/global_vars.dart';
import '../../AppWidgets/Effect_button.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobSeekercareer_apply_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobseeker_career_level_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_delete_AlertApi_profilebase_controller.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/GetjobSeekerCareerLevelModel.dart';
import '../../model/job_seeker_career_level_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/Loading_data.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../profile_screen/profile_add_career_level_screen.dart';
import 'applay_gender_screen.dart';
import 'applay_relocation_screen.dart';

class ApplayCareerLavelScreen extends StatefulWidget {
  int indecator;
  String? image;

  ApplayCareerLavelScreen({Key? key, required this.indecator, this.image})
      : super(key: key);

  @override
  State<ApplayCareerLavelScreen> createState() =>
      _ApplayCareerLavelScreenState();
}

class _ApplayCareerLavelScreenState extends State<ApplayCareerLavelScreen> {
  @override
  bool deleteCareelLevel = true;
  bool jobCareerLevel = false;
  bool isAppbar = true;
  bool careerlevel = true;
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

  bool careerlevelclosed = false;
  Future<JobCareerLavelModel>? pereferredJobCareerLevel;

  @override
  void initState() {

    super.initState();
    Timer(Duration(milliseconds: 00), () {
      GlobalVarData.pereferredJobCareerLevel =
          GetJobSeekerCareerLevelController().getJobSeekerCareerLevel();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetJobSeekerCareerLevelController>(context, listen: false)
          .getJobSeekerCareerLevel();
      Provider.of<GetJobSeekerCareerLevelController>(context, listen: false)
          .getJobSeekerCareerLevel();
    });

    Provider.of<GetJobSeekerCareerLevelController>(context, listen: false)
        .getJobSeekerCareerLevel();

    Provider.of<GetJobSeekerCareerLevelController>(context, listen: false)
        .getJobSeekerCareerLevel();
    getJobCardValues();
    print('init value is printed');
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
            : ColorApp.colorbackground,
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
                                backgroundImage: widget.image.toString() !=
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
                      "Careel Level Information",
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
                      child: Column(
                        children: [
                          Material(
                            elevation: 1,
                            color: isDarkMode == false
                                ? Colors.white
                                : ColorApp.colorblackgalf.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: FutureBuilder<JobSeekerCareerLevelModel>(
                                future: GlobalVarData.pereferredJobCareerLevel,
                                builder: (context, snapshot) {
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
                                          10, 10, 10, 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppString.careerLevel,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : ColorApp.colorblackgalf,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4,
                                                            bottom: 5),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          setState(() {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AddCareerLevel(
                                                                              navigationDeciderId: '1',
                                                                            )));
                                                          });
                                                        });
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colorblack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 15, 15),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3),
                                              child: Text(
                                                AppString.careerLevel,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : ColorApp.colorblackgalf,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Future.delayed(
                                                          Duration(
                                                              milliseconds:
                                                                  100), () {
                                                        setState(() {
                                                          jobCareerLevel =
                                                              jobCareerLevel
                                                                  ? false
                                                                  : true;
                                                        });
                                                      });
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
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
                                                                  .dltImage,
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
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     Future.delayed(
                                                //         Duration(
                                                //             milliseconds:
                                                //                 100), () {
                                                //       setState(() {
                                                //         jobCareerLevel =
                                                //             jobCareerLevel
                                                //                 ? false
                                                //                 : true;
                                                //       });
                                                //     });
                                                //   },
                                                //   child: Padding(
                                                //     padding:
                                                //         const EdgeInsets.only(
                                                //             right: 10),
                                                //     child: Material(
                                                //       color: isDarkMode ==
                                                //               false
                                                //           ? ColorApp.colorgray
                                                //           : const Color(
                                                //               0xff38373c),
                                                //       elevation: 1,
                                                //       shape:
                                                //           RoundedRectangleBorder(
                                                //               borderRadius:
                                                //                   BorderRadius
                                                //                       .circular(
                                                //                           5)),
                                                //       child: Container(
                                                //         height: 18,
                                                //         width: 28,
                                                //         child: Center(
                                                //           child: Container(
                                                //             width: 15,
                                                //             height: 15,
                                                //             child: Image.asset(
                                                //                 ImangeAssests
                                                //                     .dltImage,
                                                //                 color: isDarkMode ==
                                                //                         true
                                                //                     ? ColorApp
                                                //                         .colorwhite
                                                //                     : Colors
                                                //                         .black,
                                                //                 fit: BoxFit
                                                //                     .fill),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, bottom: 0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Future.delayed(
                                                          Duration(
                                                              milliseconds:
                                                                  100), () {
                                                        setState(() {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AddCareerLevel(
                                                                            navigationDeciderId:
                                                                                '1',
                                                                          )));
                                                        });
                                                      });
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
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
                                                          child: Icon(
                                                            Icons.add,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: deleteCareelLevel == true
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5,
                                                                  left: 3,
                                                                  bottom: 5),
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
                                                                          .all(
                                                                              2),
                                                                  child:
                                                                      Material(
                                                                    color: ColorApp
                                                                        .colorprimary,
                                                                    elevation:
                                                                        1,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(2)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .timeline_outlined,
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
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            snapshot.data!.title
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colornewblack,
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            SkillDeleteAlert(
                                                                context,
                                                                snapshot
                                                                    .data!.id
                                                                    .toString(),
                                                                "Delete Careel Level",
                                                                "this wil delete from all section of you",
                                                                "profile",
                                                                "profileCareerLavelDelete",
                                                                snapshot
                                                                    .data!.title
                                                                    .toString());
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 20),
                                                            child: Visibility(
                                                                visible:
                                                                    jobCareerLevel,
                                                                child:
                                                                    Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                            .red[
                                                                        100],
                                                                  ),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .clear,
                                                                      size: 18,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : ProgressLoading(),
                                        )
                                      ]),
                                    );
                                  }
                                }),
                            //     Consumer<GetJobSeekerCareerLevelController>(
                            //         builder: (context, val, child) {
                            //   if (val.isLoadingCareer) {
                            //     return Container(
                            //       width: s.width,
                            //       height: s.height * 0.20,
                            //       color: isDarkMode == false
                            //           ? Colors.white
                            //           : const Color(0xff38373c),
                            //       child: Shimmer.fromColors(
                            //         baseColor: Colors.grey,
                            //         highlightColor: Colors.white30,
                            //         child: Container(
                            //           child: Column(
                            //             children: [
                            //               Padding(
                            //                 padding:
                            //                     const EdgeInsets.fromLTRB(
                            //                         8, 5, 5, 5),
                            //                 child: Row(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment
                            //                           .spaceBetween,
                            //                   children: [
                            //                     Container(
                            //                       width: 60.0,
                            //                       height: 8.0,
                            //                       color: Colors.white,
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //               Row(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: [
                            //                   Padding(
                            //                     padding:
                            //                         const EdgeInsets.only(
                            //                             left: 8),
                            //                     child: Container(
                            //                       width: 48.0,
                            //                       height: 48.0,
                            //                       decoration: BoxDecoration(
                            //                           color: Colors.white,
                            //                           borderRadius:
                            //                               BorderRadius
                            //                                   .circular(4)),
                            //                     ),
                            //                   ),
                            //                   const Padding(
                            //                     padding: EdgeInsets.symmetric(
                            //                         horizontal: 8.0),
                            //                   ),
                            //                   Expanded(
                            //                     child: Column(
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment
                            //                               .start,
                            //                       children: <Widget>[
                            //                         Container(
                            //                           width: s.width * 0.4,
                            //                           height: 8.0,
                            //                           color: Colors.white,
                            //                         ),
                            //                         const Padding(
                            //                           padding: EdgeInsets
                            //                               .symmetric(
                            //                                   vertical: 2.0),
                            //                         ),
                            //                         Container(
                            //                           width: s.width * 0.6,
                            //                           height: 8.0,
                            //                           color: Colors.white,
                            //                         ),
                            //                         const Padding(
                            //                           padding: EdgeInsets
                            //                               .symmetric(
                            //                                   vertical: 2.0),
                            //                         ),
                            //                         Container(
                            //                           width: s.width * 0.7,
                            //                           height: 8.0,
                            //                           color: Colors.white,
                            //                         ),
                            //                         const Padding(
                            //                           padding: EdgeInsets
                            //                               .symmetric(
                            //                                   vertical: 2.0),
                            //                         ),
                            //                         Container(
                            //                           width: s.width * 0.4,
                            //                           height: 15.0,
                            //                           color: Colors.white,
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //               Divider(
                            //                 height: 3,
                            //               ),
                            //               Row(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: [
                            //                   Padding(
                            //                     padding:
                            //                         const EdgeInsets.only(
                            //                             left: 8),
                            //                     child: Container(
                            //                       width: 48.0,
                            //                       height: 48.0,
                            //                       decoration: BoxDecoration(
                            //                           color: Colors.white,
                            //                           borderRadius:
                            //                               BorderRadius
                            //                                   .circular(4)),
                            //                     ),
                            //                   ),
                            //                   const Padding(
                            //                     padding: EdgeInsets.symmetric(
                            //                         horizontal: 8.0),
                            //                   ),
                            //                   Expanded(
                            //                     child: Column(
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment
                            //                               .start,
                            //                       children: <Widget>[
                            //                         Container(
                            //                           width: s.width * 0.4,
                            //                           height: 8.0,
                            //                         ),
                            //                         const Padding(
                            //                           padding: EdgeInsets
                            //                               .symmetric(
                            //                                   vertical: 2.0),
                            //                         ),
                            //                         Container(
                            //                           width: s.width * 0.6,
                            //                           height: 8.0,
                            //                           color: Colors.white,
                            //                         ),
                            //                         const Padding(
                            //                           padding: EdgeInsets
                            //                               .symmetric(
                            //                                   vertical: 2.0),
                            //                         ),
                            //                         Container(
                            //                           width: s.width * 0.7,
                            //                           height: 8.0,
                            //                           color: Colors.white,
                            //                         ),
                            //                         const Padding(
                            //                           padding: EdgeInsets
                            //                               .symmetric(
                            //                                   vertical: 2.0),
                            //                         ),
                            //                         Container(
                            //                           width: s.width * 0.4,
                            //                           height: 8.0,
                            //                           color: Colors.white,
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   } else {
                            //     if (val.careerLevelListData.isEmpty) {
                            //       return Padding(
                            //         padding: const EdgeInsets.fromLTRB(
                            //             10, 10, 10, 10),
                            //         child: Column(
                            //           children: [
                            //             Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Text(
                            //                   AppString.careerLevel,
                            //                   style: TextStyle(
                            //                     fontSize: 17,
                            //                     color: isDarkMode == true
                            //                         ? Colors.white
                            //                         : ColorApp.colorblackgalf,
                            //                     fontWeight: FontWeight.w500,
                            //                   ),
                            //                 ),
                            //                 Row(
                            //                   children: [
                            //                     Padding(
                            //                       padding:
                            //                           const EdgeInsets.only(
                            //                               right: 4,
                            //                               bottom: 5),
                            //                       child: InkWell(
                            //                         onTap: () {
                            //                           Future.delayed(
                            //                               Duration(
                            //                                   milliseconds:
                            //                                       100), () {
                            //                             setState(() {
                            //                               Navigator.push(
                            //                                   context,
                            //                                   MaterialPageRoute(
                            //                                       builder:
                            //                                           (context) =>
                            //                                               AddCareerLevel(
                            //                                                 navigationDeciderId: '1',
                            //                                               )));
                            //                             });
                            //                           });
                            //                         },
                            //                         child: Material(
                            //                           color: isDarkMode ==
                            //                                   false
                            //                               ? ColorApp.colorgray
                            //                               : ColorApp
                            //                                   .colorblackgalf
                            //                                   .withOpacity(
                            //                                       0.2),
                            //                           elevation: 0,
                            //                           shape:
                            //                               RoundedRectangleBorder(
                            //                                   borderRadius:
                            //                                       BorderRadius
                            //                                           .circular(
                            //                                               5)),
                            //                           child: Container(
                            //                             decoration:
                            //                                 BoxDecoration(
                            //                               color: isDarkMode ==
                            //                                       false
                            //                                   ? ColorApp
                            //                                       .colorgray
                            //                                   : ColorApp
                            //                                       .colorblackgalf
                            //                                       .withOpacity(
                            //                                           0.2),
                            //                               borderRadius:
                            //                                   BorderRadius
                            //                                       .circular(
                            //                                           5),
                            //                             ),
                            //                             height: 25,
                            //                             width: 33,
                            //                             child: Center(
                            //                               child: Icon(
                            //                                 Icons.add,
                            //                                 color: isDarkMode ==
                            //                                         true
                            //                                     ? Colors.white
                            //                                     : ColorApp
                            //                                         .colorblack,
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     } else {
                            //       return Padding(
                            //         padding: const EdgeInsets.fromLTRB(
                            //             10, 10, 15, 15),
                            //         child: Column(
                            //           children: [
                            //             Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       bottom: 3),
                            //                   child: Text(
                            //                     AppString.careerLevel,
                            //                     style: TextStyle(
                            //                       fontSize: 17,
                            //                       color: isDarkMode == true
                            //                           ? Colors.white
                            //                           : ColorApp
                            //                               .colorblackgalf,
                            //                       fontWeight: FontWeight.w500,
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 Row(
                            //                   children: [
                            //                     Padding(
                            //                       padding:
                            //                           const EdgeInsets.only(
                            //                               right: 8),
                            //                       child: InkWell(
                            //                         onTap: () {
                            //                           Future.delayed(
                            //                               Duration(
                            //                                   milliseconds:
                            //                                       100), () {
                            //                             setState(() {
                            //                               jobCareerLevel =
                            //                                   jobCareerLevel
                            //                                       ? false
                            //                                       : true;
                            //                             });
                            //                           });
                            //                         },
                            //                         child: Material(
                            //                           color: isDarkMode ==
                            //                                   false
                            //                               ? ColorApp.colorgray
                            //                               : ColorApp
                            //                                   .colorblackgalf
                            //                                   .withOpacity(
                            //                                       0.2),
                            //                           elevation: 0,
                            //                           shape:
                            //                               RoundedRectangleBorder(
                            //                                   borderRadius:
                            //                                       BorderRadius
                            //                                           .circular(
                            //                                               5)),
                            //                           child: Container(
                            //                             decoration:
                            //                                 BoxDecoration(
                            //                               color: isDarkMode ==
                            //                                       false
                            //                                   ? ColorApp
                            //                                       .colorgray
                            //                                   : ColorApp
                            //                                       .colorblackgalf
                            //                                       .withOpacity(
                            //                                           0.2),
                            //                               borderRadius:
                            //                                   BorderRadius
                            //                                       .circular(
                            //                                           5),
                            //                             ),
                            //                             height: 25,
                            //                             width: 33,
                            //                             child: Center(
                            //                               child: Image.asset(
                            //                                   width: 17,
                            //                                   height: 16,
                            //                                   ImangeAssests
                            //                                       .dltImage,
                            //                                   color: isDarkMode ==
                            //                                           true
                            //                                       ? Colors
                            //                                           .white
                            //                                       : ColorApp
                            //                                           .colorblack,
                            //                                   fit: BoxFit
                            //                                       .fill),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     // GestureDetector(
                            //                     //   onTap: () {
                            //                     //     Future.delayed(
                            //                     //         Duration(
                            //                     //             milliseconds:
                            //                     //                 100), () {
                            //                     //       setState(() {
                            //                     //         jobCareerLevel =
                            //                     //             jobCareerLevel
                            //                     //                 ? false
                            //                     //                 : true;
                            //                     //       });
                            //                     //     });
                            //                     //   },
                            //                     //   child: Padding(
                            //                     //     padding:
                            //                     //         const EdgeInsets.only(
                            //                     //             right: 10),
                            //                     //     child: Material(
                            //                     //       color: isDarkMode ==
                            //                     //               false
                            //                     //           ? ColorApp.colorgray
                            //                     //           : const Color(
                            //                     //               0xff38373c),
                            //                     //       elevation: 1,
                            //                     //       shape:
                            //                     //           RoundedRectangleBorder(
                            //                     //               borderRadius:
                            //                     //                   BorderRadius
                            //                     //                       .circular(
                            //                     //                           5)),
                            //                     //       child: Container(
                            //                     //         height: 18,
                            //                     //         width: 28,
                            //                     //         child: Center(
                            //                     //           child: Container(
                            //                     //             width: 15,
                            //                     //             height: 15,
                            //                     //             child: Image.asset(
                            //                     //                 ImangeAssests
                            //                     //                     .dltImage,
                            //                     //                 color: isDarkMode ==
                            //                     //                         true
                            //                     //                     ? ColorApp
                            //                     //                         .colorwhite
                            //                     //                     : Colors
                            //                     //                         .black,
                            //                     //                 fit: BoxFit
                            //                     //                     .fill),
                            //                     //           ),
                            //                     //         ),
                            //                     //       ),
                            //                     //     ),
                            //                     //   ),
                            //                     // ),
                            //                     Padding(
                            //                       padding:
                            //                           const EdgeInsets.only(
                            //                               right: 0,
                            //                               bottom: 0),
                            //                       child: InkWell(
                            //                         onTap: () {
                            //                           Future.delayed(
                            //                               Duration(
                            //                                   milliseconds:
                            //                                       100), () {
                            //                             setState(() {
                            //                               Navigator.push(
                            //                                   context,
                            //                                   MaterialPageRoute(
                            //                                       builder:
                            //                                           (context) =>
                            //                                               AddCareerLevel(
                            //                                                 navigationDeciderId: '1',
                            //                                               )));
                            //                             });
                            //                           });
                            //                         },
                            //                         child: Material(
                            //                           color: isDarkMode ==
                            //                                   false
                            //                               ? ColorApp.colorgray
                            //                               : ColorApp
                            //                                   .colorblackgalf
                            //                                   .withOpacity(
                            //                                       0.2),
                            //                           elevation: 0,
                            //                           shape:
                            //                               RoundedRectangleBorder(
                            //                                   borderRadius:
                            //                                       BorderRadius
                            //                                           .circular(
                            //                                               5)),
                            //                           child: Container(
                            //                             decoration:
                            //                                 BoxDecoration(
                            //                               color: isDarkMode ==
                            //                                       false
                            //                                   ? ColorApp
                            //                                       .colorgray
                            //                                   : ColorApp
                            //                                       .colorblackgalf
                            //                                       .withOpacity(
                            //                                           0.2),
                            //                               borderRadius:
                            //                                   BorderRadius
                            //                                       .circular(
                            //                                           5),
                            //                             ),
                            //                             height: 25,
                            //                             width: 33,
                            //                             child: Center(
                            //                               child: Icon(
                            //                                 Icons.add,
                            //                                 color: isDarkMode ==
                            //                                         true
                            //                                     ? Colors.white
                            //                                     : ColorApp
                            //                                         .colorblack,
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //             ListView.builder(
                            //                 physics: ScrollPhysics(),
                            //                 shrinkWrap: true,
                            //                 itemCount: val
                            //                     .careerLevelListData.length,
                            //                 itemBuilder: (contex, index) {
                            //                   return Padding(
                            //                     padding:
                            //                         const EdgeInsets.only(
                            //                             top: 1),
                            //                     child:
                            //                         deleteCareelLevel == true
                            //                             ? Column(
                            //                                 children: [
                            //                                   Row(
                            //                                     children: [
                            //                                       Padding(
                            //                                         padding: const EdgeInsets
                            //                                                 .only(
                            //                                             right:
                            //                                                 5,
                            //                                             left:
                            //                                                 3,
                            //                                             bottom:
                            //                                                 5),
                            //                                         child:
                            //                                             Container(
                            //                                           decoration: BoxDecoration(
                            //                                               color:
                            //                                                   ColorApp.colorprimary,
                            //                                               borderRadius: BorderRadius.circular(4)),
                            //                                           child:
                            //                                               Padding(
                            //                                             padding:
                            //                                                 const EdgeInsets.all(2),
                            //                                             child:
                            //                                                 Container(
                            //                                               width:
                            //                                                   s.width * 0.10,
                            //                                               height:
                            //                                                   30,
                            //                                               decoration:
                            //                                                   BoxDecoration(
                            //                                                 borderRadius: BorderRadius.circular(3),
                            //                                                 color: Colors.white,
                            //                                                 border: Border.all(color: ColorApp.colorprimary),
                            //                                               ),
                            //                                               child:
                            //                                                   Padding(
                            //                                                 padding: EdgeInsets.all(2),
                            //                                                 child: Material(
                            //                                                   color: ColorApp.colorprimary,
                            //                                                   elevation: 1,
                            //                                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                            //                                                   child: Center(
                            //                                                     child: Icon(
                            //                                                       Icons.timeline_outlined,
                            //                                                       color: Colors.white,
                            //                                                     ),
                            //                                                   ),
                            //                                                 ),
                            //                                               ),
                            //                                             ),
                            //                                           ),
                            //                                         ),
                            //                                       ),
                            //                                       Padding(
                            //                                         padding: const EdgeInsets
                            //                                                 .only(
                            //                                             left:
                            //                                                 10),
                            //                                         child:
                            //                                             Text(
                            //                                           val.careerLevelListData[index]
                            //                                               .title
                            //                                               .toString(),
                            //                                           style:
                            //                                               TextStyle(
                            //                                             fontWeight:
                            //                                                 FontWeight.w500,
                            //                                             fontSize:
                            //                                                 12,
                            //                                             color: isDarkMode == true
                            //                                                 ? Colors.white
                            //                                                 : ColorApp.colornewblack,
                            //                                           ),
                            //                                         ),
                            //                                       ),
                            //                                       GestureDetector(
                            //                                         onTap:
                            //                                             () {
                            //                                           SkillDeleteAlert(
                            //                                               context,
                            //                                               val.careerLevelListData[index].id.toString(),
                            //                                               "Delete Careel Level",
                            //                                               "this wil delete from all section of you",
                            //                                               "profile",
                            //                                               "profileCareerLavelDelete",
                            //                                               val.careerLevelListData[index].title.toString());
                            //                                         },
                            //                                         child:
                            //                                             Padding(
                            //                                           padding:
                            //                                               const EdgeInsets.only(right: 20),
                            //                                           child: Visibility(
                            //                                               visible: jobCareerLevel,
                            //                                               child: Container(
                            //                                                 height: 20,
                            //                                                 width: 20,
                            //                                                 decoration: BoxDecoration(
                            //                                                   color: Colors.red[100],
                            //                                                 ),
                            //                                                 child: Center(
                            //                                                   child: Icon(
                            //                                                     Icons.clear,
                            //                                                     size: 18,
                            //                                                     color: Colors.red,
                            //                                                   ),
                            //                                                 ),
                            //                                               )),
                            //                                         ),
                            //                                       ),
                            //                                     ],
                            //                                   ),
                            //                                 ],
                            //                               )
                            //                             : ProgressLoading(),
                            //                   );
                            //                 }),
                            //           ],
                            //         ),
                            //       );
                            //       ;
                            //     }
                            //   }
                            // }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: s.height * 0.04),
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
                                                  ApplayRelocationScreen(
                                                    indecator:
                                                        widget.indecator + 1,
                                                    image: widget.image,
                                                  )));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ApplayExperienceScreen()));
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

  SkillDeleteAlert(BuildContext context, id, deleteText, subtitle, subtitle2,
      uniqueId, title) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor:
          isDarkMode == true ? ColorApp.colorbgbtn : ColorApp.colorbgbtn,
      insetPadding: EdgeInsets.only(
        bottom: Get.height * 0.42,
        top: Get.height * 0.3,
        left: Get.width * 0.04,
        right: Get.width * 0.04,
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      actions: [
        Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: isDarkMode == true
                        ? ColorApp.colornewblack
                        : Colors.grey),
                width: MediaQuery.of(context).size.width,
                height: Get.height * 0.06,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.02, top: 12),
                  child: Text(
                    deleteText,
                    style: TextStyle(
                      color: isDarkMode == true
                          ? ColorApp.colorbackground
                          : ColorApp.colorbackground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: "this will delete" + " ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Montserrat",
                                              fontSize: 15,
                                              color: isDarkMode == true
                                                  ? ColorApp.colornewblack
                                                  : ColorApp.colornewblack),
                                          children: <TextSpan>[
                                        TextSpan(
                                          text: '"$title"',
                                          style: TextStyle(
                                            color: isDarkMode == true
                                                ? ColorApp.colorprimary
                                                : ColorApp.colorprimary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                          ),
                                        ),
                                        TextSpan(
                                          text: " " +
                                              'from all section of Your Profile',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Montserrat",
                                              fontSize: 15,
                                              color: isDarkMode == true
                                                  ? ColorApp.colornewblack
                                                  : ColorApp.colornewblack),
                                        ),
                                      ])),
                                ],
                              )),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.3,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (uniqueId == 'profileCareerLavelDelete') {
                        jobCareerLevel = false;
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorApp.colornewblack),
                      borderRadius: BorderRadius.circular(6),
                      color: ColorApp.colorbgbtn,
                    ),
                    child: Center(
                      child: Text(
                        'No, Thanks',
                        style: TextStyle(
                            fontSize: 15, color: ColorApp.colornewblack),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Consumer<PostDeleteAlertProfileBase>(
                  builder: (context, val, child) {
                    return ElevatedButton(
                      onPressed: () {
                        if (uniqueId == 'profileCareerLavelDelete') {
                          setState(() {
                            deleteCareelLevel = false;
                            jobCareerLevel = false;
                          });
                          val.jobSeekerDeleteCareerLevel(id, context);
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              setState(() {
                                GlobalVarData.pereferredJobCareerLevel =
                                    GetJobSeekerCareerLevelController()
                                        .getJobSeekerCareerLevel();
                                deleteCareelLevel = true;
                              });
                            });
                          });
                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetJobSeekerCareerLevelController>(
                                      context,
                                      listen: false)
                                  .getJobSeekerCareerLevel();
                              Provider.of<GetJobSeekerCareerLevelController>(
                                      context,
                                      listen: false)
                                  .getJobSeekerCareerLevel();
                            });
                            Get.back();
                          });
                        }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        )),
                        shadowColor: MaterialStateProperty.all(Colors.red),
                        backgroundColor:
                            MaterialStateProperty.all(ColorApp.colorprimary),
                      ),
                      child: val.loadingSkillDelete == false
                          ? Text(
                              "Delete",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: isDarkMode == false
                                      ? AppColors.colorwhite
                                      : Colors.white),
                            )
                          : SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator()),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
