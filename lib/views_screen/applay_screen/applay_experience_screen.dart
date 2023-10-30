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
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_experience_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_skill_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_qualification_controller.dart';
import '../../constants/color_app.dart';
import '../../profile_model/job_seeker_work_experience_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../profile_screen/profile_add_experience.dart';
import '../profile_screen/profile_edit_experience.dart';
import 'applay_skill_screen.dart';

class ApplayExperienceScreen extends StatefulWidget {
  int indecator;
  String ?image;
   ApplayExperienceScreen({Key? key,required this.indecator,this.image}) : super(key: key);

  @override
  State<ApplayExperienceScreen> createState() => _ApplayExperienceScreenState();
}

class _ApplayExperienceScreenState extends State<ApplayExperienceScreen> {
  @override
  bool isExpAdd = true;
  bool isExpUpdate = true;
  @override
  String? jobName;
  String? companyName;
  String? cityName;
  String? salaryShow;
  String? postedTime;
  String? imageUrl;
  String ?jobDescription;
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
    Timer(Duration(milliseconds: 900), () {
      GlobalVarData.educationListFuture =
          GetQualificationController().getEducationList();
    });
    Timer(Duration(milliseconds: 1100), () {
      GlobalVarData.experienceListFuture =
          GetExperienceController().getWorkExperienceList();
    });
    Timer(Duration(milliseconds: 1500), () {
      GlobalVarData.skillListFuture = GetJobSkillController().jobSeekerSkill();
    });
    Timer(Duration(milliseconds: 600), () {
      GlobalVarData.certificationsListFuture =
          GetCertificationController().jobSeekerCertifications();
    });
    super.initState();
    getJobCardValues();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetExperienceController>(context,listen: false).workexperienceListData.clear();
      Provider.of<GetExperienceController>(context,listen: false).getWorkExperienceList();

    });
  }
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

              SizedBox(height: s.height*0.013,),
            AppCardWidget(),
              Padding(
                padding:  EdgeInsets.only(left: s.width*0.06,top: 20,bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.indecator.toString() +"/" +"10",style: TextStyle(
                        color: isDarkMode == false
                            ? ColorApp.colorblackgalf.withOpacity(0.7)
                            : ColorApp.colorwhite.withOpacity(0.68)
                    ),),
                    Padding(
                      padding:  EdgeInsets.only(right: s.width*0.05),
                      child: Text("Skip & processed application ",style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ColorApp.colorprimary
                      ),),
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 10,right: 10),
                child: LinearPercentIndicator( //leaner progress bar
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 6.0,
                  percent:widget.indecator/10,

                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: AppColors.colorprimary,
                  backgroundColor: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf.withOpacity(0.5),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10, left: s.width * 0.049),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Experience Information",
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
                padding:  EdgeInsets.only(top: 8, left: s.width*0.04, right: s.width*0.04),
                child: Column(
                  children: [

                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      color: isDarkMode == true
                          ? Color(0xff787777).withOpacity(0.2)
                          : ColorApp.colorwhite,
                      elevation: 1,
                      child: Consumer<GetExperienceController>(builder:(context,val,child){
                        if(val.isLoading){
                          return Container(
                            width: s.width,
                            height: s.height * 0.20,
                            color: isDarkMode == false
                                ? Colors.white
                                : const Color(0xff38373c),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.white30,
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          8, 5, 5, 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            width: 60.0,
                                            height: 8.0,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 8),
                                          child: Container(
                                            width: 48.0,
                                            height: 48.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    4)),
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                          EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Container(
                                                width:
                                                s.width * 0.4,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    vertical:
                                                    2.0),
                                              ),
                                              Container(
                                                width:
                                                s.width * 0.6,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    vertical:
                                                    2.0),
                                              ),
                                              Container(
                                                width:
                                                s.width * 0.7,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    vertical:
                                                    2.0),
                                              ),
                                              Container(
                                                width:
                                                s.width * 0.4,
                                                height: 15.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 3,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 8),
                                          child: Container(
                                            width: 48.0,
                                            height: 48.0,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    4)),
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                          EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Container(
                                                width:
                                                s.width * 0.4,
                                                height: 8.0,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    vertical:
                                                    2.0),
                                              ),
                                              Container(
                                                width:
                                                s.width * 0.6,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    vertical:
                                                    2.0),
                                              ),
                                              Container(
                                                width:
                                                s.width * 0.7,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    vertical:
                                                    2.0),
                                              ),
                                              Container(
                                                width:
                                                s.width * 0.4,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        else{
                          if(val.workexperienceListData.isEmpty){
                            return  Material(
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
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppString.experience,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : ColorApp.colorblackgalf,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 9),
                                      child: Row(
                                        children: [
                                          Material(
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    5.0)),
                                            color: isDarkMode == false
                                                ? ColorApp
                                                .colorgray
                                                : Color(0xff787777).withOpacity(0.2),
                                            child: EffectButton(
                                              heightButton: s.height * 0.025,
                                              widthButton: s.width * 0.075,
                                              Ontap: () {
                                                isExpAdd = true;
                                                GlobalVarData
                                                    .isExperienceAdd ==
                                                    'done';

                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) {
                                                      return AddExperience(
                                                        navDecider: '1',
                                                      );
                                                    });
                                              },
                                              icon: Icons.add,
                                              color: isDarkMode == false
                                                  ? Colors.black87
                                                  : Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          else{
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
                                EdgeInsets.fromLTRB(10, 15, 10, 15),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          AppString.experience,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: isDarkMode == true
                                                ? Colors.white
                                                : ColorApp
                                                .colorblackgalf,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              right: 9),
                                          child: Row(
                                            children: [
                                              Material(
                                                elevation: 1,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        5.0)),
                                                color:isDarkMode == false
                                                    ? ColorApp
                                                    .colorgray
                                                    : Color(0xff787777).withOpacity(0.2),
                                                child: EffectButton(
                                                  heightButton:
                                                  s.height * 0.025,
                                                  widthButton:
                                                  s.width * 0.075,
                                                  Ontap: () {
                                                    isExpAdd = true;
                                                    GlobalVarData
                                                        .isExperienceAdd ==
                                                        'done';

                                                    showDialog(
                                                        context:
                                                        context,
                                                        builder:
                                                            (BuildContext
                                                        context) {
                                                          return AddExperience(
                                                            navDecider:
                                                            '1',
                                                          );
                                                        });
                                                  },
                                                  icon: Icons.add,
                                                  color: isDarkMode ==
                                                      false
                                                      ? Colors.black87
                                                      : Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: s.width,
                                      child: ListView.builder(
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                          val.workexperienceListData.length ,
                                          itemBuilder:
                                              (context, index) {
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
                                                          right: 9),
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
                                                                BorderRadius
                                                                    .circular(
                                                                    3)),
                                                            width:
                                                            s.width *
                                                                0.10,
                                                            height: 32,
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
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            4,
                                                            10,
                                                            8,
                                                            0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        val.workexperienceListData[index]
                                                                            .title
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight
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
                                                                      Text(
                                                                        val.workexperienceListData[index]
                                                                            .company
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color: isDarkMode ==
                                                                                false
                                                                                ? ColorApp
                                                                                .colorblackgalf
                                                                                : Colors
                                                                                .white70,
                                                                            fontSize: 13),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top: 0),
                                                                        child: Text(
                                                                          '${val.workexperienceListData[index].startDate.toString() ?? ''} -'
                                                                              ' ${val.workexperienceListData[index].endDate.toString() == "null" ? 'In Progress' : val.workexperienceListData[index].endDate.toString()}',
                                                                          style:
                                                                          TextStyle(color: isDarkMode == false ? ColorApp.colorblackgalf : Colors.white70, fontSize: 13),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 30),
                                                                  child:
                                                                  Material(
                                                                    elevation:
                                                                    1,
                                                                    shape:
                                                                    RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius
                                                                            .circular(
                                                                            5.0)),
                                                                    color: isDarkMode == false
                                                                        ? ColorApp
                                                                        .colorgray
                                                                        : Color(0xff787777).withOpacity(0.2),
                                                                    child:
                                                                    EffectButton(
                                                                      heightButton: s
                                                                          .height *
                                                                          0.025,
                                                                      widthButton: s
                                                                          .width *
                                                                          0.075,
                                                                      Ontap: () {
                                                                        isExpUpdate =
                                                                        true;
                                                                        GlobalVarData
                                                                            .isExperienceUpdate ==
                                                                            'done';
                                                                        showDialog(
                                                                            context: context,
                                                                            builder: (
                                                                                BuildContext context) {
                                                                              return EditExperience(
                                                                                id: val.workexperienceListData[index]
                                                                                    .id
                                                                                    .toString(),
                                                                                titleData: val.workexperienceListData[index]
                                                                                    .title
                                                                                    .toString(),
                                                                                companyData:val.workexperienceListData[index]
                                                                                    .company
                                                                                    .toString(),
                                                                                descriptionData:val.workexperienceListData[index]
                                                                                    .description
                                                                                    .toString(),
                                                                                dataUpdateStart: val.workexperienceListData[index]
                                                                                    .startDate
                                                                                    .toString(),
                                                                                dataUpdateEnd: val.workexperienceListData[index]
                                                                                    .endDate
                                                                                    .toString(),
                                                                                inprogressData:val.workexperienceListData[index]
                                                                                    .currentlyWork
                                                                                    .toString(),
                                                                              );
                                                                            });
                                                                      },
                                                                      icon: Icons
                                                                          .edit,
                                                                      color: isDarkMode ==
                                                                          false
                                                                          ? Colors
                                                                          .black87
                                                                          : Colors
                                                                          .white,
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
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                        }
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(  top: s.height*0.04,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 0),
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
                      padding:EdgeInsets.only(right:s.width*0.040 ),
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
                                            ApplaySkillScreen( indecator: widget.indecator  + 1,image: widget.image,)));
                              },
                              child: Container(
                                  height: s.height * 0.05,
                                  width: s.width * 0.36,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3)),
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
      ),
    );
  }
}
