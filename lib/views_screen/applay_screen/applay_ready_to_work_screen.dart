import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../App Services/global_vars.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_ready_to_work_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_readyto_work_controller.dart';
import '../../constants/color_app.dart';
import '../../model/job_seeker_ready_to_work_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import 'applay_relocation_screen.dart';
import 'applay_resume_screen.dart';

class ApplayReadyToWorkScreen extends StatefulWidget {
  int indecator;
  String? image;

  ApplayReadyToWorkScreen({Key? key, required this.indecator,this.image})
      : super(key: key);

  @override
  State<ApplayReadyToWorkScreen> createState() =>
      _ApplayReadyToWorkScreenState();
}

class _ApplayReadyToWorkScreenState extends State<ApplayReadyToWorkScreen> {
  @override
  void initState() {
    super.initState();
    print('init value is printed');
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
                      "Are you Available to start immediently",
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
                    bottom: 10,
                    top: 10,
                    left: s.width * 0.029,
                    right: s.width * 0.029),
                child: Material(
                    color: isDarkMode == true
                        ? Color(0xff787777).withOpacity(0.2)
                        : ColorApp.colorwhite,
                    // shape: RoundedRectangleBorder(
                    //     side: BorderSide(
                    //       color: isDarkMode == true
                    //           ? Color(0xff787777).withOpacity(0.2)
                    //           : Colors.black54.withOpacity(0.3),
                    //     ),
                    //     borderRadius: BorderRadius.circular(6)),
                    child: FutureBuilder<JobSeekerReadyToWorkModel>(
                        future: GlobalVarData.pereferredReadyToWorklist,
                        builder: (BuildContext context, snapshot) {
                          bool readywork =
                              (snapshot.data?.checked ?? 'false') == 'false'
                                  ? false
                                  : true;
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
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            13, 10, 0, 5),
                                        child: Text(
                                          "Availability",
                                          style: TextStyle(
                                              color: isDarkMode == true
                                                  ? ColorApp.colorwhite
                                                  : ColorApp.colorblackgalf,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Consumer<PostReadyToWorkController>(
                                    builder: (context, val, child) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            child: readywork == false
                                                ? Text(
                                                    "I'm not available to start immediately",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        color: isDarkMode == true
                                                            ? ColorApp.colorwhite
                                                            : ColorApp.colorblack
                                                                .withOpacity(
                                                                    0.5)),
                                                  )
                                                : Text(
                                                    "I'm  available to start immediately",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        color: isDarkMode == true
                                                            ? ColorApp.colorwhite
                                                            : ColorApp.colorblack
                                                                .withOpacity(
                                                                    0.5)),
                                                  ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 7, right: 13),
                                            child: val.loadingWork == false
                                                ? FlutterSwitch(
                                              height:
                                              s.height *
                                                  0.035,
                                              width:
                                              s.width *
                                                  0.175,
                                              inactiveColor:
                                              ColorApp
                                                  .colorblackgalf,
                                              activeColor:
                                              ColorApp
                                                  .colorprimary,
                                              value:
                                              readywork,
                                              onToggle:
                                                  (value) {
                                                    setState(() {
                                                      val.jobSeekerReadyToWorkAdd(
                                                          value.toString(),
                                                          context);
                                                    });
                                                    Timer(
                                                        Duration(seconds: 1),
                                                            () => setState(() {
                                                          GlobalVarData
                                                              .pereferredReadyToWorklist =
                                                              GetReadyToWorkController()
                                                                  .getJobReadyToWork();
                                                        }));
                                              },
                                            )
                                                : SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: s.height * 0.04,
                    left: s.width * 0.025,
                    right: s.width * 0.025),
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
                                        builder: (context) => ApplayResume(
                                              indecator: widget.indecator + 1,
                                            image: widget.image
                                            )));
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
