import 'dart:convert';

import 'package:firstapp/utils/app_color.dart';
import 'package:firstapp/views_screen/Login_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../App Services/api_services_provider.dart';
import '../../App Services/global_vars.dart';

import '../../Network Controller/Home Get Apis/get_applied_jobs_controller.dart';
import '../../Network Controller/Home Get Apis/get_saved_jobs_controller.dart';
import '../../Network Controller/Home Post Apis/post_add_save_job_controller.dart';
import '../../Network Controller/Home Post Apis/post_remove_save_job_controller.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/applied_job_model.dart';
import '../../model/saved_job_model.dart';
import '../../utils/app_string.dart';

import '../../widgets/appbar_widget.dart';
import '../../widgets/jobscard_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/saved_and_applay.dart';
import '../profile_screen/profile_base_screen.dart';
import 'job_detail.dart';

class JobHistoryScreen extends StatefulWidget {
  final String? tokenCuperTino;
  dynamic? selectedPage;

  JobHistoryScreen({Key? key, this.tokenCuperTino, this.selectedPage})
      : super(key: key);

  @override
  State<JobHistoryScreen> createState() => _JobHistoryScreenState();
}

class _JobHistoryScreenState extends State<JobHistoryScreen> {
  bool isAppbar = true;
  var sessionData;
  var historyCuperCheck;
  ProfileBasicScreen profileBasicScreen = ProfileBasicScreen();
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  List uesrCountryList = [];

  String? profileImage;
  bool iconTrue = false;

  getProfilePersonalInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http.get(
          Uri.parse('https://api.publish.jobs/api/user-general-get'),
          headers: requestHeaders);
      // .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        print(data);
        if (data['user_info'].toString() != 'null') {
          print((data['user_info']['first_name'] ?? 'null name'));
          print((data['user_info']['last_name'] ?? 'null last name'));
        }
        setState(() {
          email = (data['email'] ?? '');
          if (data['user_info'].toString() != 'null') {
            firstName = (data['user_info']['first_name'] ?? '');
            lastName = (data['user_info']['last_name'] ?? '');
          }
          if (data['user_image'].toString() != 'null') {
            profileImage = (data['user_image']['image'] ?? '');
          }
          uesrCountryList = data['country_option'];
          if (uesrCountryList.isNotEmpty) {
            uesrCountryList.add(data['country_option'][0]['title']);
          }
          if (data['user_mobile'].toString() != 'null') {
            mobile = (data['user_mobile']['mobile'] ?? 'null');
          }

          // profileImage = (data['user_image']['image'] ?? '');
          // mobile = (data['user_mobile']['mobile'] ?? 'null');
        });
      } else {
        print('failed persnal info error status code: ' +
            response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString() + ' personalInfo exception');
    }
  }

  checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenCheck = await prefs.getString('tokenProvider').toString();
    setState(() {
      sessionData = tokenCheck;
      print(sessionData.toString() + 'history session token');
      prefs.remove('checkCupertinoSearchAuh');
    });
  }

  checkSessionForCupertino() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String historyCheck =
        await prefs.getString('checkCupertinoSearchAuh').toString();
    setState(() {
      if (historyCheck != 'null')
        Get.off(Bar(
          id: 1,
        ));
    });
  }

  @override
  void initState() {
    // print(profileImage.toString() + "profile image");
    // TODO: implement initState
    super.initState();
    checkSession();
    getProfilePersonalInfo();
    // print(sessionData.toString() + 'session dataaaaaaaaa');
    // print(GlobalVarData.cupertinoSession + 'global dataaaaaaaaa');
    GlobalVarData.appliedFuture = GetAppliedJobsController().getAppliedJobs();
    GlobalVarData.savedFuture = GetSavedJobsController().getSavedJobs();
  }

  Future<bool> _onWillPop() async {
    return await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Bar(
                  id: 0,
                )),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // checkSessionForCupertino();
    //checkSession();
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return GlobalVarData.cupertinoSession.toString() != 'null'
        ?
    WillPopScope(
            onWillPop: _onWillPop,
            child: DefaultTabController(
                initialIndex: widget.selectedPage == null ? 0 : 1,
                length: 2,
                child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: isDarkMode == true
                          ? ColorApp.colornewblack
                          : ColorApp.colorbackground,
                      elevation: 0,
                      actions: [
                        AppBarShow(),
                      ],
                    ),
                    backgroundColor: isDarkMode == true
                        ? ColorApp.colornewblack
                        : ColorApp.colorbackground,
                    body: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: NestedScrollView(
                        floatHeaderSlivers: true,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) => [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            actions: [],
                            backgroundColor: isDarkMode == true
                                ? ColorApp.colornewblack
                                : ColorApp.colorbackground,
                            snap: true,
                            floating: true,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(s.height * 0.00),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    )),
                                    child: TabBar(
                                      labelPadding: EdgeInsets.only(
                                        right: 12,
                                      ),
                                      labelColor: AppColors.colorpurpal,
                                      isScrollable: true,
                                      // add this property
                                      unselectedLabelColor: isDarkMode == false
                                          ? ColorApp.colorblackgalf
                                          : ColorApp.colorwhite
                                              .withOpacity(0.8),
                                      indicatorColor: AppColors.colorpurpal,
                                      indicatorPadding: EdgeInsets.only(
                                        right: 2,
                                      ),
                                      indicatorSize: TabBarIndicatorSize.tab,

                                      // TABS
                                      tabs: [
                                        Tab(
                                          text: AppString.jobHistoryApplay,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Tab(
                                              text: AppString.jobHistorySave),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        body: TabBarView(
                          children: [widgetApplied(), widgetSaved()],
                        ),
                      ),
                    ))),
          )
        : Scaffold(
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
                SizedBox(
                  height: s.height * 0.029,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: s.width * 0.1, right: s.width * 0.19),
                  child: Container(
                    height: s.height * 0.4,
                    width: s.width,
                    child: Image.asset(ImangeAssests.pic2ImageOnBoarding,
                        fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.019,
                ),
                Text(
                  "A Little Atemp Here",
                  style: TextStyle(
                    color: isDarkMode == true
                        ? AppColors.colorwhite
                        : AppColors.colorblack,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(
                  height: s.height * 0.019,
                ),
                Text(
                  "Please Login to see History",
                  style: TextStyle(
                    color: isDarkMode == true
                        ? AppColors.colorwhite
                        : AppColors.colorblack,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(
                  height: s.height * 0.019,
                ),
                SubmitButton(
                  textColor: isDarkMode == true
                      ? AppColors.colorwhite
                      : AppColors.colorwhite,
                  backGroundColor: ColorApp.colorprimary,
                  borderRadius: BorderRadius.circular(22),
                  widthButton: s.width * 0.699,
                  heightButton: s.height * 0.054,
                  textButton: 'Login Now',
                  onPressed: () {
                    Navigator.of(context ,rootNavigator: true).push(MaterialPageRoute(builder: (context) => LogInScreen(
                      checkNav: 'history',
                    )));
                  },
                )
              ],
            ),
          );
  }

  Widget widgetSaved() {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return FutureBuilder<SavedJobModel>(
        future: GlobalVarData.savedFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.data!.isEmpty) {
              return Center(
                child: Text(
                  "You have not saved any jobs",
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                ),
              );
            }
            else {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    // var jobData;
                    // var jobDataWithSession;
                    // List isSaved = [];
                    // String jobid;
                    if (kDebugMode) {
                      print(snapshot.data!.data.toString() + "show list");
                    }
                    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                    // DateTime dt = DateTime.parse(
                    //     snapshot.data!.data![0].createdAt.toString());
                    final date2 = DateTime.now();
                    // final appliedDays = date2.difference(dt).inDays;
                    // String appliedDate = dateFormat.format(dt).toString();
                    String? image = snapshot
                        .data!.data![index].business?.businessImage?.image
                        .toString();

                    String? currencyName = snapshot
                        .data?.data![index]?.salary!.currency!.currencyCode
                        .toString();
                    String? currencystart =
                        snapshot.data?.data![index]?.salary!.minimum.toString();
                    String? currencymaximam =
                        snapshot.data?.data![index]?.salary!.maximum.toString();
                    String? salaryType = snapshot
                        .data?.data![index]?.salary!.salarytype!.title
                        .toString();
                    String? daysAgo=snapshot.data!.data?[index].jobStatus![index].daysSinceActive.toString();
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                        child: JobsCard(

                          // heartColor: isSaved.isEmpty? isDarkMode == true ? Colors.grey : Colors.grey:AppColors.colorprimary,
                          // iconHeart: isSaved.isEmpty ? Icons.favorite_border : Icons.favorite ,
                          buttonColor: ColorApp.colorprimary,
                          Ontap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString("jobName",
                                snapshot.data!.data![index].title.toString());
                            await prefs.setString(
                                "companyName",
                                snapshot.data!.data![index].business!.name
                                    .toString());
                            await prefs.setString(
                                "cityName",
                                snapshot
                                    .data!.data![index].cityOptions![0].title
                                    .toString());
                            await prefs.setString("jobDescription",
                                ("${snapshot.data?.data![index]?.jobtypeOptions![0].title.toString()}"));
                            await prefs.setString(
                                "salaryShow",
                                currencyName! +
                                    " " +
                                    currencystart! +
                                    "-" +
                                    currencymaximam! +
                                    "/ " +
                                    salaryType!);
                            await prefs.setString("postedTime", '1 hour ago');
                            await prefs.setString(
                                "imageUrl",
                                image.toString() != 'null'
                                    ? 'https://api.publish.jobs/pjcloud/Business/' +
                                        image.toString()
                                    : 'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg');

                            Navigator.of(context, rootNavigator: false).push(
                                MaterialPageRoute(
                                    maintainState: true,
                                    builder: (context) => JobDetail(
                                      daysAgo:snapshot.data!.data?[index].jobStatus![index].daysSinceActive.toString() ,
                                      uUid: '',
                                        // uUid: snapshot.data!.data![index].uuid
                                        //     .toString(),
                                        id: snapshot.data!.data![index].id
                                            .toString(),
                                        title: snapshot.data!.data![index].title
                                            .toString(),
                                        bussinessName: snapshot
                                            .data!.data![index].business!.name
                                            .toString())));
                          },
                          ontapsave: () {
                            PostRemoveSaveJobController()
                                .jobseekerRemoveSaveJob(
                                snapshot.data!.data![index].id
                                    .toString(),
                                context);
                          Future.delayed(Duration(seconds: 2),(){
                            setState(() {
                              GlobalVarData.savedFuture =
                                  GetSavedJobsController().getSavedJobs();
                            });
                          });
                          },
                          iconHeart: Icons.favorite,
                          heartColor:  isDarkMode == true
                              ? Colors.grey
                               :AppColors.colorprimary,

                          hoursShow:daysAgo.toString() +"days ago",
                          iconPerson: Icon(
                            Icons.person_outline,
                            color: Colors.deepPurple,
                          ),

                          shareColor: isDarkMode == true
                              ? ColorApp.colorwhite
                              : ColorApp.colorblackgalf,
                          ontapshare: () async {
                            dynamic name =
                                snapshot.data!.data![index].title.toString();
                            final result =
                                name.replaceAll(RegExp('[^A-Za-z0-9]'), '-');
                            name.trim();
                            print(name.toString() + "Job name");
                            final url ='';
                              //  '${'https://publish.jobs/${result}/${snapshot.data?.data![index].uuid.toString()}'}';

                            await Share.share('${url}');
                          },
                          iconShare: Icons.share_outlined,
                          fullTime: snapshot
                              .data?.data![index]?.jobtypeOptions![0].title
                              .toString(),
                          buttonText: "Applay",

                          salaryShow: currencyName! +
                              " " +
                              currencystart! +
                              "-" +
                              currencymaximam! +
                              "/ " +
                              salaryType!,
                          image: image.toString() != 'null'
                              ? NetworkImage(
                                  'https://api.publish.jobs/pjcloud/Business/' +
                                      image!)
                              : NetworkImage(
                                  'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg'),
                          cityName: snapshot
                              .data!.data![index].cityOptions![0].title
                              .toString(),
                          JobName: snapshot.data!.data![index].title.toString(),
                          companyName: snapshot
                              .data!.data![index].business!.name
                              .toString(),
                        )

                        // SavedAndApplay(
                        //   jobStatusColor: snapshot.data!.data![index]
                        //               .jobsApplied![0].pivot!.status
                        //               .toString() ==
                        //           "applied"
                        //       ? ColorApp.colorgreen
                        //       : ColorApp.colororange,
                        //   iconPerson: null,
                        //   buttonbgColor: ColorApp.colorblackgalf,
                        //   dateShow: appliedDays.toString() + ' Days Ago',
                        //   hoursShow: snapshot
                        //       .data!.data![index].jobsApplied![0].pivot!.status
                        //       .toString(),
                        //   image: image.toString() != 'null'
                        //       ? NetworkImage(
                        //           'https://api.publish.jobs/pjcloud/Business/' +
                        //               image!)
                        //       : NetworkImage(
                        //           'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg'),
                        //   cityName: snapshot
                        //       .data!.data![index].cityOptions![0].title
                        //       .toString(),
                        //   JobName: snapshot.data!.data![index].title.toString(),
                        //   companyName:
                        //       snapshot.data!.data![index].business!.name.toString(),
                        //   buttonText: "Applied",
                        //   Ontap: () {},
                        // ),
                        );
                  },
                );

            }
          }
        });
  }

  Widget widgetApplied() {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return FutureBuilder<AppliedJobModel>(
        future: GlobalVarData.appliedFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Text('No internet......'),
            );
          } else {
            if (snapshot.data!.data!.isEmpty) {
              return Center(
                child: Text(
                  "You have not applied on any jobs",
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  List isSaved = [];
                  print(snapshot.data!.data.toString() + "show list");
                  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                  // DateTime dt = DateTime.parse(
                  //     snapshot.data!.data![0].createdAt.toString());
                  final date2 = DateTime.now();
                  // final appliedDays = date2.difference(dt).inDays;
                  // String appliedDate = dateFormat.format(dt).toString();
                  String? image = snapshot
                      .data!.data![index].business?.businessImage?.image
                      .toString();
                  String? currencyName = snapshot
                      .data?.data![index]?.salary!.currency!.currencyCode
                      .toString();
                  String? currencystart =
                      snapshot.data?.data![index]?.salary!.minimum.toString();
                  String? currencymaximam =
                      snapshot.data?.data![index]?.salary!.maximum.toString();
                  String? salaryType = snapshot
                      .data?.data![index]?.salary!.salarytype!.title
                      .toString();
                  String? daysAgo=snapshot.data!.data?[index].jobStatus![index].daysSinceActive.toString();
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                      child: JobsCard(
                        buttonColor: Colors.grey,
                        ontapsave: () {
                          print('before 2222222222222');
                          print(PostAddSaveJobController().jobseekerAddSaveJob(
                              snapshot.data!.data![index].id.toString(),
                              context));
                          print('after222222222');
                          if (PostAddSaveJobController().jobseekerAddSaveJob(
                                  snapshot.data!.data![index].id.toString(),
                                  context) ==
                              "null") {
                            setState(() {
                              PostAddSaveJobController()
                                  .jobseekerAddSaveJob(snapshot.data!.data![index].id.toString(), context) == [];
                              if (kDebugMode) {
                                print("data saved");
                              }
                            });
                          } else {
                            if (kDebugMode) {
                              print("failed");
                            }
                          }
                        },
                        hoursShow: daysAgo.toString() +"days ago",
                        iconPerson: Icon(
                          Icons.person_outline,
                          color: Colors.deepPurple,
                        ),
                        shareColor: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblackgalf,
                        ontapshare: () async {
                          dynamic name =
                              snapshot.data!.data![index].title.toString();
                          final result =
                              name.replaceAll(RegExp('[^A-Za-z0-9]'), '-');
                          name.trim();
                          print(name.toString() + "Job name");
                          final url ='';
                             // '${'https://publish.jobs/${result}/${snapshot.data?.data![index].uuid.toString()}'}';

                          await Share.share('${url}');
                        },
                        iconShare: Icons.share_outlined,
                        fullTime: snapshot
                            .data?.data![index]?.jobtypeOptions![0].title
                            .toString(),
                        buttonText: "Applied",
                        salaryShow: currencyName! +
                            " " +
                            currencystart! +
                            "-" +
                            currencymaximam! +
                            "/ " +
                            salaryType!,
                        image: image.toString() != 'null'
                            ? NetworkImage(
                                'https://api.publish.jobs/pjcloud/Business/' +
                                    image!)
                            : NetworkImage(
                                'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg'),
                        cityName: snapshot
                            .data!.data![index].cityOptions![0].title
                            .toString(),
                        JobName: snapshot.data!.data![index].title.toString(),
                        companyName: snapshot.data!.data![index].business!.name
                            .toString(),
                      )

                      // SavedAndApplay(
                      //   jobStatusColor: snapshot.data!.data![index]
                      //               .jobsApplied![0].pivot!.status
                      //               .toString() ==
                      //           "applied"
                      //       ? ColorApp.colorgreen
                      //       : ColorApp.colororange,
                      //   iconPerson: null,
                      //   buttonbgColor: ColorApp.colorblackgalf,
                      //   dateShow: appliedDays.toString() + ' Days Ago',
                      //   hoursShow: snapshot
                      //       .data!.data![index].jobsApplied![0].pivot!.status
                      //       .toString(),
                      //   image: image.toString() != 'null'
                      //       ? NetworkImage(
                      //           'https://api.publish.jobs/pjcloud/Business/' +
                      //               image!)
                      //       : NetworkImage(
                      //           'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg'),
                      //   cityName: snapshot
                      //       .data!.data![index].cityOptions![0].title
                      //       .toString(),
                      //   JobName: snapshot.data!.data![index].title.toString(),
                      //   companyName:
                      //       snapshot.data!.data![index].business!.name.toString(),
                      //   buttonText: "Applied",
                      //   Ontap: () {},
                      // ),
                      );
                },
              );
            }
          }
        });
  }
}
