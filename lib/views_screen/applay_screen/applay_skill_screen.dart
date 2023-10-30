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
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_certificationList_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_skill_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_delete_AlertApi_profilebase_controller.dart';
import '../../constants/color_app.dart';
import '../../profile_model/job_seeker_skill_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/Loading_data.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../profile_screen/profile_add_skill_screen.dart';
import 'applay_career_level_screen.dart';

class ApplaySkillScreen extends StatefulWidget {
  int indecator;
  String? image;

  ApplaySkillScreen({Key? key, required this.indecator,this.image}) : super(key: key);

  @override
  State<ApplaySkillScreen> createState() => _ApplaySkillScreenState();
}

class _ApplaySkillScreenState extends State<ApplaySkillScreen> {
  @override
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

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetJobSkillController>(context, listen: false)
          .skillListData
          .clear();
      Provider.of<GetJobSkillController>(context, listen: false)
          .jobSeekerSkill();
      Provider.of<GetCertificationController>(context, listen: false)
          .jobSeekerCertifications();
    });

    super.initState();
    getJobCardValues();
  }

  bool tapped = false;
  bool deleteSkillLevel = true;
  bool deleteGallery = true;
  bool deleteDataSkill = false;
  bool skillAdd = true;

  @override
  Widget build(BuildContext context) {
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
                      "Skill Information",
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
                padding:EdgeInsets.only(top: 8, left: s.width*0.04, right: s.width*0.04),
                child: Column(
                  children: [
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      color: isDarkMode == true
                          ? Color(0xff787777).withOpacity(0.2)
                          : ColorApp.colorwhite,
                      elevation: 1,
                      child: Consumer<GetJobSkillController>(
                          builder: (context, val, child) {
                        if (val.isLoading) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
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
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 5, 5),
                                            child: Container(
                                              width: s.width * 0.94,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 5, 5),
                                            child: Container(
                                              width: s.width * 0.94,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 5, 5),
                                            child: Container(
                                              width: s.width * 0.94,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
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
                        } else {
                          if (val.skillListData.isEmpty) {
                            return Material(
                              elevation: 1,
                              color: isDarkMode == true
                                  ? Color(0xff787777).withOpacity(0.2)
                                  : ColorApp.colorwhite,
                              shape: RoundedRectangleBorder(
                                  // side: BorderSide(
                                  //   color: isDarkMode == true
                                  //       ? Color(0xff787777).withOpacity(0.2)
                                  //       : Colors.black54.withOpacity(0.3),
                                  // ),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3, 10, 10, 5),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppString.skill,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Material(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      color:isDarkMode == false
                                                          ? ColorApp
                                                          .colorgray
                                                          : Color(0xff787777).withOpacity(0.2),
                                                      elevation: 1,
                                                      child: EffectButton(
                                                        heightButton:
                                                            s.height * 0.025,
                                                        widthButton:
                                                            s.width * 0.075,
                                                        Ontap: () {
                                                          skillAdd = true;
                                                          GlobalVarData
                                                                  .isSkillAdd ==
                                                              'done';
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AddSkill();
                                                              });
                                                        },
                                                        icon: Icons.add,
                                                        color:
                                                            isDarkMode == false
                                                                ? Colors.black87
                                                                : Colors.white,
                                                      ),
                                                    ),
                                                  ],
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
                            );
                          } else {
                            return Material(
                              elevation: 1,
                              color: isDarkMode == true
                                  ? Color(0xff787777).withOpacity(0.2)
                                  : ColorApp.colorwhite,
                              shape: RoundedRectangleBorder(
                                  // side: BorderSide(
                                  //   color: isDarkMode == true
                                  //       ? Color(0xff787777).withOpacity(0.2)
                                  //       : Colors.black54.withOpacity(0.3),
                                  // ),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 15, 19, 15),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppString.skill,
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
                                                padding: const EdgeInsets.only(
                                                    right: 12),
                                                child: Material(
                                                  color: isDarkMode == false
                                                      ? ColorApp
                                                      .colorgray
                                                      : Color(0xff787777).withOpacity(0.2),
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: EffectButton(
                                                    heightButton:
                                                        s.height * 0.025,
                                                    widthButton:
                                                        s.width * 0.075,
                                                    Ontap: () {
                                                      setState(() {
                                                        deleteDataSkill =
                                                            deleteDataSkill
                                                                ? false
                                                                : true;
                                                      });
                                                    },
                                                    icon: Icons.delete,
                                                    color: isDarkMode == false
                                                        ? Colors.black87
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                color: isDarkMode == false
                                                    ? ColorApp
                                                    .colorgray
                                                    : Color(0xff787777).withOpacity(0.2),
                                                elevation: 1,
                                                child: EffectButton(
                                                  heightButton:
                                                      s.height * 0.025,
                                                  widthButton: s.width * 0.075,
                                                  Ontap: () {
                                                    skillAdd = true;
                                                    GlobalVarData.isSkillAdd ==
                                                        'done';
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AddSkill();
                                                        });
                                                  },
                                                  icon: Icons.add,
                                                  color: isDarkMode == false
                                                      ? Colors.black87
                                                      : Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: deleteSkillLevel == true
                                              ? GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                    // padding: const EdgeInsets.all(10),
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 0,
                                                    maxCrossAxisExtent: 180.0,

                                                    childAspectRatio: 3,
                                                  ),
                                                  itemCount:
                                                      val.skillListData.length,
                                                  itemBuilder:
                                                      (BuildContext ctx,
                                                          index) {
                                                    return Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              child: Container(
                                                                width: s.width *
                                                                    0.10,
                                                                height: 33,
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
                                                                      const EdgeInsets
                                                                              .all(
                                                                          1.5),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: ColorApp
                                                                            .colorprimary,
                                                                        borderRadius:
                                                                            BorderRadius.circular(3)),
                                                                    width:
                                                                        s.width *
                                                                            0.10,
                                                                    height: 32,
                                                                    child: Icon(
                                                                      Icons
                                                                          .watch_later_outlined,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                val.skillListData[index]
                                                                        .title
                                                                        .toString() ,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14,
                                                                  color: isDarkMode ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : ColorApp
                                                                          .colornewblack,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                SkillDeleteAlert(
                                                                    context,
                                                                    val
                                                                        .skillListData[
                                                                    index]
                                                                        .id
                                                                        .toString(),
                                                                    "Delete Skills ?",
                                                                    "this wil delete from all section of you",
                                                                    "profile",
                                                                    "profileSkillDelete",
                                                                    val
                                                                        .skillListData[
                                                                    index]
                                                                        .title
                                                                        .toString());
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            0),
                                                                child:
                                                                    Visibility(
                                                                        visible:
                                                                            deleteDataSkill,
                                                                        child:
                                                                            Container(
                                                                          color: tapped
                                                                              ? Colors.red.withOpacity(0.5)
                                                                              : Colors.white,
                                                                          child:
                                                                              Icon(
                                                                            Icons.clear,
                                                                            color:
                                                                                AppColors.colorred,
                                                                          ),
                                                                        )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  })
                                              : ProgressLoading(),
                                        ),
                                      ],
                                    ),
                                    // Material(
                                    //   color:
                                    //   Colors.white.withOpacity(0.0),
                                    //   child: InkWell(
                                    //       child: Container(
                                    //         width: s.width * 10,
                                    //         child: Row(
                                    //           crossAxisAlignment:
                                    //           CrossAxisAlignment
                                    //               .center,
                                    //           mainAxisAlignment:
                                    //           MainAxisAlignment
                                    //               .center,
                                    //           children: [
                                    //             Center(
                                    //               child: Text(
                                    //                 "View all  Skills",
                                    //                 style: TextStyle(
                                    //                   color: ColorApp
                                    //                       .colorprimary,
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       onTap: () {
                                    //         Future.delayed(
                                    //             Duration(
                                    //                 milliseconds: 100),
                                    //                 () {
                                    //               Navigator.push(
                                    //                   context,
                                    //                   MaterialPageRoute(
                                    //                       builder: (
                                    //                           context) =>
                                    //                           SkillListShow()));
                                    //             });
                                    //       }),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                      }),
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
                                                  ApplayCareerLavelScreen(indecator: widget.indecator  + 1,image: widget.image,)));

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
                      if (uniqueId == 'profileSkillDelete') {
                        deleteDataSkill = false;
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
                        if (uniqueId == 'profileSkillDelete') {
                          setState(() {
                            deleteSkillLevel = false;
                            deleteDataSkill = false;
                          });
                          val.jobSkillDelete(id, context);
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              GlobalVarData.skillListFuture =
                                  GetJobSkillController().jobSeekerSkill();
                              deleteSkillLevel = true;
                            });
                          });
                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetJobSkillController>(context,
                                  listen: false)
                                  .skillListData
                                  .clear();
                              Provider.of<GetJobSkillController>(context,
                                  listen: false)
                                  .jobSeekerSkill();
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
  // SkillDeleteAlert(
  //     BuildContext context, id, deleteText, subtitle, subtitle2, uniqueId) {
  //   var brightness = MediaQuery.of(context).platformBrightness;
  //   bool isDarkMode = brightness == Brightness.dark;
  //
  //   AlertDialog alert = AlertDialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     backgroundColor: isDarkMode == true ? Colors.grey : Colors.white,
  //     insetPadding: EdgeInsets.only(
  //       bottom: Get.height * 0.42,
  //       top: Get.height * 0.3,
  //       left: Get.width * 0.04,
  //       right: Get.width * 0.04,
  //     ),
  //     contentPadding: EdgeInsets.zero,
  //     actions: [
  //       Column(
  //         children: [
  //           Container(
  //               decoration: BoxDecoration(
  //                   color: isDarkMode == true ? Colors.black87 : Colors.grey),
  //               width: MediaQuery.of(context).size.width,
  //               height: Get.height * 0.06,
  //               child: Padding(
  //                 padding: EdgeInsets.only(left: Get.width * 0.05, top: 12),
  //                 child: Text(
  //                   deleteText,
  //                   style: TextStyle(
  //                       color:
  //                           isDarkMode == true ? Colors.white : Colors.black),
  //                 ),
  //               )),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 10),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       subtitle,
  //                       style: TextStyle(
  //                           color: isDarkMode == true
  //                               ? Colors.black26
  //                               : Colors.grey),
  //                     ),
  //                     Text(
  //                       subtitle2,
  //                       style: TextStyle(
  //                           color: isDarkMode == true
  //                               ? Colors.black26
  //                               : Colors.grey),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               SizedBox(
  //                 width: Get.width * 0.3,
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     if (uniqueId == 'profileSkillDelete') {
  //                       deleteDataSkill = false;
  //                       Navigator.pop(context);
  //                     }
  //
  //                   });
  //                 },
  //                 child: Container(
  //                   height: Get.height * 0.05,
  //                   width: Get.width * 0.3,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(18.0),
  //                     color: Colors.blueAccent.withOpacity(0.3),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       'No Thanks',
  //                       style: TextStyle(
  //                           fontSize: 15, color: ColorApp.colorprimary),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: Get.width * 0.03,
  //               ),
  //               Consumer<PostDeleteAlertProfileBase>(
  //                 builder: (context, val, child) {
  //                   return ElevatedButton(
  //                     onPressed: () {
  //                       if (uniqueId == 'profileSkillDelete') {
  //                         setState(() {
  //                           deleteSkillLevel = false;
  //                           deleteDataSkill = false;
  //                         });
  //                         val.jobSkillDelete(id, context);
  //                         Future.delayed(Duration(seconds: 1), () {
  //                           setState(() {
  //                             GlobalVarData.skillListFuture =
  //                                 GetJobSkillController().jobSeekerSkill();
  //                             deleteSkillLevel = true;
  //                           });
  //                         });
  //
  //                         Navigator.pop(context);
  //                       }
  //                     },
  //                     style: ButtonStyle(
  //                       shape:
  //                           MaterialStateProperty.all<RoundedRectangleBorder>(
  //                               RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(18.0),
  //                       )),
  //                       shadowColor: MaterialStateProperty.all(Colors.red),
  //                       backgroundColor:
  //                           MaterialStateProperty.all(ColorApp.colorprimary),
  //                     ),
  //                     child: val.loadingSkillDelete == false
  //                         ? Text(
  //                             "Delete",
  //                             style: TextStyle(
  //                                 fontSize: 16,
  //                                 color: isDarkMode == false
  //                                     ? AppColors.colorwhite
  //                                     : Colors.white),
  //                           )
  //                         : CircularProgressIndicator(),
  //                   );
  //                 },
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
