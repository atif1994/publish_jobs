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
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_gallery_Controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_skill_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_preferred_job_type_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_qualification_controller.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../profile_model/job_seeker_education_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../profile_screen/profile_add_education_screen.dart';
import '../profile_screen/profile_edit_education_screen.dart';
import 'applay_experience_screen.dart';

class ApplayQualificationScreen extends StatefulWidget {
  String ?image;
  int indecator;
  ApplayQualificationScreen({Key? key,required this.indecator,this.image}) : super(key: key);

  @override
  State<ApplayQualificationScreen> createState() =>
      _ApplayQualificationScreenState();
}

class _ApplayQualificationScreenState extends State<ApplayQualificationScreen> {
  @override
  @override

  void initState() {
    // Timer(Duration(milliseconds: 900), () {
    //   GlobalVarData.educationListFuture =
    //       GetQualificationController().getEducationList();
    // });

    Timer(Duration(milliseconds: 500), () {
      setState(() {});
    });
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetQualificationController>(context, listen: false)
          .educationListData
          .clear();
      Provider.of<GetQualificationController>(context, listen: false)
          .getEducationList();
    });
  }

  bool isEduUpdate = true;

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
      backgroundColor: isDarkMode == true
          ? ColorApp.colornewblack
          : ColorApp.colorbackground,

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
                padding:  EdgeInsets.only(top: 8, left: s.width*0.04, right: s.width*0.04 ,bottom: s.height*0.19),
                child: Column(
                  children: [
                    Material(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      color: isDarkMode == true
                          ? Color(0xff787777).withOpacity(0.2)
                          : ColorApp.colorwhite,
                      child: Consumer<GetQualificationController>(
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
                                                  MainAxisAlignment.spaceBetween,
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
                          if (val.educationListData.isEmpty) {
                            return Material(
                              elevation: 1,
                              color: isDarkMode == true
                                  ? Color(0xff787777).withOpacity(0.2)
                                  : ColorApp.colorwhite,
                              shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppString.education,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : ColorApp.colorblackgalf,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Material(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        color: isDarkMode == false
                                            ? ColorApp
                                            .colorgray
                                            : Color(0xff787777).withOpacity(0.2),
                                        child: EffectButton(
                                          heightButton: s.height * 0.025,
                                          widthButton: s.width * 0.075,
                                          Ontap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddEducation(

                                                          // navigationDeciderId: widget.navigationDeciderId,
                                                        )));
                                          },
                                          icon: Icons.add,
                                          color: isDarkMode == false
                                              ? Colors.black87
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding:
                              const EdgeInsets.fromLTRB(10, 15, 10, 15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppString.education,
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
                                        const EdgeInsets.only(right: 7),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddEducation(

                                                        )));
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
                                  Container(
                                    width: s.width,
                                    child: ListView.builder(
                                        physics: ScrollPhysics(),
                                        itemCount:
                                        val.educationListData.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                                      .school_outlined,
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
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .fromLTRB(
                                                          8, 10, 8, 0),
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
                                                                      val.educationListData[index].degree?.title.toString() ??
                                                                          'no data is shown',
                                                                      style:
                                                                      TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                        fontSize:
                                                                        14,
                                                                        color: isDarkMode == true
                                                                            ? Colors.white
                                                                            : ColorApp.colornewblack,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      val.educationListData[index]
                                                                          .institute
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: isDarkMode == false ? ColorApp.colorblackgalf : Colors.white70,
                                                                          fontSize: 13),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          '${val.educationListData[index].startYear.toString() } -'
                                                                              ' ${val.educationListData[index].endYear.toString() == "null" ? ' In Progress' : val.educationListData[index].endYear.toString()}',
                                                                          style: TextStyle(color: isDarkMode == false ? ColorApp.colorblackgalf : Colors.white70, fontSize: 13),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    0),
                                                                child:
                                                                InkWell(
                                                                  onTap:
                                                                      () {
                                                                    isEduUpdate =
                                                                    true;
                                                                    GlobalVarData.isEducationUpdate ==
                                                                        'done';
                                                                    showDialog(
                                                                        context:
                                                                        context,
                                                                        builder:
                                                                            (BuildContext context) {
                                                                          return EditEducation(
                                                                            id: val.educationListData[index].id.toString(),
                                                                            institueUpdateData: val.educationListData[index].institute.toString(),
                                                                            subjectUpdateData: val.educationListData[index].fieldStudy.toString(),
                                                                            descriptionUpdateData: val.educationListData[index].description.toString(),
                                                                            //  educationList: eduList,
                                                                            degreeId: val.educationListData[index].degreeId.toString(),
                                                                            startDate: val.educationListData[index].startYear.toString(),
                                                                            endDate: val.educationListData[index].endYear.toString() ,
                                                                            degreeStatus: val.educationListData[index].inProgress,
                                                                            degreeData: val.educationListData[index].degree!.title,
                                                                            navigationDeciderId: '1',
                                                                            // navigationDeciderId: widget.navigationDeciderId,
                                                                          );
                                                                        });
                                                                  },
                                                                  child:
                                                                  Material(
                                                                    color: isDarkMode ==
                                                                        false
                                                                        ? ColorApp.colorgray
                                                                        : ColorApp.colorblackgalf.withOpacity(0.2),
                                                                    elevation:
                                                                    0,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius.circular(5)),
                                                                    child:
                                                                    Container(
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: isDarkMode == false
                                                                            ? ColorApp.colorgray
                                                                            : ColorApp.colorblackgalf.withOpacity(0.2),
                                                                        borderRadius:
                                                                        BorderRadius.circular(5),
                                                                      ),
                                                                      height:
                                                                      25,
                                                                      width:
                                                                      33,
                                                                      child:
                                                                      Center(
                                                                        child: Image.asset(
                                                                            width: 17,
                                                                            height: 16,
                                                                            ImangeAssests.eImage,
                                                                            color: isDarkMode == true ? Colors.white : ColorApp.colorblack,
                                                                            fit: BoxFit.fill),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          // Expanded(child: Text("Rawalpidi ,Punjab,Pakistan")),
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
                            );;
                          }
                        }
                      }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: s.height*0.04,
                      ),
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
                            padding: const EdgeInsets.only(right:0),
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
                                                  ApplayExperienceScreen(indecator: widget.indecator  + 1,image: widget.image,)));
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
            ],
          ),
        ),
      ),
    );
  }
}
