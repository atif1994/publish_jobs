import 'package:firstapp/component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import 'package:firstapp/views_screen/Login_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:firstapp/App%20Services/api_services_provider.dart';
import 'package:html/parser.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Network Controller/Home Get Apis/get_company_list_controller.dart';
import '../../Network Controller/Home Post Apis/post_add_report_job_controller.dart';
import '../../Network Controller/Home Post Apis/post_add_save_job_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_reportoption_controller.dart';
import '../../api/api.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/all_company_model.dart';
import '../../model/job_ReportOption_Web_model.dart';
import '../../utils/app_color.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../applay_screen/applay_person_info_screen.dart';
import 'company_detail.dart';

class JobDetail extends StatefulWidget {
  final String uUid;
  final String id;
  final String title;
  final String bussinessName;
  final String ?image;
  final String? daysAgo;

   JobDetail({
    Key? key,
    required this.uUid,
    required this.id,
   required this.title,
     required this.bussinessName,
     this.image,
     this.daysAgo,
  }) : super(key: key);

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> with TickerProviderStateMixin {
//...
  var data;
  var jobDetailApi;
  final reportDescription = TextEditingController();
  String? tokenHeader;
  String? checkReport;
  int? checked = 0;
  bool isChecked = false;
  String? jobsDescription;
  String? companyDetails;
  String? idAlljobs;
  String? jobTitle;
  String? jobName;
  String? jobImage;
  List<dynamic> appliedJobs = [];

  jobDetailWithToken() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String tokenHeader = await pref.getString('tokenProvider').toString();
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer ' + tokenHeader
      };
      String url = "https://api.publish.jobs/api/job-detail?id=${widget.id}";
      Response response = await post(Uri.parse(url),
          body: {
            'id': widget.id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {


        setState(() {
          data = jsonDecode(response.body.toString());
          final htmlStringData = data['job_description']['description'];
          final document = parse(htmlStringData);
          jobsDescription = parse(document.body!.text).documentElement!.text;
          final htmlStringName = data['business']['name'];
          final jobNamep = parse(htmlStringName);
          jobName = parse(jobNamep.body!.text).documentElement!.text;
          final htmlStringData2 =
              data['business']['business_details']['details'];
          final jobDetailId = data['business']['uuid'];
          final userid = parse(jobDetailId);
          final jobsDescription2 = parse(htmlStringData2);
          companyDetails =
              parse(jobsDescription2.body!.text).documentElement!.text;
          idAlljobs = parse(userid.body!.text).documentElement!.text;
          final imageData = data['business']['business_image']['image'];
          final userimage = parse(imageData);
          jobImage = parse(userimage.body!.text).documentElement!.text;
          if (tokenHeader.toString() != 'null') {



            appliedJobs = data['jobs_applied'];

          }
        });
        return data;

      } else {

        return data;
      }
    } catch (e) {

      return data;
    }
  }

