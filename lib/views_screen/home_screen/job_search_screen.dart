import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/all_jobs_model.dart';
import '../../model/country_list_model.dart';
import '../../utils/app_color.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/jobscard_widget.dart';
import 'job_detail.dart';
import 'package:http/http.dart' as http;

class JobSearchScreen extends StatefulWidget {
  final String? tokenCuperTino;

  const JobSearchScreen({Key? key, this.tokenCuperTino}) : super(key: key);

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  String? countryId;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? profileCity;
  String? imageLink;
  List uesrCountryList = [];
  List countryListData = [];
  List countryList = ['lahore'];
  String newFirstName = '';
  String newLastName = '';
  String newPhonNumber = '';
  String FirstName = '';
  String? LastName = '';
  String? mobile;
  String phonNumber = '';
  bool _obscureText = true;
  String? email;
  Future<AllJobsModel>? getAllJobsFuture;

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
       /* print('failed persnal info error status code: ' +
            response.statusCode.toString());*/
      }
    } catch (e) {
      // print(e.toString() + ' personalInfo exception');
    }
  }
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  int _page = 0;

  final int _limit = 20;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;

  List _posts = [];

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300
    ) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        final res =
        await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {

          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }


      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res =
      await http.get(Uri.parse("https://api.publish.jobs/api/get-allJob?page=$pageData&q=$searchData&fc=$fc&fct=$fct&fjt=$fjt'"));
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  late ScrollController _controller;
  // @override
  // void initState() {
  //   super.initState();
  //   _firstLoad();
  //   _controller = ScrollController()..addListener(_loadMore);
  //
  // }

  String searchData = '';
  String fct = '';
  String fc = '';
  String fjt = '';
  List jobsListData=[];
  int pageData=1;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  getJobList(String searchData, fc, fct, fjt,page) async {
    final response = await http
        .get(Uri.parse(
        'https://api.publish.jobs/api/get-allJob?page=$pageData&q=$searchData&fc=$fc&fct=$fct&fjt=$fjt'))
        .timeout(Duration(seconds: 10));
    final json = jsonDecode(response.body) ;
    if (response.statusCode == 200) {
      setState(() {
        jobsListData = jobsListData+json['data'];
        // print(jobsListData);
        // print(pageData.toString()+": pageeeeeeeeeeeeeeeeeeeeeeee");
      });
      if (searchData!= null){
        jobsListData = jobsListData.where((element) => element.name!.toLowerCase().contains((searchData.toLowerCase()))).toList();
      }
    } else {
      // print('failed all jobs statusssssss:' + response.statusCode.toString());
    }

    // return AllJobsModel.fromJson(data);
  }
  @override
  void initState() {
    getJobList( searchData, fc, fct, fjt,1);

    getProfilePersonalInfo();

    //getdata();

    // getAllJobsFuture = GetJobsListController().getJobList(
    //     searchData == 'null' ? '' : searchData.toString(), fc, fct, fjt);
    // countriesFilterListFuture = ABD().getCountriesFilterList();
    // super.initState();
    // filterCountryList();
    // getJobType();
TextEditingController searchController =TextEditingController();
    getProfilePersonalInfo();
    // getAllJobsFuture = GetJobsListController().getJobList(
    //     searchData == 'null' ? '' : searchData.toString(), fc, fct, fjt);
    // TODO: implement initState
    super.initState();
  }
  TextEditingController searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor:
        isDarkMode == true
            ? ColorApp.colornewblack
            : ColorApp.colorbackground,
        actions: [
          AppBarShow(),
        ],
      ),
      backgroundColor:

      isDarkMode == true
          ? ColorApp.colornewblack
          : ColorApp.colorbackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12,top: 10),
                  child: Text(
                    "Search",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblack),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 1, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: s.height * 0.05,
                      child: Material(
                        color: isDarkMode == true
                            ? ColorApp.colorblackgalf.withOpacity(0.5)
                            : ColorApp.colorwhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        elevation: 1,
                        child: TextFormField(
                          controller:searchController ,
                          onFieldSubmitted: (value) {

                            // getAllJobsFuture = GetJobsListController()
                            //     .getJobList(
                            //         searchData == 'null'
                            //             ? ''
                            //             : searchData.toString(),
                            //         fc,
                            //         fct,
                            //         fjt);
                            // // companyData.toString()=='null'?'':companyData.toString()
                            //
                            // FocusScopeNode currentFocus =
                            //     FocusScope.of(context);
                            //
                            // if (!currentFocus.hasPrimaryFocus) {
                            //   currentFocus.unfocus();
                            // }
                          },
                          onChanged: (data) {
                            setState(() {
                              searchData = data.toString();
                            });
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              hintText: 'Search Publish jobs or keybords',
                              hintStyle: TextStyle(
                                  color: isDarkMode == false
                                      ? ColorApp.colorblackgalf
                                      : ColorApp.colorwhite.withOpacity(0.8),
                                  fontSize: 12),
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    fc = '';
                                    fct = '';
                                    fjt = '';
                                    FocusScope.of(context).unfocus();
                                  });
                                  // getAllJobsFuture = GetJobsListController()
                                  //     .getJobList(
                                  //         searchData == 'null'
                                  //             ? ''
                                  //             : searchData.toString(),
                                  //         fc,
                                  //         fct,
                                  //         fjt);
                                },
                                child: Icon(
                                  Icons.search,
                                  color: isDarkMode == false
                                      ? ColorApp.colorblackgalf
                                      : ColorApp.colorwhite.withOpacity(0.8),
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 12),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: isDarkMode == false
                                ? Colors.white
                                : const Color(0xff38373c),
                            shape: const RoundedRectangleBorder(
                              // <-- SEE HERE
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            context: context,
                            builder: (Context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      left: 12,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Material(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              elevation: 1,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: Icon(
                                                        Icons.arrow_back_ios),
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              'Back',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),

                                        Text('Search by',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),

                                      ],
                                    ),
                                  ),
                                );
                              });
                            });
                      },
                      child: Material(
                        color: isDarkMode == true
                            ? ColorApp.colorblackgalf.withOpacity(0.5)
                            : ColorApp.colorwhite,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Container(
                          height: s.height * 0.045,
                          width: s.width * 0.093,
                          child: Icon(
                            Icons.filter_alt_outlined,
                            color: isDarkMode == false
                                ? ColorApp.colorblackgalf
                                : ColorApp.colorwhite.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblack),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Populer Jobs",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode == true
                            ? ColorApp.colorwhite
                            : ColorApp.colorblack),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ListView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: jobsListData.length,
                itemBuilder: (context, index) {

                  var jobData = jobsListData[index];
                  String jobTitle =jobData['title'].toString();
                  if(searchData.isEmpty){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                      child: JobsCard(
                          buttonColor: ColorApp.colorprimary,
                          ontapsave: () {
                            // if (tokenHeader == 'null') {
                            //   showAlertDialogLogInFirst(
                            //       context, "first to save your job..!");
                            // } else if
                            //  (tokenHeader != 'null') {
                            //   if(PostAddSaveJobController().jobseekerAddSaveJob(jobData['id'].toString(), context)=="null"){
                            //  setState(() {
                            //    PostAddSaveJobController()
                            //        .jobseekerAddSaveJob(jobData['id'].toString(), context)==[];
                            //    print("data saved");
                            //  });
                            //   }
                            // else{
                            //   print("abt");
                            //   }
                            //
                            // }
                          },
                          ontapshare: () async {
                            dynamic name = jobData['title'].toString();
                            final result =
                            name.replaceAll(RegExp('[^A-Za-z0-9]'), '-');
                            name.trim();
                            print(name.toString() + "name");
                            final url =
                                '${'https://publish.jobs/${result}/${jobData['uuid'].toString()}'}';

                            await Share.share('${url}');
                          },
                          iconHeart: Icons.favorite_border,
                          heartColor: isDarkMode == true
                              ? Colors.red
                              : ColorApp.colorprimary,
                          iconShare: Icons.share_outlined,
                          shareColor: isDarkMode == true
                              ? ColorApp.colorwhite
                              : ColorApp.colorblackgalf,
                          salaryShow: jobData['salary']['currency']
                          ['currency_code']
                              .toString() +
                              " " +
                              (jobData['salary']['minimum'].toString()) +
                              " - " +
                              (jobData['salary']['maximum'].toString()) +
                              " " +
                              '/' +
                              " " +
                              jobData['salary']['salary_type']['title']
                                  .toString(),
                          hoursShow: "1hr Ago",
                          image: jobData['business']['business_image']
                              .toString() !=
                              'null'
                              ? NetworkImage(
                              'https://api.publish.jobs/pjcloud/Business/' +
                                  jobData['business']['business_image']
                                  ['image']
                                      .toString())
                              : NetworkImage(
                              'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg'),
                          cityName:
                          jobData['city_options'][0]['title'].toString(),
                          JobName: jobData['title'].toString(),
                          companyName: jobData['business']['name'].toString(),
                          buttonText: "Apply",
                          Ontap: () async {
                            final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            await prefs.setString(
                                "jobName", jobData['title'].toString());
                            await prefs.setString("companyName",
                                jobData['business']['name'].toString());
                            await prefs.setString(
                                "cityName",
                                jobData['city_options'][0]['title']
                                    .toString());
                            await prefs.setString("jobDescription",
                                jobData['jobtype_options'][0]['title']);
                            await prefs.setString(
                                "salaryShow",
                                jobData['salary']['currency']['currency_code']
                                    .toString() +
                                    " " +
                                    (jobData['salary']['minimum']
                                        .toString()) +
                                    " - " +
                                    (jobData['salary']['maximum']
                                        .toString()) +
                                    " " +
                                    '/' +
                                    " " +
                                    jobData['salary']['salary_type']['title']
                                        .toString());
                            await prefs.setString("postedTime", '1 hour ago');
                            await prefs.setString(
                                "imageUrl",
                                jobData['business']['business_image']
                                    .toString() !=
                                    'null'
                                    ? 'https://api.publish.jobs/pjcloud/Business/' +
                                    jobData['business']['business_image']
                                    ['image']
                                        .toString()
                                    : 'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg');

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobDetail(
                                        uUid: jobData['uuid'].toString(),
                                        id: jobData['id'].toString(),
                                        title: jobData['title'].toString(),
                                        bussinessName: jobData['business']
                                        ['name']
                                            .toString())));
                          },
                          fullTime:
                          jobData['jobtype_options'][0]['title'].toString()),
                    );
                  } else if(jobTitle
                      .toLowerCase()
                      .contains(searchData.toString())){
                    return  Padding(
                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                      child: JobsCard(
                          ontapsave: () {
                            // if (tokenHeader == 'null') {
                            //   showAlertDialogLogInFirst(
                            //       context, "first to save your job..!");
                            // } else if
                            //  (tokenHeader != 'null') {
                            //   if(PostAddSaveJobController().jobseekerAddSaveJob(jobData['id'].toString(), context)=="null"){
                            //  setState(() {
                            //    PostAddSaveJobController()
                            //        .jobseekerAddSaveJob(jobData['id'].toString(), context)==[];
                            //    print("data saved");
                            //  });
                            //   }
                            // else{
                            //   print("abt");
                            //   }
                            //
                            // }
                          },
                          ontapshare: () async {
                            dynamic name = jobData['title'].toString();
                            final result =
                            name.replaceAll(RegExp('[^A-Za-z0-9]'), '-');
                            name.trim();
                            print(name.toString() + "name");
                            final url =
                                '${'https://publish.jobs/${result}/${jobData['uuid'].toString()}'}';

                            await Share.share('${url}');
                          },
                          iconHeart: Icons.favorite_border,
                          heartColor: isDarkMode == true
                              ? Colors.red
                              : ColorApp.colorprimary,
                          iconShare: Icons.share_outlined,
                          shareColor: isDarkMode == true
                              ? ColorApp.colorwhite
                              : ColorApp.colorblackgalf,
                          salaryShow: jobData['salary']['currency']
                          ['currency_code']
                              .toString() +
                              " " +
                              (jobData['salary']['minimum'].toString()) +
                              " - " +
                              (jobData['salary']['maximum'].toString()) +
                              " " +
                              '/' +
                              " " +
                              jobData['salary']['salary_type']['title']
                                  .toString(),
                          hoursShow: "1hr Ago",
                          image: jobData['business']['business_image']
                              .toString() !=
                              'null'
                              ? NetworkImage(
                              'https://api.publish.jobs/pjcloud/Business/' +
                                  jobData['business']['business_image']
                                  ['image']
                                      .toString())
                              : NetworkImage(
                              'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg'),
                          cityName:
                          jobData['city_options'][0]['title'].toString(),
                          JobName: jobData['title'].toString(),
                          companyName: jobData['business']['name'].toString(),
                          buttonText: "Apply",
                          Ontap: () async {
                            final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            await prefs.setString(
                                "jobName", jobData['title'].toString());
                            await prefs.setString("companyName",
                                jobData['business']['name'].toString());
                            await prefs.setString(
                                "cityName",
                                jobData['city_options'][0]['title']
                                    .toString());
                            await prefs.setString("jobDescription",
                                jobData['jobtype_options'][0]['title']);
                            await prefs.setString(
                                "salaryShow",
                                jobData['salary']['currency']['currency_code']
                                    .toString() +
                                    " " +
                                    (jobData['salary']['minimum']
                                        .toString()) +
                                    " - " +
                                    (jobData['salary']['maximum']
                                        .toString()) +
                                    " " +
                                    '/' +
                                    " " +
                                    jobData['salary']['salary_type']['title']
                                        .toString());
                            await prefs.setString("postedTime", '1 hour ago');
                            await prefs.setString(
                                "imageUrl",
                                jobData['business']['business_image']
                                    .toString() !=
                                    'null'
                                    ? 'https://api.publish.jobs/pjcloud/Business/' +
                                    jobData['business']['business_image']
                                    ['image']
                                        .toString()
                                    : 'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg');

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobDetail(
                                        uUid: jobData['uuid'].toString(),
                                        id: jobData['id'].toString(),
                                        title: jobData['title'].toString(),
                                        bussinessName: jobData['business']
                                        ['name']
                                            .toString())));
                          },
                          fullTime:
                          jobData['jobtype_options'][0]['title'].toString()),
                    );
                  }
                  else{
                    return Container(
                      child: Text(""),
                    );
                  }

                }),
          ],
        ),
      ),
    );
  }
}