  jobDetail() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String tokenHeader = await pref.getString('tokenProvider').toString();
      // Map<String, String> requestHeaders = {
      //   'Authorization': 'Bearer ' + tokenHeader
      // };
      String url = "https://api.publish.jobs/api/job-detail?id=${widget.id}";
      Response response = await post(
        Uri.parse(url),
        body: {
          'id': widget.id,
        },
        // headers: requestHeaders
      );
      if (response.statusCode == 200) {


        setState(() {
          data = jsonDecode(response.body.toString());
          final htmlStringData = data['job_description']['description'];
          final document = parse(htmlStringData);
          jobsDescription = parse(document.body!.text).documentElement!.text;

        });
        return data;

      } else {

        return data;
      }
    } catch (e) {

      return data;
    }
  }

  @override
  void initState() {
print(widget.daysAgo.toString()+"ssssssssssss");
    _tabController = new TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
    getAllCompanyFuture = GetCompanyListController().getCompanyList(1,""
        // companySearchData
        // companyData.toString()=='null'?'':companyData.toString()
        );
    checkIfLoggedin();

    if (kDebugMode) {

    }
  }

  bool isAppbar = true;

  // // List<JobDetailModel> jobDetailData=[];

  checkIfLoggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tokenHeader = await pref.getString('tokenProvider').toString();
    setState(() {
      tokenHeader = tokenHeader;
    });
    if (tokenHeader.toString() != 'null') {
      jobDetailApi = jobDetailWithToken();
    } else {
      jobDetailApi = jobDetail();
    }
  }

  bool description = true;
  bool aboutCompany = true;
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  Future<AllCompanyListModel>? getAllCompanyFuture;

  @override
  Widget build(BuildContext context) {
    print(widget.daysAgo.toString()+"ssssssssssss");
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    DataServices dataServices = DataServices();
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode == true
            ? ColorApp.colornewblack
            : ColorApp.colorbackground,

        leading:   Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Material(
            color: isDarkMode == true
                ? ColorApp.colorblackgalf.withOpacity(0.5)
                : ColorApp.colorwhite,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 6, top: 3, bottom: 3),
              child: Icon(Icons.arrow_back_ios,
                  color: isDarkMode == true
                      ? Colors.white
                      : ColorApp.colorblackgalf),
            ),
          ),
      ),
        ),





        actions: [

          Container(
            color: isDarkMode == true
                ? ColorApp.colornewblack
                : ColorApp.colorbackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8,top: 12,bottom: 12,right: 2),
                      child: Material(
                        color: isDarkMode == true
                            ? ColorApp.colorblackgalf.withOpacity(0.5)
                            : ColorApp.colorwhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 1,
                        child: GestureDetector(
                          onTap: () {
                            showAlertDialog(context, widget.id,
                                widget.title, widget.bussinessName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Center(
                                child: Icon(Icons.favorite_border,
                                    color: isDarkMode == true
                                        ? Colors.white
                                        : ColorApp.colorblackgalf)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 8,top: 12,bottom: 10,right: s.width*0.04),
                      child: GestureDetector(
                        onTap: () async {
                          dynamic name = widget.title.toString();
                          final result =
                          name.replaceAll(RegExp('[^A-Za-z0-9]'), '-');
                          name.trim();

                          final url =
                              '${'https://publish.jobs/${result}/${widget.uUid.toString()}'}';

                          await Share.share('${url}');
                        },
                        child: Material(
                          color: isDarkMode == true
                              ? ColorApp.colorblackgalf.withOpacity(0.5)
                              : ColorApp.colorwhite,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Center(
                                child: Icon(
                                  Icons.share_outlined,
                                  color: isDarkMode == true
                                      ? Colors.white
                                      : ColorApp.colorblackgalf,
                                )),
                          ),
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

      backgroundColor: isDarkMode == true
          ? ColorApp.colornewblack
          : ColorApp.colorbackground,
      body: SingleChildScrollView(

        child: Column(
          children: [

            Column(
              children: [
                FutureBuilder(
                    future: jobDetailApi,
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {

                        return Center(
                            child: Text(snapshot.hasError.toString()));
                      } else if (snapshot.hasData) {
                        return Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: s.width * 0.03,
                                      right: s.width * 0.03,
                                      top: 12),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    elevation: 1,
                                    color: isDarkMode == true
                                        ? ColorApp.colorblackgalf
                                            .withOpacity(0.5)
                                        : ColorApp.colorwhite,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: s.width * 0.07),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: s.height * 0.07,
                                              width: s.width * 0.18,
                                              child: Center(
                                                child: Image.asset(
                                                    ImangeAssests.otsImage),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: s.width * 0.05),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data?['title'].toString() ??
                                                        '',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      color: isDarkMode == true
                                                          ? ColorApp.colorwhite
                                                          : ColorApp.colorblack,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        color: isDarkMode ==
                                                                true
                                                            ? ColorApp
                                                                .colorprimary
                                                            : ColorApp
                                                                .colorprimary,
                                                        Icons
                                                            .account_balance_outlined,
                                                        size: 16,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4),
                                                          child: Text(
                                                            data?['business']
                                                                        ["name"]
                                                                    .toString() ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? ColorApp
                                                                        .colorprimary
                                                                    : ColorApp
                                                                        .colorprimary),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: s.width * 0.03,
                                      right: s.width * 0.03,
                                      top: 12),
                                  child: Material(
                                    color: isDarkMode == true
                                        ? ColorApp.colorblackgalf
                                            .withOpacity(0.5)
                                        : ColorApp.colorwhite,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 15, 10),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Icon(
                                                  Icons.location_on_outlined,
                                                  color: isDarkMode == true
                                                      ? ColorApp.colorwhite
                                                      : Colors.grey,
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: s.width * 0.03),
                                                  child: Text(
                                                    "show list",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            isDarkMode == true
                                                                ? ColorApp
                                                                    .colorwhite
                                                                : Colors.grey),
                                                  ),
                                                ),
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
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 10),
                                              child: Icon(
                                                Icons.local_atm,
                                                color: isDarkMode == true
                                                    ? ColorApp.colorwhite
                                                    : Colors.grey,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                ((data?['salary']['currency'][
                                                                'currency_code']
                                                            .toString()) ??
                                                        '') +
                                                    ((data?['salary']['minimum']
                                                            .toString()) ??
                                                        ''),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                ' - ',
                                                style: TextStyle(
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : ColorApp.colorblack),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                ((data?['salary']['maximum']
                                                            .toString()) ??
                                                        '') +
                                                    '' +
                                                    '/' +
                                                    ((data?['salary'][
                                                                    'salary_type']
                                                                ['title']
                                                            .toString()) ??
                                                        ''),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 10),
                                              child: Icon(
                                                Icons.access_time,
                                                color: isDarkMode == true
                                                    ? ColorApp.colorwhite
                                                    : Colors.grey,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                (data?["jobtype_options"][0]
                                                            ["title"]
                                                        .toString() ??
                                                    ''),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 10),
                                              child: Icon(
                                                Icons.library_books_sharp,
                                                color: isDarkMode == true
                                                    ? ColorApp.colorwhite
                                                    : Colors.grey,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                (data?["urgent_hiring"]
                                                        .toString() ??
                                                    ''),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : ColorApp.colorblack),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 10),
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: 'Posted :',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: isDarkMode == true
                                                                ? ColorApp
                                                                    .colorwhite
                                                                : ColorApp
                                                                    .colorblack)),
                                                    TextSpan(
                                                      text: widget.daysAgo.toString()+ "days ago",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorApp
                                                            .colorprimary,
                                                        fontSize: 12,
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 10, 10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  SharedPreferences pref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  tokenHeader = await pref
                                                      .getString(
                                                          'tokenProvider')
                                                      .toString();
                                                  setState(() {
                                                    tokenHeader;
                                                  });
                                                  if (tokenHeader == 'null') {
                                                    showAlertDialogLogInFirst(
                                                        context,
                                                        "first to report this job..!");
                                                  } else {
                                                    showAlertDialogReport(
                                                        context,
                                                        widget.id,
                                                        widget.title,
                                                        widget.bussinessName);
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Material(
                                                        color:
                                                            ColorApp.colorwhite,
                                                        elevation: 1,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        child: Container(
                                                          height:
                                                              s.height * 0.029,
                                                          width:
                                                              s.width * 0.080,
                                                          child: Icon(
                                                            Icons.flag_outlined,
                                                            color: ColorApp
                                                                .colorblackgalf,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    tokenHeader == 'null'
                                                        ? Text("Report Jobs",
                                                            style: TextStyle(
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? ColorApp
                                                                      .colorwhite
                                                                  : Colors.grey,
                                                              fontSize: 12,
                                                            ))
                                                        : (Text(
                                                            'report pending'))
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        if (appliedJobs.isEmpty) ...[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12, bottom: 12),
                                            child: SubmitButton(
                                                textColor: isDarkMode == true
                                                    ? AppColors.colorwhite
                                                    : AppColors.colorwhite,
                                                backGroundColor:
                                                    ColorApp.colorprimary,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                icon: Icon(
                                                  Icons.arrow_forward,
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite
                                                      : AppColors.colorwhite,
                                                ),
                                                widthButton: s.width * 0.73,
                                                heightButton: s.height * 0.040,
                                                textButton: "Apply Now",
                                                onPressed: () async {
                                                  SharedPreferences pref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  tokenHeader = await pref
                                                      .getString(
                                                          'tokenProvider')
                                                      .toString();
                                                  setState(() {
                                                    tokenHeader;
                                                  });
                                                  if (tokenHeader.toString() ==
                                                      'null') {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .push(MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    LogInScreen(
                                                                      checkNav:
                                                                          'job detail',
                                                                    )));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ApplayPersonalInfoScreen(
                                                                  image: widget.image,
                                                                )));
                                                  }
                                                }),
                                          )
                                        ] else if (appliedJobs.length == 1) ...[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12, bottom: 12),
                                            child: SubmitButton(
                                                textColor: isDarkMode == true
                                                    ? AppColors.colorwhite
                                                    : AppColors.colorwhite,
                                                backGroundColor: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                widthButton: s.width * 0.73,
                                                heightButton: s.height * 0.040,
                                                textButton: "Applied",
                                                onPressed: () async {}),
                                          )
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: s.height,
                              child: Column(
                                children: [
                                  TabBar(
                                    unselectedLabelColor: isDarkMode == true
                                        ? ColorApp.colorwhite
                                        : Colors.black,
                                    labelColor: AppColors.colorprimary,
                                    tabs: [
                                      Row(
                                        children: [
                                          Tab(
                                            icon: Row(
                                              children: [
                                                Icon(Icons.edit_calendar),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6),
                                                  child:
                                                      Text(" Jobs Description"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Tab(
                                        icon: Row(
                                          children: [
                                            Icon(
                                              Icons.account_balance_outlined,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Text(
                                                  ("About") +
                                                      " " +
                                                      (data?['business']["name"]
                                                              .toString() ??
                                                          ''),
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                    controller: _tabController,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10),
                                                    child: Text(
                                                        jobsDescription
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color:
                                                                isDarkMode ==
                                                                        true
                                                                    ? ColorApp
                                                                        .colorwhite
                                                                    : Colors
                                                                        .grey)),
                                                  ),
                                                  // if ((qualificationOption
                                                  //     ?.length
                                                  //     .toString() ??
                                                  //     '0') !=
                                                  //     '0') ...[
                                                  //   Column(
                                                  //     crossAxisAlignment:
                                                  //     CrossAxisAlignment
                                                  //         .start,
                                                  //     children: [
                                                  //       Padding(
                                                  //         padding: const EdgeInsets
                                                  //             .only(
                                                  //             top: 10),
                                                  //         child: Row(
                                                  //           children: [
                                                  //             Material(
                                                  //               color: ColorApp
                                                  //                   .colorwhite,
                                                  //               elevation:
                                                  //               1,
                                                  //               shape: RoundedRectangleBorder(
                                                  //                   borderRadius:
                                                  //                   BorderRadius
                                                  //                       .circular(
                                                  //                       5.0)),
                                                  //               child:
                                                  //               Container(
                                                  //                 height:
                                                  //                 s
                                                  //                     .height *
                                                  //                     0.032,
                                                  //                 width:
                                                  //                 s
                                                  //                     .width *
                                                  //                     0.081,
                                                  //                 child:
                                                  //                 Icon(
                                                  //                   Icons
                                                  //                       .school_outlined,
                                                  //                   color:
                                                  //                   ColorApp
                                                  //                       .colorblackgalf,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             Padding(
                                                  //               padding:
                                                  //               const EdgeInsets
                                                  //                   .only(
                                                  //                   left: 10),
                                                  //               child: Text(
                                                  //                   "Qualificaitons",
                                                  //                   style:
                                                  //                   TextStyle(
                                                  //                     color: isDarkMode ==
                                                  //                         true
                                                  //                         ? AppColors
                                                  //                         .colorwhite
                                                  //                         : Colors
                                                  //                         .black,
                                                  //                     fontWeight: FontWeight
                                                  //                         .w700,
                                                  //                     fontFamily: "Montserrat",
                                                  //                   )),
                                                  //             )
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //       Padding(
                                                  //         padding: const EdgeInsets
                                                  //             .only(
                                                  //             top: 5),
                                                  //         child: Text(
                                                  //           "Maximum Education",
                                                  //           style: TextStyle(
                                                  //               color: ColorApp
                                                  //                   .colorprimary,
                                                  //               fontSize:
                                                  //               12),
                                                  //         ),
                                                  //       ),
                                                  //       Row(
                                                  //         children: [
                                                  //           Text(
                                                  //             "\u2022",
                                                  //             style: TextStyle(
                                                  //                 fontSize:
                                                  //                 30,
                                                  //                 color: isDarkMode ==
                                                  //                     true
                                                  //                     ? AppColors
                                                  //                     .colorwhite
                                                  //                     : AppColors
                                                  //                     .colorblack),
                                                  //           ),
                                                  //           Padding(
                                                  //             padding: const EdgeInsets
                                                  //                 .only(
                                                  //                 left:
                                                  //                 5),
                                                  //             child: Text(
                                                  //                 data?[index]["max_degree_options"][index]["title"]
                                                  //                     .toString() ??
                                                  //                     '',
                                                  //                 style:
                                                  //                 TextStyle(
                                                  //                   color: isDarkMode ==
                                                  //                       true
                                                  //                       ? AppColors
                                                  //                       .colorwhite
                                                  //                       : ColorApp
                                                  //                       .colorblackgalf,
                                                  //                   fontWeight:
                                                  //                   FontWeight
                                                  //                       .w500,
                                                  //                   fontFamily:
                                                  //                   "Montserrat",
                                                  //                 )),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //       Text(
                                                  //         "Minimum Education",
                                                  //         style: TextStyle(
                                                  //             color: ColorApp
                                                  //                 .colorprimary,
                                                  //             fontSize:
                                                  //             12),
                                                  //       ),
                                                  //       Row(
                                                  //         children: [
                                                  //           Text(
                                                  //             "\u2022",
                                                  //             style: TextStyle(
                                                  //                 fontSize:
                                                  //                 30,
                                                  //                 color: isDarkMode ==
                                                  //                     true
                                                  //                     ? AppColors
                                                  //                     .colorwhite
                                                  //                     : AppColors
                                                  //                     .colorblack),
                                                  //           ),
                                                  //           Padding(
                                                  //             padding: const EdgeInsets
                                                  //                 .only(
                                                  //                 left:
                                                  //                 5),
                                                  //             child: Text(
                                                  //                 data?[index]["degree_options"][index]["title"]
                                                  //                     .toString() ??
                                                  //                     '',
                                                  //                 style:
                                                  //                 TextStyle(
                                                  //                   color: isDarkMode ==
                                                  //                       true
                                                  //                       ? AppColors
                                                  //                       .colorwhite
                                                  //                       : ColorApp
                                                  //                       .colorblackgalf,
                                                  //                   fontWeight:
                                                  //                   FontWeight
                                                  //                       .w500,
                                                  //                   fontFamily:
                                                  //                   "Montserrat",
                                                  //                 )),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ],
                                                  //
                                                  // if ((careerLvelCheck
                                                  //     ?.length
                                                  //     .toString() ??
                                                  //     '0') !=
                                                  //     '0') ...[
                                                  //   Column(
                                                  //     children: [
                                                  //       Row(
                                                  //         children: [
                                                  //           Material(
                                                  //             color: ColorApp
                                                  //                 .colorwhite,
                                                  //             elevation:
                                                  //             1,
                                                  //             shape: RoundedRectangleBorder(
                                                  //                 borderRadius:
                                                  //                 BorderRadius
                                                  //                     .circular(
                                                  //                     5.0)),
                                                  //             child:
                                                  //             Container(
                                                  //               height: s
                                                  //                   .height *
                                                  //                   0.032,
                                                  //               width: s
                                                  //                   .width *
                                                  //                   0.081,
                                                  //               child:
                                                  //               Icon(
                                                  //                 Icons
                                                  //                     .account_balance,
                                                  //                 color:
                                                  //                 ColorApp
                                                  //                     .colorblackgalf,
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //           Padding(
                                                  //             padding: const EdgeInsets
                                                  //                 .only(
                                                  //                 left:
                                                  //                 10),
                                                  //             child: Text(
                                                  //                 "Experiencied Required",
                                                  //                 style:
                                                  //                 TextStyle(
                                                  //                   color: isDarkMode ==
                                                  //                       true
                                                  //                       ? AppColors
                                                  //                       .colorwhite
                                                  //                       : Colors
                                                  //                       .black,
                                                  //                   fontWeight:
                                                  //                   FontWeight
                                                  //                       .w600,
                                                  //                   fontFamily:
                                                  //                   "Montserrat",
                                                  //                 )),
                                                  //           )
                                                  //         ],
                                                  //       ),
                                                  //       Row(
                                                  //         crossAxisAlignment:
                                                  //         CrossAxisAlignment
                                                  //             .start,
                                                  //         children: [
                                                  //           Row(
                                                  //             children: [
                                                  //               Text(
                                                  //                 "\u2022",
                                                  //                 style: TextStyle(
                                                  //                     fontSize: 30,
                                                  //                     color: isDarkMode ==
                                                  //                         true
                                                  //                         ? AppColors
                                                  //                         .colorwhite
                                                  //                         : AppColors
                                                  //                         .colorblack),
                                                  //               ),
                                                  //               Padding(
                                                  //                 padding:
                                                  //                 const EdgeInsets
                                                  //                     .only(
                                                  //                     left: 5),
                                                  //                 child: Text(
                                                  //                     data?[index]['careerlevel_options'][0]['title'],
                                                  //                     style: TextStyle(
                                                  //                       color: isDarkMode ==
                                                  //                           true
                                                  //                           ? AppColors
                                                  //                           .colorwhite
                                                  //                           : ColorApp
                                                  //                           .colorblackgalf,
                                                  //                       fontWeight: FontWeight
                                                  //                           .w500,
                                                  //                       fontFamily: "Montserrat",
                                                  //                     )),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ],
                                                  // if ((genderOption
                                                  //     ?.length
                                                  //     .toString() ??
                                                  //     '0') !=
                                                  //     '0') ...[
                                                  //   Column(
                                                  //     children: [
                                                  //       Padding(
                                                  //         padding: const EdgeInsets
                                                  //             .only(
                                                  //             top: 10),
                                                  //         child: Row(
                                                  //           children: [
                                                  //             Material(
                                                  //               color: ColorApp
                                                  //                   .colorwhite,
                                                  //               elevation:
                                                  //               1,
                                                  //               shape: RoundedRectangleBorder(
                                                  //                   borderRadius:
                                                  //                   BorderRadius
                                                  //                       .circular(
                                                  //                       5.0)),
                                                  //               child:
                                                  //               Container(
                                                  //                 height:
                                                  //                 s
                                                  //                     .height *
                                                  //                     0.032,
                                                  //                 width:
                                                  //                 s
                                                  //                     .width *
                                                  //                     0.081,
                                                  //                 child:
                                                  //                 Icon(
                                                  //                   Icons
                                                  //                       .person_add_alt,
                                                  //                   color:
                                                  //                   ColorApp
                                                  //                       .colorblackgalf,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             Padding(
                                                  //               padding:
                                                  //               const EdgeInsets
                                                  //                   .only(
                                                  //                   left: 10),
                                                  //               child: Text(
                                                  //                   "Hiring Candidates",
                                                  //                   style:
                                                  //                   TextStyle(
                                                  //                     color: isDarkMode ==
                                                  //                         true
                                                  //                         ? AppColors
                                                  //                         .colorwhite
                                                  //                         : Colors
                                                  //                         .black,
                                                  //                     fontWeight: FontWeight
                                                  //                         .w600,
                                                  //                     fontFamily: "Montserrat",
                                                  //                   )),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //       Row(
                                                  //         crossAxisAlignment:
                                                  //         CrossAxisAlignment
                                                  //             .start,
                                                  //         children: [
                                                  //           Row(
                                                  //             children: [
                                                  //               Text(
                                                  //                 "\u2022",
                                                  //                 style: TextStyle(
                                                  //                     fontSize: 30,
                                                  //                     color: isDarkMode ==
                                                  //                         true
                                                  //                         ? AppColors
                                                  //                         .colorwhite
                                                  //                         : AppColors
                                                  //                         .colorblack),
                                                  //               ),
                                                  //               Padding(
                                                  //                 padding:
                                                  //                 const EdgeInsets
                                                  //                     .only(
                                                  //                     left: 5),
                                                  //                 child: Text(
                                                  //                     data?[index]['gender_options'][0]['title'],
                                                  //                     style: TextStyle(
                                                  //                       color: isDarkMode ==
                                                  //                           true
                                                  //                           ? AppColors
                                                  //                           .colorwhite
                                                  //                           : ColorApp
                                                  //                           .colorblackgalf,
                                                  //                       fontWeight: FontWeight
                                                  //                           .w500,
                                                  //                       fontFamily: "Montserrat",
                                                  //                     )),
                                                  //               ),
                                                  //             ],
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ],

                                                  // ListView.builder(
                                                  //     shrinkWrap: true,
                                                  //     physics: ClampingScrollPhysics(),
                                                  //     itemCount: data?.length ?? 1,
                                                  //     itemBuilder:(context, index){
                                                  //   return Text(snapshot.data![index].)
                                                  // })
                                                  // if ((benefit_options?.length
                                                  //     .toString() ??
                                                  //     '0') !=
                                                  //     '0') ...[
                                                  //   Column(
                                                  //     children: [
                                                  //       Padding(
                                                  //         padding:
                                                  //         const EdgeInsets.only(
                                                  //             top: 10),
                                                  //         child: Row(
                                                  //           children: [
                                                  //             Material(
                                                  //               color: ColorApp
                                                  //                   .colorwhite,
                                                  //               elevation: 1,
                                                  //               shape: RoundedRectangleBorder(
                                                  //                   borderRadius:
                                                  //                   BorderRadius
                                                  //                       .circular(
                                                  //                       5.0)),
                                                  //               child: Container(
                                                  //                 height: s.height *
                                                  //                     0.032,
                                                  //                 width: s.width *
                                                  //                     0.081,
                                                  //                 child: Icon(
                                                  //                   Icons
                                                  //                       .medical_services_outlined,
                                                  //                   color: ColorApp
                                                  //                       .colorblackgalf,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             Padding(
                                                  //               padding:
                                                  //               const EdgeInsets
                                                  //                   .only(
                                                  //                   left: 10),
                                                  //               child: Text(
                                                  //                   "Other Benefits",
                                                  //                   style:
                                                  //                   TextStyle(
                                                  //                     color: isDarkMode ==
                                                  //                         true
                                                  //                         ? AppColors
                                                  //                         .colorwhite
                                                  //                         : AppColors
                                                  //                         .colorblack,
                                                  //                     fontWeight:
                                                  //                     FontWeight
                                                  //                         .w600,
                                                  //                     fontFamily:
                                                  //                     "Montserrat",
                                                  //                   )),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //       Row(
                                                  //         crossAxisAlignment:
                                                  //         CrossAxisAlignment
                                                  //             .start,
                                                  //         children: [
                                                  //           Text(
                                                  //             "\u2022",
                                                  //             style: TextStyle(
                                                  //                 fontSize: 30,
                                                  //                 color: isDarkMode ==
                                                  //                     true
                                                  //                     ? AppColors
                                                  //                     .colorwhite
                                                  //                     : AppColors
                                                  //                     .colorblack),
                                                  //           ),
                                                  //           Padding(
                                                  //             padding:
                                                  //             const EdgeInsets
                                                  //                 .only(
                                                  //                 top: 10,
                                                  //                 left: 10),
                                                  //             child: Text(
                                                  //                 data?[index][
                                                  //                 'allowance_options']
                                                  //                 [0]['title'],
                                                  //                 style: TextStyle(
                                                  //                   color: isDarkMode ==
                                                  //                       true
                                                  //                       ? AppColors
                                                  //                       .colorwhite
                                                  //                       : AppColors
                                                  //                       .colorblack,
                                                  //                   fontWeight:
                                                  //                   FontWeight
                                                  //                       .w500,
                                                  //                   fontFamily:
                                                  //                   "Montserrat",
                                                  //                 )),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ],
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       top: 10, bottom: 10),
                                              //   child: ReadMoreText(
                                              //     style: TextStyle(
                                              //         color: isDarkMode == false
                                              //             ? AppColors.colorblack
                                              //             : AppColors
                                              //                 .colorwhite),
                                              //     data[''],
                                              //     trimLines: 2,
                                              //     colorClickableText:
                                              //         isDarkMode == false
                                              //             ? AppColors
                                              //                 .colorpurpal
                                              //             : AppColors
                                              //                 .colorwhite,
                                              //     trimMode: TrimMode.Line,
                                              //     trimCollapsedText:
                                              //         'Load more',
                                              //     trimExpandedText: 'Show less',
                                              //     moreStyle: TextStyle(
                                              //       fontSize: 16,
                                              //       fontWeight: FontWeight.bold,
                                              //       color: isDarkMode == false
                                              //           ? AppColors.colorpurpal
                                              //           : AppColors.colorwhite,
                                              //     ),
                                              //     lessStyle: TextStyle(
                                              //       fontSize: 16,
                                              //       fontWeight: FontWeight.bold,
                                              //       color: isDarkMode == false
                                              //           ? Colors.grey
                                              //           : AppColors.colorwhite,
                                              //     ),
                                              //   ),
                                              // ),
                                              Row(
                                                children: [
                                                  if (companyDetails
                                                          .toString() !=
                                                      "null") ...[
                                                    Expanded(
                                                      child: Text(
                                                        companyDetails
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color:
                                                              isDarkMode == true
                                                                  ? ColorApp
                                                                      .colorwhite
                                                                  : Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ] else if (companyDetails
                                                          .toString() ==
                                                      "null") ...[
                                                    Text(
                                                      "No details provided.",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color:
                                                            isDarkMode == true
                                                                ? ColorApp
                                                                    .colorwhite
                                                                : Colors.grey,
                                                      ),
                                                    )
                                                  ]
                                                ],
                                              ),
                                              if (companyDetails.toString() ==
                                                  "null") ...[
                                                Text(
                                                  "",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : Colors.grey,
                                                  ),
                                                )
                                              ] else ...[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: s.width * 0.12,
                                                      top: 10),
                                                  child: SubmitButton(
                                                      textColor: isDarkMode ==
                                                              true
                                                          ? AppColors.colorwhite
                                                          : AppColors
                                                              .colorwhite,
                                                      backGroundColor: AppColors
                                                          .colorprimary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      widthButton:
                                                          s.width * 0.53,
                                                      heightButton:
                                                          s.height * 0.050,
                                                      textButton:
                                                          "View Company Profile",
                                                      onPressed: () async {

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                    CompanyDetailScreen(
                                                                      companyId:
                                                                      idAlljobs,
                                                                      companyName:
                                                                      jobName,
                                                                      companywebsite:
                                                                      "jobTitle",
                                                                      image:
                                                                      'https://api.publish.jobs/pjcloud/Business/' + jobImage.toString(),
                                                                      companyoption:
                                                                      "",
                                                                    )));
                                                      }),
                                                )
                                              ]
                                            ],
                                          ),
                                        )
                                      ],
                                      controller: _tabController,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, id, title, businessName) {
    var brightness = MediaQuery.of(context).platformBrightness;
    ABD abd = ABD();
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery.of(context).size;
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
            color: isDarkMode == false
                ? AppColors.appBgLight
                : AppColors.colorbgdark,
            borderRadius: BorderRadius.circular(12)),
        width: s.width * 0.3,
        height: s.height * 0.15,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
              child: Material(
                color: Colors.white.withOpacity(0.0),
                child: InkWell(
                  splashColor: AppColors.colorindigo.withOpacity(0.8),
                  onTap: () {
                    if (tokenHeader == 'null') {
                      showAlertDialogLogInFirst(
                          context, "first to save your job..!");
                    } else {
                      print('job savedddddddddddddddddddddd');
                      PostAddSaveJobController()
                          .jobseekerAddSaveJob(id.toString(), context);
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.check_rounded,
                          color: isDarkMode == false
                              ? AppColors.colorgraydark
                              : AppColors.colorwhite,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Saved",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode == false
                                ? AppColors.colorgraydark
                                : AppColors.colorwhite,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.white.withOpacity(0.0),
                child: InkWell(
                  splashColor: AppColors.colorindigo.withOpacity(0.8),
                  onTap: () {
                    if (tokenHeader == 'null') {
                      showAlertDialogLogInFirst(
                          context, "first to report this job..!");
                    } else {
                      showAlertDialogReport(context, id, title, businessName);
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.flag_outlined,
                          color: isDarkMode == false
                              ? AppColors.colorgraydark
                              : AppColors.colorwhite,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Report",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode == false
                                ? AppColors.colorgraydark
                                : AppColors.colorwhite,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogReport(BuildContext context, id, title, businessName) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery.of(context).size;
    ABD abd = ABD();
    AlertDialog alert = AlertDialog(
        insetPadding: EdgeInsets.only(left: 10, right: 10),
        backgroundColor: isDarkMode == true
            ? ColorApp.colornewblack
            : ColorApp.colorbackground,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              width: s.width,
              color: isDarkMode == true
                  ? ColorApp.colornewblack
                  : ColorApp.colorbackground,
              child: Column(
                children: [
                  FutureBuilder<List<JobReportOptionWebModel>>(
                    future: GetJobReportOptionController().jobReportOption(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                            height: s.height * 0.6,
                            width: s.width * 0.9,
                            child: Center(
                                child: Column(
                              children: [
                                // StatefulBuilder(builder: (){}),
                                CircularProgressIndicator(),
                              ],
                            )));
                      } else {
                        List<bool> _selected = [];
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          _selected.add(false);
                        }
                        return StatefulBuilder(builder: (context, setState) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Report this Jobs",
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w500,
                                          color: isDarkMode == false
                                              ? AppColors.btnbackground
                                              : AppColors.btnbackground),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Choose what's wrong with this job?",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: isDarkMode == false
                                              ? ColorApp.colorblackgalf
                                              : AppColors.colorwhite),
                                    ),
                                  ),
                                  Text(
                                    widget.title.toString(),
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w500,
                                        color: isDarkMode == false
                                            ? ColorApp.colornewblack
                                            : AppColors.colorwhite),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.bussinessName.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: isDarkMode == false
                                            ? AppColors.btnbackground
                                            : AppColors.btnbackground),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                              Divider(
                                  thickness: 1,
                                  color: isDarkMode == false
                                      ? ColorApp.colorblackgalf
                                      : ColorApp.colorblackgalf),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8, top: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: isDarkMode == true
                                                    ? (_selected[index]
                                                        ? ColorApp.colorprimary
                                                        : ColorApp
                                                            .colornewblack)
                                                    : (_selected[index]
                                                        ? ColorApp.colorprimary
                                                        : ColorApp
                                                            .colorhalfWhite),
                                                border: Border.all(
                                                    color: isDarkMode == false
                                                        ? ColorApp
                                                            .colorblackgalf
                                                        : ColorApp
                                                            .colorblackgalf),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  activeColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          isDarkMode == true
                                                              ? Colors.white
                                                              : AppColors
                                                                  .colorblue),
                                                  value: int.parse(snapshot
                                                      .data![index].id
                                                      .toString()),
                                                  groupValue: checked,
                                                  onChanged: (int? newValue) {
                                                    setState(() {
                                                      _selected.clear();
                                                      for (int i = 0;
                                                          i <
                                                              snapshot
                                                                  .data!.length;
                                                          i++) {
                                                        _selected.add(false);
                                                      }
                                                      _selected[index] =
                                                          !_selected[index];
                                                      isChecked = !isChecked;
                                                      checkReport = snapshot
                                                          .data![index].id
                                                          .toString();
                                                      checked = int.parse(
                                                          snapshot
                                                              .data![index].id
                                                              .toString());
                                                      checked = newValue;


                                                      // checked = val;
                                                    });


                                                  },
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    snapshot
                                                        .data![index].statement
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: isDarkMode ==
                                                                true
                                                            ? Colors.white
                                                            : ColorApp
                                                                .colornewblack),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Other details",
                                    style: TextStyle(
                                        color: isDarkMode == false
                                            ? ColorApp.colorblackgalf
                                            : AppColors.colorwhite),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'report description';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: isDarkMode == false
                                        ? AppColors.colorgraydark
                                        : AppColors.colorwhite),
                                controller: reportDescription,
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: isDarkMode == false
                                              ? ColorApp.colorblackgalf
                                              : ColorApp.colorblackgalf)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  hintText: "AnyThing else writer here",
                                  hintStyle: TextStyle(
                                      color: isDarkMode == false
                                          ? AppColors.colorgraydark
                                          : AppColors.colorwhite),
                                  fillColor: isDarkMode == false
                                      ? AppColors.colorwhite
                                      : AppColors.colorwhite,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: isDarkMode == false
                                            ? Colors.red
                                            : Colors.red,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple, width: 2.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: s.width * 0.15),
                                child: Row(
                                  children: [
                                    SubmitButton(
                                        border: Border.all(
                                            color: isDarkMode == true
                                                ? Colors.white.withOpacity(0.3)
                                                : Colors.black54
                                                    .withOpacity(0.3)),
                                        textColor: isDarkMode == true
                                            ? AppColors.colorwhite
                                            : AppColors.colorblack,
                                        backGroundColor: isDarkMode == true
                                            ? Color(0xff343434)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        heightButton: s.height * 0.05,
                                        widthButton: s.width * 0.29,
                                        textButton: "Cancel",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: s.width * 0.05),
                                      child: Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: ColorApp.colorprimary,
                                        child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            splashColor: AppColors.colorindigo
                                                .withOpacity(0.8),
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                PostAddReportJobController()
                                                    .jobseekerAddReportJob(
                                                        checked.toString(),
                                                        reportDescription.text,
                                                        id.toString(),
                                                        context)
                                                    .then((value) {
                                                  openAlertBox(
                                                      "Report this jobs");
                                                })
                                                  ..catchError((error) {
                                                    openAlertBox(
                                                        "Already Reports this jobs");
                                                  });
                                              }
                                            },
                                            child: Container(
                                                height: s.height * 0.05,
                                                width: s.width * 0.23,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Center(
                                                    child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: isDarkMode == false
                                                          ? AppColors.colorwhite
                                                          : Colors.white),
                                                )))),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogLogInFirst(BuildContext context, String text) {
    var brightness = MediaQuery.of(context).platformBrightness;
    ABD abd = ABD();
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery.of(context).size;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor:
          isDarkMode == false ? AppColors.appBgLight : AppColors.colorbgdark,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
      actions: [
        Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Icon(
                  Icons.error_outline,
                  color: Colors.orange,
                  size: 36,
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Not LogedIn!",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode == false
                            ? AppColors.colorgraydark
                            : AppColors.colorwhite),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        "Please",
                        style: TextStyle(
                            color: isDarkMode == false
                                ? AppColors.colorgraydark
                                : AppColors.colorwhite),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInScreen(
                                      checkNav: '',
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: isDarkMode == false
                                ? AppColors.colorgraydark
                                : AppColors.colorwhite),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("ok"),
                ),
              ),
            ],
          ),
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  openAlertBox(
    title,
  ) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.only(
                bottom: s.height * 0.37,
                left: 0,
                right: 0,
                top: s.height * 0.30),
            backgroundColor: ColorApp.colorprimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: Container(
              decoration: BoxDecoration(
                  color: ColorApp.colorprimary,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: ColorApp.colorwhite,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    height: s.height * 0.05,
                    width: s.width * 0.12,
                    child: Image.asset(ImangeAssests.goodSign),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Thank you for reporting ",
                    style: TextStyle(
                        color: ColorApp.colorwhite,
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bar(
                                    id: 0,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      width: s.width * 0.6,
                      height: s.height * 0.05,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Go to Search Jobs",
                            style: TextStyle(color: ColorApp.colorprimary),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
