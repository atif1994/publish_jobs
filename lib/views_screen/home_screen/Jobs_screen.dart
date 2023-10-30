import 'dart:async';
import 'dart:convert';

import 'package:firstapp/App%20Services/global_vars.dart';
import 'package:firstapp/utils/app_color.dart';
import 'package:firstapp/widgets/jobscard_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../App Services/api_services_provider.dart';

import '../../Network Controller/Appbar Controller/get_appbar_controller.dart';
import '../../Network Controller/General Controllers/user_available_country_controller.dart';
import '../../Network Controller/Home Get Apis/get_company_list_controller.dart';
import '../../Network Controller/Home Get Apis/get_jobtype_list_controller.dart';
import '../../Network Controller/Home Get Apis/get_saved_jobs_controller.dart';
import '../../Network Controller/Home Post Apis/post_add_report_job_controller.dart';
import '../../Network Controller/Home Post Apis/post_add_save_job_controller.dart';
import '../../Network Controller/Home Post Apis/post_remove_save_job_controller.dart';
import '../../api/api.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/all_company_model.dart';
import '../../model/all_jobs_model.dart';

import '../../model/country_list_model.dart';
import '../../model/job_ReportOption_Web_model.dart';
import '../../model/job_type_filter_model.dart';
import '../../model/user_available_country_model.dart';
import '../../utils/app_string.dart';

import '../../widgets/Textformfield_widget.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/companycard_widget.dart';
import '../Login_screen/login_screen.dart';
import 'company_detail.dart';
import 'side_drawer.dart';
import 'job_detail.dart';

class SearchScreen extends StatefulWidget {
  final String? searchData;
  final String? tokenCuperTino;
  final String? image;

  const SearchScreen(
      {Key? key, this.searchData, this.tokenCuperTino, this.image})
      : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  TextEditingController SearchController = TextEditingController();
  final reportDescription = TextEditingController();
  Future<AllJobsModel>? getAllJobsFuture;
  Future<AllCompanyListModel>? getAllCompanyFuture;
  String? tokenHeader;
  String? checkReport;
  int? checked = 0;
  String? selectedValue = null;
  String? jopTypeSelection;
  String? jobTypeId;
  bool isDark = false;
  String searchData = '';
  String? companySearchData;
  String filterCountry = '';
  String filterCity = '';
  String filterJobype = '';
  String fct = '';
  String fc = '';
  String fjt = '';
  String? countryId;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? profileCity;
  String? imageLink;
  String? titleName;
  String? mobile;
  bool _obscureText = true;
  String? email;
  String? citySelection;
  List uesrCountryList = [];

//TextEditingController SearchController =TextEditingController();
  checkIfLogIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tokenHeader = pref.getString('tokenProvider').toString();
    setState(() {
      tokenHeader = tokenHeader;
    });

    if (tokenHeader.toString() == 'null') {
      getJobList(searchData, filterCity, filterCountry, filterJobype);
    } else {
      getJobListWithUserAuth(
          searchData, filterCity, filterCountry, filterJobype);
    }
  }

  final String urlCountry = "https://api.publish.jobs/api/countries";
  String? countrySelection;

  String? cityId;
  List countryList = [];

  // List cityList = ["islamabad", "lahore", "karachi"];
  final String urlJoptype = "https://api.publish.jobs/api/jobTypeFilter";
  List JobTypeListData = [];
  List jobList = [];

  Future<String> getJobType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse(urlJoptype),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      JobTypeListData = resBody;
    });

    return "Sucess";
  }

  List countryListData = [];

  Future<String> getCountryList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse(urlCountry),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      countryListData = resBody;
    });

    return "Sucess";
  }

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
        if (data['user_info'].toString() != 'null') {}
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
        });
      } else {

      }
    } catch (e) {

    }
  }

  List cityListData = [];

  Future<String> postCityList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await post(
        Uri.parse(
            "https://api.publish.jobs/api/country-cities?country=$countryId"),
        body: {
          'country': countryId ?? '0',
        },
        headers: requestHeaders);
    var resBody = json.decode(res.body);
    setState(() {
      cityListData = resBody;
    });

    return "Sucess";
  }

  setOnBoarding() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('onBoardingSaved', 'yes');
  }

  checkIfOnBoardingSaved() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('onBoardingSaved') != 'yes') {
      pref.setString('onBoardingSaved', 'yes');
    }
  }

  bool isLoading = false;

  pagination() async {
    if (scrollcontrollerCompany.offset >=
        scrollcontrollerCompany.position.maxScrollExtent &&
        !scrollcontrollerCompany.position.outOfRange) {
      setState(() {
        jobLoading = true;
        pagecompany = pagecompany + 1;
      });
      if (tokenHeader.toString() == 'null') {
        await GetCompanyListController().getCompanyList(0, "");
      } else {
        await GetCompanyListController().getCompanyList(0, "");
      }
    }
  }

  List jobsListData = [];
  List jobsListDataWithAuth = [];
  int pageData = 1;
  int page = 1;
  int pagecompany = 1;
  bool isLoadingMore = false;
  final scrollController = ScrollController();

  getJobList(String searchData, fc, fct, fjt) async {
    final response = await http
        .get(Uri.parse(
        'https://api.publish.jobs/api/get-allJob?page=$pageData&q=$searchData&fc=$fc&fct=$fct&fjt=$fjt'))
        .timeout(const Duration(seconds: 10));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        if (kDebugMode) {


        }
        //jobsListData.clear();
        jobsListData = jobsListData + json['data'];
      });
    } else {
      if (kDebugMode) {

      }
    }

    // return AllJobsModel.fromJson(data);
  }


  var scrollcontrollerCompany = ScrollController();

  getJobListWithUserAuth(String searchData, fc, fct, fjt) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tokenHeader = pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader!
    };
    final response = await http
        .get(
        Uri.parse(
            'https://api.publish.jobs/api/get-allJob?page=$pageData&q=$searchData&fc=$fc&fct=$fct&fjt=$fjt'),
        headers: requestHeaders)
        .timeout(const Duration(seconds: 10));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        jobsListDataWithAuth = jobsListDataWithAuth + json['data'];
      });
    } else {
      if (kDebugMode) {

      }
    }

    // return AllJobsModel.fromJson(data);
  }


  late TabController _tabController;

  bool jobLoading = false;

  _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        jobLoading = true;
        pageData = pageData + 1;
      });
      if (tokenHeader.toString() == 'null') {
        await getJobList(searchData, filterCity, filterCountry, filterJobype);
      } else {
        await getJobListWithUserAuth(
            searchData, filterCity, filterCountry, filterJobype);
      }
    }
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return true;
  }

  @override
  void initState() {
    scrollcontrollerCompany.addListener(pagination);
    _tabController = new TabController(length: 4, vsync: this);

    // if(GlobalVarData.isAppBarCalled=='not')
    //   {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetAppBarImageController>(context, listen: false)
          .jobSeekerAppbarImage();
      GlobalVarData.isAppBarCalled = 'yes';
    });
    //}


    scrollController.addListener(_scrollListener);
    getProfilePersonalInfo();
    this.getCountryList();
    getJobType();


    getAllCompanyFuture =
        GetCompanyListController().getCompanyList(pagecompany, "");

    checkIfLogIn();
    checkIfOnBoardingSaved();
  }

  @override
  Widget build(BuildContext context) {
    print(tokenHeader.toString() + " " + "show token");
    final s = MediaQuery
        .of(context)
        .size;
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return DefaultTabController(
        length: 3,
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
              endDrawer: DrawerScreen(


                mobile: mobile,
                email: email,
                firstName: firstName,
                lastName: lastName,
                profileImage: profileImage,),
              backgroundColor: isDarkMode == true
                  ? ColorApp.colornewblack
                  : ColorApp.colorbackground,
              body: SafeArea(
                child: NestedScrollView(
                  controller: scrollController,
                  floatHeaderSlivers: true,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) =>
                  [
                    SliverAppBar(
                      elevation: 0,
                      actions: [ Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: Container(
                          color: isDarkMode == true ? Color(0xff343434) : Colors
                              .white,
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
                                          borderRadius: BorderRadius.circular(
                                              8)),
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : ColorApp.colorblackgalf.withOpacity(
                                          0.2),
                                      elevation: 1,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: isDarkMode == false
                                                ? Colors.white
                                                : ColorApp.colorblackgalf
                                                .withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                                8),
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
                                        padding: const EdgeInsets.only(
                                            right: 0),
                                        child: Container(
                                          width: s.width * 0.095,
                                          height: s.height * 0.048,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(50),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white)),
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
                      automaticallyImplyLeading: false,
                      snap: true,
                      backgroundColor: isDarkMode == true
                          ? ColorApp.colornewblack
                          : ColorApp.colorbackground,
                      floating: true,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(s.height * 0.05),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.1,
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
                                    : ColorApp.colorwhite.withOpacity(0.8),
                                indicatorColor: AppColors.colorpurpal,
                                indicatorPadding: EdgeInsets.only(
                                  right: 12,
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,

                                // TABS
                                tabs: [
                                  Tab(
                                    text: 'Jobs',
                                  ),
                                  Tab(
                                    text: 'Companies',
                                  ),
                                  Tab(
                                    text: 'Employer`s',
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
                    children: [
                      widgetJobs(),
                      widgetCompany(),
                      widgetEmployer(),
                    ],
                  ),
                ),
              )),
        ));
  }

  Widget widgetJobs() {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 1, 10),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: s.height * 0.05,
                      child: Material(
                        color: isDarkMode == true
                            ? ColorApp.colorblackgalf.withOpacity(0.5)
                            : ColorApp.colorwhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 1,
                        child: TextFormField(
                          onFieldSubmitted: (value) async {
                            pageData = 1;
                            if (tokenHeader.toString() == 'null') {
                              jobsListData.clear();
                              await getJobList(searchData, filterCity,
                                  filterCountry, filterJobype);
                            } else {
                              jobsListDataWithAuth.clear();
                              await getJobListWithUserAuth(searchData,
                                  filterCity, filterCountry, filterJobype);
                            }
                            // companyData.toString()=='null'?'':companyData.toString()

                            FocusScopeNode currentFocus =
                            FocusScope.of(context);

                            // jobsListData.clear();

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
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
                                onTap: () async {
                                  jobsListData.clear();
                                  pageData = 1;
                                  if (tokenHeader.toString() == 'null') {
                                    await getJobList(searchData, filterCity,
                                        filterCountry, filterJobype);
                                  } else {
                                    await getJobListWithUserAuth(
                                        searchData,
                                        filterCity,
                                        filterCountry,
                                        filterJobype);
                                  }

                                  jobsListData.clear();
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
                      onTap: () async {
                        SharedPreferences pref =
                        await SharedPreferences.getInstance();
                        tokenHeader =
                            pref.getString('tokenProvider').toString();

                        if (tokenHeader.toString() != 'null') {
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
                                    (BuildContext context,
                                    StateSetter setState) {
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
                                              GestureDetector(
                                                onTap: () {
                                                  //Navigator.po;
                                                  Get.back();
                                                },
                                                child: Material(
                                                  borderRadius:
                                                  BorderRadius.circular(4),
                                                  elevation: 1,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(5)),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 10,
                                                            top: 5,
                                                            bottom: 5),
                                                        child: Icon(Icons
                                                            .arrow_back_ios),
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Text(
                                                'Back',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.bold),
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
                                          FutureBuilder<
                                              List<
                                                  UserAvailableCountryModel>>(
                                              future:
                                              UserAvailableCountryController()
                                                  .userAvailableCountry(),
                                              builder: (context, snapshot) {
                                                var arrayLengh =
                                                    snapshot.data?.length ?? 0;
                                                for (var i = 0;
                                                i < arrayLengh - 1;
                                                i++) {
                                                  countryList.add(
                                                      snapshot.data![i].title);
                                                }
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                      child:
                                                      CircularProgressIndicator());
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                      CircularProgressIndicator());
                                                } else {
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(8.0),
                                                          child: Material(
                                                            elevation: 1,
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    4)),
                                                            child:
                                                            DropdownButton(
                                                                icon:
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                      10),
                                                                  child:
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_downward_outlined,
                                                                    size:
                                                                    18,
                                                                    color: isDarkMode ==
                                                                        false
                                                                        ? Colors
                                                                        .black26
                                                                        : Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                dropdownColor: isDarkMode ==
                                                                    false
                                                                    ? Color(
                                                                    0xffF0F2F5)
                                                                    : const Color(
                                                                    0xff38373c),
                                                                elevation:
                                                                1,
                                                                isExpanded:
                                                                true,
                                                                underline:
                                                                Container(
                                                                  color: AppColors
                                                                      .colorblue,
                                                                ),
                                                                hint:
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                                  child:
                                                                  Text(
                                                                    AppString
                                                                        .selectCountry,
                                                                    style: TextStyle(
                                                                        color: isDarkMode ==
                                                                            false
                                                                            ? Colors
                                                                            .black26
                                                                            : Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                value:
                                                                countrySelection,
                                                                onChanged:
                                                                    (v) {
                                                                  int?
                                                                  countryIndex;
                                                                  int index =
                                                                  countryListData
                                                                      .indexWhere((
                                                                      item) =>
                                                                  item["title"] ==
                                                                      v);
                                                                  setState(
                                                                          () {
                                                                        citySelection =
                                                                        null;
                                                                        countrySelection =
                                                                        v as String;
                                                                        countryIndex =
                                                                            countryListData
                                                                                .indexOf(
                                                                                v);
                                                                        //countryId = (index!+1).toString();
                                                                        for (var i =
                                                                        0;
                                                                        i <
                                                                            arrayLengh;
                                                                        i++) {
                                                                          if (snapshot
                                                                              .data![i]
                                                                              .title ==
                                                                              v) {
                                                                            countryId =
                                                                                snapshot
                                                                                    .data![i]
                                                                                    .id
                                                                                    .toString();
                                                                            fc =
                                                                                snapshot
                                                                                    .data![i]
                                                                                    .title
                                                                                    .toString();
                                                                          }
                                                                        }
                                                                        postCityList();
                                                                      });
                                                                },
                                                                items: countryListData
                                                                    .map(
                                                                        (v) {
                                                                      return DropdownMenuItem(
                                                                        value: v[
                                                                        'title'],
                                                                        child:
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                          Text(
                                                                            v['title'],
                                                                            style:
                                                                            TextStyle(
                                                                                color: isDarkMode ==
                                                                                    false
                                                                                    ? Colors
                                                                                    .black
                                                                                    : Colors
                                                                                    .black
                                                                                    .withOpacity(
                                                                                    0.5)),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    })
                                                                    .toList()),
                                                          ),
                                                        ),
                                                        countryId.toString() !=
                                                            'null'
                                                            ? Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(
                                                              8.0),
                                                          child: Column(
                                                            children: [
                                                              Material(
                                                                elevation:
                                                                1,
                                                                color: Colors
                                                                    .white,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        4)),
                                                                child: DropdownButton(
                                                                    icon: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right: 10),
                                                                      child:
                                                                      Icon(
                                                                        Icons
                                                                            .arrow_downward_outlined,
                                                                        size: 18,
                                                                        color: isDarkMode ==
                                                                            false
                                                                            ? Colors
                                                                            .black26
                                                                            : Colors
                                                                            .black
                                                                            .withOpacity(
                                                                            0.5),
                                                                      ),
                                                                    ),
                                                                    dropdownColor: isDarkMode ==
                                                                        false
                                                                        ? Color(
                                                                        0xffF0F2F5)
                                                                        : const Color(
                                                                        0xff38373c),
                                                                    elevation: 1,
                                                                    isExpanded: true,
                                                                    underline: Container(
                                                                      color:
                                                                      AppColors
                                                                          .colorblue,
                                                                    ),
                                                                    hint: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                      Text(
                                                                        AppString
                                                                            .selectCity,
                                                                        style: TextStyle(
                                                                            color: isDarkMode ==
                                                                                false
                                                                                ? Colors
                                                                                .black26
                                                                                : Colors
                                                                                .grey),
                                                                      ),
                                                                    ),
                                                                    value: citySelection,
                                                                    onChanged: (
                                                                        v) {
                                                                      setState(() {
                                                                        for (var i = 0; i <=
                                                                            cityListData
                                                                                .length -
                                                                                1; i++) {
                                                                          if (cityListData[i]['title'] ==
                                                                              v) {
                                                                            cityId =
                                                                                cityListData[i]['id']
                                                                                    .toString();
                                                                            fct =
                                                                                cityListData[i]['title']
                                                                                    .toString();
                                                                          }
                                                                        }
                                                                        citySelection =
                                                                        v as String;
                                                                        this
                                                                            .citySelection =
                                                                            v;
                                                                      });
                                                                    },
                                                                    items: cityListData
                                                                        .map((
                                                                        v) {
                                                                      return DropdownMenuItem(
                                                                        value: v['title'],
                                                                        child: Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child: Text(
                                                                            v['title'],
                                                                            style: TextStyle(
                                                                                color: isDarkMode ==
                                                                                    false
                                                                                    ? Colors
                                                                                    .black
                                                                                    : Colors
                                                                                    .black
                                                                                    .withOpacity(
                                                                                    0.5)),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    })
                                                                        .toList()),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                            : SizedBox(),
                                                        SizedBox(
                                                          width: s.width * 0.89,
                                                          child: FutureBuilder<
                                                              List<
                                                                  JobTypeFilterModel>>(
                                                              future: GetJobTypeListController()
                                                                  .getjobTypeList(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                var arrayLengh =
                                                                    snapshot
                                                                        .data
                                                                        ?.length ??
                                                                        0;
                                                                for (var i = 0;
                                                                i <
                                                                    arrayLengh -
                                                                        1;
                                                                i++) {
                                                                  jobList.add(
                                                                      snapshot
                                                                          .data![
                                                                      i]
                                                                          .title);
                                                                }

                                                                return Column(
                                                                  children: [
                                                                    Material(
                                                                      elevation:
                                                                      1,
                                                                      color: Colors
                                                                          .white,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              4)),
                                                                      child: DropdownButton(
                                                                          icon: Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .only(
                                                                                right: 10),
                                                                            child:
                                                                            Icon(
                                                                              Icons
                                                                                  .arrow_downward_outlined,
                                                                              size: 18,
                                                                              color: isDarkMode ==
                                                                                  false
                                                                                  ? Colors
                                                                                  .black26
                                                                                  : Colors
                                                                                  .black
                                                                                  .withOpacity(
                                                                                  0.5),
                                                                            ),
                                                                          ),
                                                                          dropdownColor: isDarkMode ==
                                                                              false
                                                                              ? Color(
                                                                              0xffF0F2F5)
                                                                              : const Color(
                                                                              0xff38373c),
                                                                          elevation: 1,
                                                                          isExpanded: true,
                                                                          underline: Container(
                                                                            color:
                                                                            AppColors
                                                                                .colorblue,
                                                                          ),
                                                                          hint: Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .all(
                                                                                8.0),
                                                                            child:
                                                                            Text(
                                                                              "Select Type",
                                                                              style: TextStyle(
                                                                                  color: isDarkMode ==
                                                                                      false
                                                                                      ? Colors
                                                                                      .black26
                                                                                      : Colors
                                                                                      .grey),
                                                                            ),
                                                                          ),
                                                                          value: jopTypeSelection,
                                                                          onChanged: (
                                                                              v) {
                                                                            int?
                                                                            countryIndex;
                                                                            int index = JobTypeListData
                                                                                .indexWhere((
                                                                                item) =>
                                                                            item["title"] ==
                                                                                v);
                                                                            setState(() {
                                                                              jopTypeSelection =
                                                                              v as String;
                                                                              countryIndex =
                                                                                  JobTypeListData
                                                                                      .indexOf(
                                                                                      v);
                                                                              //countryId = (index!+1).toString();
                                                                              for (var i = 0; i <
                                                                                  arrayLengh; i++) {
                                                                                if (snapshot
                                                                                    .data![i]
                                                                                    .title ==
                                                                                    v) {
                                                                                  jobTypeId =
                                                                                      snapshot
                                                                                          .data![i]
                                                                                          .id
                                                                                          .toString();
                                                                                  fjt =
                                                                                      snapshot
                                                                                          .data![i]
                                                                                          .title
                                                                                          .toString();
                                                                                }
                                                                              }
                                                                            });
                                                                          },
                                                                          items: JobTypeListData
                                                                              .map((
                                                                              v) {
                                                                            return DropdownMenuItem(
                                                                              value: v['title'],
                                                                              child: Padding(
                                                                                padding: const EdgeInsets
                                                                                    .all(
                                                                                    8.0),
                                                                                child: Text(
                                                                                  v['title'],
                                                                                  style: TextStyle(
                                                                                      color: isDarkMode ==
                                                                                          false
                                                                                          ? Colors
                                                                                          .black
                                                                                          : Colors
                                                                                          .black
                                                                                          .withOpacity(
                                                                                          0.5)),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          })
                                                                              .toList()),
                                                                    ),
                                                                  ],
                                                                );
                                                              }),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () async {
                                                              setState(() {
                                                                jobsListData
                                                                    .clear();
                                                                filterCountry =
                                                                    fct;
                                                                filterCity = fc;
                                                                filterJobype =
                                                                    fjt;
                                                                fct = '';
                                                                fc = '';
                                                                fjt = '';
                                                              });
                                                              if (tokenHeader
                                                                  .toString() ==
                                                                  'null') {
                                                                jobsListData
                                                                    .clear();
                                                                await getJobList(
                                                                    searchData,
                                                                    filterCity,
                                                                    filterCountry,
                                                                    filterJobype);
                                                              } else {
                                                                jobsListDataWithAuth
                                                                    .clear();
                                                                await getJobListWithUserAuth(
                                                                    searchData,
                                                                    filterCity,
                                                                    filterCountry,
                                                                    filterJobype);
                                                              }

                                                              Get.back();
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .colorpurpal,
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      12)),
                                                              child: Center(
                                                                  child:
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                    child: Text(
                                                                        'Apply Filter',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white)),
                                                                  )),
                                                            ))
                                                      ],
                                                    ),
                                                  );
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LogInScreen(
                                        checkNav: 'fromFilterBottomSheet',
                                      )));
                        }
                      },
                      child: Material(
                        color: isDarkMode == true
                            ? ColorApp.colorblackgalf.withOpacity(0.5)
                            : ColorApp.colorwhite,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: SizedBox(
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
            Column(
              children: [
                if (filterCountry == '' &&
                    filterCity == '' &&
                    filterJobype == '') ...[
                  SizedBox(
                    height: s.height * 0.18,
                    width: s.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Image.asset(ImangeAssests.searchImage,
                          fit: BoxFit.fill),
                    ),
                  ),
                ] else
                  ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            if (filterCity != '' &&
                                filterCountry == '' &&
                                filterJobype == '') ...[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColors.colorpurpal),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Row(
                                    children: [
                                      Center(
                                          child: Text(
                                            filterCity,
                                            style: TextStyle(
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() async {
                                              if (filterCountry == '') {
                                                filterCity = '';
                                              }
                                              if (tokenHeader.toString() ==
                                                  'null') {
                                                await getJobList(
                                                    searchData,
                                                    filterCity,
                                                    filterCountry,
                                                    filterJobype);
                                              } else {
                                                await getJobListWithUserAuth(
                                                    searchData,
                                                    filterCity,
                                                    filterCountry,
                                                    filterJobype);
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.cancel_rounded,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ] else
                              if (filterCity == '' &&
                                  filterCountry != '' &&
                                  filterJobype == '') ...[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColors.colorpurpal),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Row(
                                      children: [
                                        Center(
                                            child: Text(
                                              filterCountry,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() async {
                                                filterCountry = '';
                                                if (tokenHeader.toString() ==
                                                    'null') {
                                                  await getJobList(
                                                      searchData,
                                                      filterCity,
                                                      filterCountry,
                                                      filterJobype);
                                                } else {
                                                  await getJobListWithUserAuth(
                                                      searchData,
                                                      filterCity,
                                                      filterCountry,
                                                      filterJobype);
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.cancel_rounded,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ] else
                                if (filterCity == '' &&
                                    filterCountry == '' &&
                                    filterJobype != '') ...[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: AppColors.colorpurpal),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: Row(
                                        children: [
                                          Center(
                                              child: Text(
                                                filterJobype,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() async {
                                                  filterJobype = '';
                                                  if (tokenHeader.toString() ==
                                                      'null') {
                                                    await getJobList(
                                                        searchData,
                                                        filterCity,
                                                        filterCountry,
                                                        filterJobype);
                                                  } else {
                                                    await getJobListWithUserAuth(
                                                        searchData,
                                                        filterCity,
                                                        filterCountry,
                                                        filterJobype);
                                                  }
                                                });
                                              },
                                              child: Icon(
                                                Icons.cancel_rounded,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                ] else
                                  if (filterCity != '' &&
                                      filterCountry != '' &&
                                      filterJobype == '') ...[
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          color: AppColors.colorpurpal),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Row(
                                          children: [
                                            Center(
                                                child: Text(
                                                  filterCity,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() async {
                                                    filterCity = '';
                                                    if (tokenHeader
                                                        .toString() ==
                                                        'null') {
                                                      await getJobList(
                                                          searchData,
                                                          filterCity,
                                                          filterCountry,
                                                          filterJobype);
                                                    } else {
                                                      await getJobListWithUserAuth(
                                                          searchData,
                                                          filterCity,
                                                          filterCountry,
                                                          filterJobype);
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.cancel_rounded,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          color: AppColors.colorpurpal),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Row(
                                          children: [
                                            Center(
                                                child: Text(
                                                  filterCountry,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() async {
                                                    filterCountry = '';
                                                    if (tokenHeader
                                                        .toString() ==
                                                        'null') {
                                                      await getJobList(
                                                          searchData,
                                                          filterCity,
                                                          filterCountry,
                                                          filterJobype);
                                                    } else {
                                                      await getJobListWithUserAuth(
                                                          searchData,
                                                          filterCity,
                                                          filterCountry,
                                                          filterJobype);
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.cancel_rounded,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ] else
                                    if (fc != '' && fct == '' && fjt != '') ...[
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                16),
                                            color: AppColors.colorpurpal),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          child: Row(
                                            children: [
                                              Center(
                                                  child: Text(
                                                    filterCity,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() async {
                                                      filterCity = '';
                                                      if (tokenHeader
                                                          .toString() ==
                                                          'null') {
                                                        await getJobList(
                                                            searchData,
                                                            filterCity,
                                                            filterCountry,
                                                            filterJobype);
                                                      } else {
                                                        await getJobListWithUserAuth(
                                                            searchData,
                                                            filterCity,
                                                            filterCountry,
                                                            filterJobype);
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                16),
                                            color: AppColors.colorpurpal),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          child: Row(
                                            children: [
                                              Center(
                                                  child: Text(
                                                    filterJobype,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() async {
                                                      filterJobype = '';
                                                      if (tokenHeader
                                                          .toString() ==
                                                          'null') {
                                                        await getJobList(
                                                            searchData,
                                                            filterCity,
                                                            filterCountry,
                                                            filterJobype);
                                                      } else {
                                                        await getJobListWithUserAuth(
                                                            searchData,
                                                            filterCity,
                                                            filterCountry,
                                                            filterJobype);
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      )
                                    ] else
                                      if (fc == '' && fct != '' &&
                                          fjt != '') ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(16),
                                              color: AppColors.colorpurpal),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            child: Row(
                                              children: [
                                                Center(
                                                    child: Text(
                                                      filterCountry,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() async {
                                                        filterCountry = '';
                                                        if (tokenHeader
                                                            .toString() ==
                                                            'null') {
                                                          await getJobList(
                                                              searchData,
                                                              filterCity,
                                                              filterCountry,
                                                              filterJobype);
                                                        } else {
                                                          await getJobListWithUserAuth(
                                                              searchData,
                                                              filterCity,
                                                              filterCountry,
                                                              filterJobype);
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(16),
                                              color: AppColors.colorpurpal),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            child: Row(
                                              children: [
                                                Center(
                                                    child: Text(
                                                      filterJobype,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() async {
                                                        filterJobype = '';
                                                        if (tokenHeader
                                                            .toString() ==
                                                            'null') {
                                                          await getJobList(
                                                              searchData,
                                                              filterCity,
                                                              filterCountry,
                                                              filterJobype);
                                                        } else {
                                                          await getJobListWithUserAuth(
                                                              searchData,
                                                              filterCity,
                                                              filterCountry,
                                                              filterJobype);
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )
                                      ] else
                                        if (fc != '' && fct != '' &&
                                            fjt != '') ...[
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(16),
                                                color: AppColors.colorpurpal),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12, vertical: 8),
                                              child: Row(
                                                children: [
                                                  Center(
                                                      child: Text(
                                                        filterCity,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      )),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() async {
                                                          filterCountry = '';
                                                          if (tokenHeader
                                                              .toString() ==
                                                              'null') {
                                                            await getJobList(
                                                                searchData,
                                                                filterCity,
                                                                filterCountry,
                                                                filterJobype);
                                                          } else {
                                                            await getJobListWithUserAuth(
                                                                searchData,
                                                                filterCity,
                                                                filterCountry,
                                                                filterJobype);
                                                          }
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.white,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(16),
                                                color: AppColors.colorpurpal),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12, vertical: 8),
                                              child: Row(
                                                children: [
                                                  Center(
                                                      child: Text(
                                                        filterCountry,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      )),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() async {
                                                          filterCity = '';
                                                          if (tokenHeader
                                                              .toString() ==
                                                              'null') {
                                                            await getJobList(
                                                                searchData,
                                                                filterCity,
                                                                filterCountry,
                                                                filterJobype);
                                                          } else {
                                                            await getJobListWithUserAuth(
                                                                searchData,
                                                                filterCity,
                                                                filterCountry,
                                                                filterJobype);
                                                          }
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.white,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(16),
                                                color: AppColors.colorpurpal),
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 12, vertical: 8),
                                              child: Row(
                                                children: [
                                                  Center(
                                                      child: Text(
                                                        filterJobype,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      )),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() async {
                                                          filterJobype = '';
                                                          if (tokenHeader
                                                              .toString() ==
                                                              'null') {
                                                            await getJobList(
                                                                searchData,
                                                                filterCity,
                                                                filterCountry,
                                                                filterJobype);
                                                          } else {
                                                            await getJobListWithUserAuth(
                                                                searchData,
                                                                filterCity,
                                                                filterCountry,
                                                                filterJobype);
                                                          }
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.cancel_rounded,
                                                        color: Colors.white,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          )
                                        ]
                          ],
                        ),
                      ),
                    )
                  ],
                ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: jobsListDataWithAuth.isEmpty
                        ? jobsListData.length
                        : jobsListDataWithAuth.length,
                    itemBuilder: (context, index) {
                      var jobData;
                      var jobDataWithSession;
                      List isSaved = [];
                      String jobid;
                      if (jobsListDataWithAuth.isEmpty) {
                        jobData = jobsListData[index];
                        jobid = jobData["id"].toString();
                      } else {
                        jobDataWithSession = jobsListDataWithAuth[index];
                        isSaved = jobDataWithSession['jobs_saved'];
                        if (kDebugMode) {

                        }
                        jobid = jobDataWithSession["id"].toString();
                        if (kDebugMode) {

                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: jobsListDataWithAuth.isEmpty
                            ?
                        JobsCard(
                            buttonColor: ColorApp.colorprimary,
                            ontapsave: () {
                              if (tokenHeader.toString() == 'null') {
                                if (kDebugMode) {

                                }
                                showAlertDialogLogInFirst(
                                    context, "You are not logged in");
                              } else if (tokenHeader != 'null') {
                                if (kDebugMode) {
                                  print('beforeeeeeeeeeee');
                                  print(PostAddSaveJobController().jobseekerAddSaveJob(jobData['id'].toString(), context));
                                  print('afterrrrrrrrr');
                                }
                                if (PostAddSaveJobController().jobseekerAddSaveJob(jobData['id'].toString(), context) ==
                                    "null") {
                                  setState(() {

                                    PostAddSaveJobController()
                                        .jobseekerAddSaveJob(
                                        jobData['id'].toString(),
                                        context) ==
                                        [];
                                    if (kDebugMode) {

                                    }
                                  });
                                } else {
                                  if (kDebugMode) {

                                  }
                                }
                              }
                            },
                            ontapshare: () async {
                              dynamic name = jobData['title'].toString();
                              final result = name.replaceAll(
                                  RegExp('[^A-Za-z0-9]'), '-');
                              name.trim();

                              final url =
                                  '${'https://publish.jobs/${result}/${jobData['uuid']
                                  .toString()}'}';

                              await Share.share('${url}');
                            },
                            iconHeart: Icons.favorite_border,
                            heartColor: isDarkMode == true
                                ? Colors.grey
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
                            hoursShow: jobData["job_status"][0]["days_since_active"]
                                .toString() + "days ago",
                            image: jobData['business']['business_image']
                                .toString() !=
                                'null'
                                ? NetworkImage(
                                'https://api.publish.jobs/pjcloud/Business/' +
                                    jobData['business']
                                    ['business_image']['image']
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
                                  jobData['salary']['currency']
                                  ['currency_code']
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
                                      jobData['salary']['salary_type']
                                      ['title']
                                          .toString());
                              await prefs.setString(
                                  "postedTime",
                                  jobData["job_status"][0]["days_since_active"]
                                      .toString());
                              await prefs.setString(
                                  "imageUrl",
                                  jobData['business']['business_image']
                                      .toString() !=
                                      'null'
                                      ? 'https://api.publish.jobs/pjcloud/Business/' +
                                      jobData['business']
                                      ['business_image']
                                      ['image']
                                          .toString()
                                      : 'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg');

                              Navigator.of(context, rootNavigator: false).push(
                                  MaterialPageRoute(
                                      maintainState: true,
                                      builder: (context) =>
                                          JobDetail(
                                              daysAgo: jobData["job_status"][0]["days_since_active"]
                                                  .toString(),
                                              uUid: jobData['uuid'].toString(),
                                              id: jobData['id'].toString(),
                                              title:
                                              jobData['title'].toString(),
                                              bussinessName: jobData['business']
                                              ['name']
                                                  .toString())));
                            },
                            fullTime: jobData['jobtype_options'][0]['title']
                                .toString())
                            : JobsCard(
                            buttonColor: ColorApp.colorprimary,
                            ontapsave: () {
                              if (tokenHeader.toString() == 'null')
                              {
                                showAlertDialogLogInFirst(
                                    context, "You are not logged in");
                              }
                              else if (tokenHeader != 'null') {
                                if (isSaved.isEmpty) {
                                  PostAddSaveJobController()
                                      .jobseekerAddSaveJob(jobDataWithSession['id'].toString(), context);
                                  jobDataWithSession['jobs_saved'] = [
                                    'saved'
                                  ];
                                  Timer(Duration(seconds: 1), () {
                                    GlobalVarData.savedFuture =
                                        GetSavedJobsController().getSavedJobs();
                                  });

                                  setState(() {
                                    isSaved =
                                    jobDataWithSession['jobs_saved'];
                                  });

                                } else {
                                  PostRemoveSaveJobController()
                                      .jobseekerRemoveSaveJob(
                                      jobDataWithSession['id']
                                          .toString(),
                                      context);
                                  jobDataWithSession['jobs_saved'] = [
                                  ];

                                  Timer(const Duration(seconds: 1), () {
                                    GlobalVarData.savedFuture =
                                        GetSavedJobsController().getSavedJobs();

                                  });
                                  setState(() {
                                    isSaved =
                                    jobDataWithSession['jobs_saved'];
                                  });
                                }
                              }
                            },
                            ontapshare: () async {
                              dynamic name =
                              jobDataWithSession['title'].toString();
                              final result = name.replaceAll(
                                  RegExp('[^A-Za-z0-9]'), '-');
                              name.trim();

                              final url =
                                  '${'https://publish.jobs/${result}/${jobData['uuid']
                                  .toString()}'}';

                              await Share.share('${url}');
                            },
                            iconHeart: isSaved.isEmpty
                                ? Icons.favorite_border
                                : Icons.favorite,
                            heartColor: isSaved.isEmpty ? isDarkMode == true
                                ? Colors.grey
                                : Colors.grey : AppColors.colorprimary,
                            iconShare: Icons.share_outlined,
                            shareColor: isDarkMode == true
                                ? ColorApp.colorwhite
                                : ColorApp.colorblackgalf,
                            salaryShow: jobDataWithSession['salary']['currency']['currency_code']
                                .toString() + " " +
                                (jobDataWithSession['salary']['minimum']
                                    .toString()) + " - " +
                                (jobDataWithSession['salary']['maximum']
                                    .toString()) + " " + '/' + " " +
                                jobDataWithSession['salary']['salary_type']['title']
                                    .toString(),
                            hoursShow: jobDataWithSession["job_status"][0]["days_since_active"]
                                .toString() + "days ago",
                            image: jobDataWithSession['business']['business_image']
                                .toString() != 'null' ? NetworkImage(
                                'https://api.publish.jobs/pjcloud/Business/' +
                                    jobDataWithSession['business']['business_image']['image']
                                        .toString()) : NetworkImage(
                                'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg'),
                            cityName: jobDataWithSession['city_options'][0]['title']
                                .toString(),
                            JobName: jobDataWithSession['title'].toString(),
                            companyName: jobDataWithSession['business']['name']
                                .toString(),
                            buttonText: "Apply",
                            Ontap: () async {
                              final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setString("jobName",
                                  jobDataWithSession['title'].toString());
                              await prefs.setString("jobId", jobid);
                              await prefs.setString(
                                  "companyName",
                                  jobDataWithSession['business']['name']
                                      .toString());
                              await prefs.setString(
                                  "cityName",
                                  jobDataWithSession['city_options'][0]
                                  ['title']
                                      .toString());
                              await prefs.setString(
                                  "jobDescription",
                                  jobDataWithSession['jobtype_options'][0]
                                  ['title']);
                              await prefs.setString(
                                  "salaryShow",
                                  jobDataWithSession['salary']['currency']
                                  ['currency_code']
                                      .toString() +
                                      " " +
                                      (jobDataWithSession['salary']
                                      ['minimum']
                                          .toString()) +
                                      " - " +
                                      (jobDataWithSession['salary']
                                      ['maximum']
                                          .toString()) +
                                      " " +
                                      '/' +
                                      " " +
                                      jobDataWithSession['salary']
                                      ['salary_type']['title']
                                          .toString());
                              await prefs.setString(
                                  "postedTime",
                                  jobDataWithSession["job_status"][0]["days_since_active"]
                                      .toString() + "days ago");
                              await prefs.setString(
                                  "imageUrl",
                                  jobDataWithSession['business']
                                  ['business_image']
                                      .toString() !=
                                      'null'
                                      ? 'https://api.publish.jobs/pjcloud/Business/' +
                                      jobDataWithSession['business']
                                      ['business_image']
                                      ['image']
                                          .toString()
                                      : 'https://www.shutterstock.com/image-photo/pakistan-flag-on-background-mountain-260nw-2015186255.jpg');
                              Navigator.of(context, rootNavigator: false).push(

                                  MaterialPageRoute(
                                      maintainState: true,
                                      //settings:  RouteSettings(name: ''),
                                      builder: (context) =>
                                          JobDetail(
                                              daysAgo: jobDataWithSession["job_status"][0]["days_since_active"]
                                                  .toString(),
                                              image: profileImage,
                                              uUid: jobDataWithSession['uuid']
                                                  .toString(),
                                              id: jobDataWithSession['id']
                                                  .toString(),
                                              title: jobDataWithSession['title']
                                                  .toString(),
                                              bussinessName:
                                              jobDataWithSession['business']
                                              ['name']
                                                  .toString())
                                  ));
                            },
                            fullTime: jobDataWithSession['jobtype_options'][0]['title']
                                .toString()),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetCompany() {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
      child: Column(
        children: [


          Column(
            children: [
              FutureBuilder<AllCompanyListModel>(

                  future: getAllCompanyFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(12, 12, 20, 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: s.height * 0.05,
                                    child: Material(
                                      color: isDarkMode == true
                                          ? ColorApp.colorblackgalf.withOpacity(
                                          0.5)
                                          : ColorApp.colorwhite,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0)),
                                      elevation: 1,
                                      child: TextFormField(
                                        onFieldSubmitted: (value) async {
                                          companySearchData = value;
                                          getAllCompanyFuture =
                                              GetCompanyListController()
                                                  .getCompanyList(
                                                pagecompany,
                                                companySearchData.toString() ==
                                                    "null"
                                                    ? "No Company found"
                                                    : companySearchData
                                                    .toString(),


                                                // companyData.toString()=='null'?'':companyData.toString()
                                              );
                                        },
                                        onChanged: (data) {

                                        },
                                        textAlignVertical: TextAlignVertical
                                            .center,
                                        decoration: InputDecoration(
                                            hintText: 'Search Companies or Keywords',
                                            hintStyle: TextStyle(
                                                color: isDarkMode == false
                                                    ? ColorApp.colorblackgalf
                                                    : ColorApp.colorwhite
                                                    .withOpacity(0.8),
                                                fontSize: 12),
                                            prefixIcon: GestureDetector(
                                              onTap: () async {
                                                getAllCompanyFuture =
                                                    GetCompanyListController()
                                                        .getCompanyList(


                                                      pagecompany,
                                                      companySearchData
                                                          .toString() == "null"
                                                          ? "No Company found"
                                                          : companySearchData
                                                          .toString(),

                                                    );
                                              },
                                              child: Icon(
                                                Icons.search,
                                                color: isDarkMode == false
                                                    ? ColorApp.colorblackgalf
                                                    : ColorApp.colorwhite
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius
                                                    .circular(12))),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            height: s.height * 0.18,
                            width: s.width,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child:
                              Image.asset(
                                  ImangeAssests.companyImage, fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          GridView.builder(
                              controller: scrollcontrollerCompany,

                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 10),
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: s.height * 0.025,
                                crossAxisSpacing: 0,
                              ),
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (BuildContext ctx, index) {
                                print(pagecompany.toString() + "show pageq");
                                // String? industaryOption= snapshot.data!.data?[index].industryOptions![index].title.toString();
                                String? image = snapshot
                                    .data?.data?[index].businessImage?.image
                                    .toString();
                                String initialIndexes(String data,
                                    int? initialIndexesList) {
                                  var stringBuffer = StringBuffer();
                                  var wordCount = data.trim().split(' ');

                                  if (data.isEmpty) return data;

                                  if (wordCount.length <= 1) {
                                    return data.characters.first;
                                  }

                                  if (initialIndexesList != null &&
                                      initialIndexesList > wordCount.length) {
                                    for (var i = 0; i <
                                        wordCount.length; i++) {
                                      stringBuffer.write(wordCount[i][0]);
                                    }
                                    return stringBuffer.toString();
                                  }

                                  for (var i = 0;
                                  i < (initialIndexesList ??
                                      wordCount.length);
                                  i++) {
                                    stringBuffer.write(wordCount[i][0]);
                                  }
                                  return stringBuffer.toString();
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14, bottom: 0, right: 12),
                                  child: Material(
                                    color: isDarkMode == true
                                        ? ColorApp.colorblackgalf.withOpacity(
                                        0.5)
                                        : ColorApp.colorbackground,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: ColorApp.colorwhite,
                                          width: 1),
                                    ),
                                    elevation: 1,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: s.height * 0.02,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CompanyDetailScreen(
                                                        companyId: snapshot
                                                            .data!
                                                            .data![index].id
                                                            .toString(),

                                                        companyName: snapshot
                                                            .data!
                                                            .data![index].name
                                                            .toString(),
                                                        image:
                                                        'https://api.publish.jobs/pjcloud/Business/' +
                                                            image.toString(),
                                                        companyoption: snapshot
                                                            .data!
                                                            .data![index]
                                                            .industryOptions
                                                        !.isNotEmpty
                                                            ? snapshot
                                                            .data!
                                                            .data![index]
                                                            .industryOptions![0]
                                                            .title
                                                            .toString()
                                                            : '',
                                                        companywebsite: snapshot
                                                            .data!
                                                            .data![index]
                                                            .websites
                                                            .toString() ==
                                                            'null'
                                                            ? ''
                                                            : snapshot
                                                            .data!
                                                            .data![index]
                                                            .websites!
                                                            .website,
                                                      )),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Material(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    side: BorderSide(
                                                      color: ColorApp
                                                          .colorprimary
                                                          .withOpacity(0.4),
                                                    ),
                                                  ),
                                                  elevation: 1,
                                                  color: isDarkMode == true
                                                      ? ColorApp
                                                      .colorblackgalf
                                                      .withOpacity(0.5)
                                                      : ColorApp.colorwhite,
                                                  child: image.toString() !=
                                                      'null'
                                                      ? Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        5.0),
                                                    child: Container(
                                                        height:
                                                        s.height * 0.06,
                                                        width: s.width * 0.19,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              4.0),
                                                          child: Image
                                                              .network(
                                                              fit:
                                                              BoxFit.fill,
                                                              height:
                                                              s.height *
                                                                  0.08,
                                                              width: s.width *
                                                                  0.19,
                                                              'https://api.publish.jobs/pjcloud/Business/' +
                                                                  image!),
                                                        )),
                                                  )
                                                      : Container(
                                                      height: s.height * 0.06,
                                                      width: s.width * 0.19,
                                                      child: Center(
                                                          child: Container(
                                                            // decoration: BoxDecoration(
                                                            //     color: isDarkMode ==
                                                            //             true
                                                            //         ? ColorApp
                                                            //             .colorblackgalf
                                                            //             .withOpacity(
                                                            //                 0.5)
                                                            //         : ColorApp
                                                            //             .colorwhite,
                                                            //     borderRadius:
                                                            //         BorderRadius
                                                            //             .circular(
                                                            //                 4)),
                                                            height: s.width *
                                                                0.07,
                                                            width: s.width *
                                                                0.11,
                                                            child: Center(
                                                              child: Text(
                                                                initialIndexes(
                                                                    snapshot
                                                                        .data!
                                                                        .data![
                                                                    index]
                                                                        .name
                                                                        .toString(),
                                                                    5)
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    fontSize: 24,
                                                                    color: isDarkMode ==
                                                                        true
                                                                        ? AppColors
                                                                        .colorwhite
                                                                        : AppColors
                                                                        .colorgraydark),
                                                              ),
                                                            ),
                                                          ))),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10),
                                                            child: Text(
                                                              snapshot.data!
                                                                  .data![index]
                                                                  .name
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize: 12,
                                                                  color: isDarkMode ==
                                                                      true
                                                                      ? AppColors
                                                                      .colorwhite
                                                                      : AppColors
                                                                      .colorgraydark),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),

                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: s.width *
                                                        0.09,
                                                    vertical: 02),
                                                child: Row(
                                                  children: [
                                                    Text("4.5",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: isDarkMode ==
                                                                true
                                                                ? AppColors
                                                                .colorwhite
                                                                : ColorApp
                                                                .colorblackgalf,
                                                            fontWeight:
                                                            FontWeight.w300)),
                                                    Icon(
                                                      Icons.star,
                                                      size: 12,
                                                      color: ColorApp
                                                          .colorprimary,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 12,
                                                      color: ColorApp
                                                          .colorprimary,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 12,
                                                      color: ColorApp
                                                          .colorprimary,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 12,
                                                      color: ColorApp
                                                          .colorprimary,
                                                    ),
                                                    Icon(Icons.star,
                                                        size: 12,
                                                        color:
                                                        ColorApp.colordltbtn),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),

                                              Text(
                                                snapshot.data!.data![index]
                                                    .websites!.website
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: ColorApp
                                                      .colorprimary,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    Divider(
                                                      thickness: 0.5,
                                                      color:
                                                      ColorApp.colorblackgalf,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              size: 15,
                                                              Icons
                                                                  .location_on_outlined,
                                                              color: isDarkMode ==
                                                                  true
                                                                  ? ColorApp
                                                                  .colorwhite
                                                                  : ColorApp
                                                                  .colorblackgalf,
                                                            ),
                                                            Text(
                                                              "Pakistan",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: isDarkMode ==
                                                                      true
                                                                      ? ColorApp
                                                                      .colorwhite
                                                                      : ColorApp
                                                                      .colorblackgalf),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              snapshot.data!
                                                                  .data![index]
                                                                  .jobsCount
                                                                  .toString() ==
                                                                  "null"
                                                                  ? "0"
                                                                  : snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .jobsCount
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: ColorApp
                                                                      .colorprimary
                                                                      .withOpacity(
                                                                      0.8),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 3),
                                                              child: Text(
                                                                "Jobs",
                                                                style: TextStyle(
                                                                    color: ColorApp
                                                                        .colorprimary
                                                                        .withOpacity(
                                                                        0.8),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),

                        ],
                      );
                    }
                  }),


            ],
          )
        ],
      ),
    );
  }

  Widget widgetEmployer() {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
      child: Container(
        color:
        isDarkMode == true ? ColorApp.colornewblack : ColorApp.colorwhite,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    children: [
                      SizedBox(
                        height: s.height * 0.015,
                      ),
                      Text(
                        "Hassel Free Hiring with",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode == true
                                ? ColorApp.colorwhite
                                : ColorApp.colornewblack),
                      ),
                      SizedBox(
                        height: s.height * 0.005,
                      ),
                      Text(
                        "Publish Jobs",
                        style: TextStyle(
                            color: ColorApp.colorprimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 22.8),
                      ),
                      SizedBox(
                        height: s.height * 0.005,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 2),
                        child: Text(
                          "Publish Jobs easy to use tools lets you hire faster and save",
                          style: TextStyle(
                              color: isDarkMode == true
                                  ? ColorApp.colorbackground.withOpacity(0.8)
                                  : ColorApp.colornewblack.withOpacity(0.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        "Your time and money",
                        style: TextStyle(
                            color: isDarkMode == true
                                ? ColorApp.colorbackground.withOpacity(0.8)
                                : ColorApp.colornewblack.withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: s.height * 0.025,
                      ),
                      SubmitButton(
                          borderRadius: BorderRadius.circular(12),
                          textColor: Colors.white,
                          heightButton: s.height * 0.05,
                          widthButton: s.width * 0.45,
                          backGroundColor: ColorApp.colorprimary,
                          textButton: "Hire now",
                          onPressed: () {}),
                      SizedBox(
                        height: s.height * 0.025,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          "Shortlist",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: ColorApp.colorprimary),
                        ),
                      ),
                      Text(
                        "Use PJ'S default Staging and create",
                        style: TextStyle(
                            color: isDarkMode == true
                                ? ColorApp.colorbackground.withOpacity(0.8)
                                : ColorApp.colornewblack.withOpacity(0.7),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Your custom stages",
                        style: TextStyle(
                            color: isDarkMode == true
                                ? ColorApp.colorbackground.withOpacity(0.8)
                                : ColorApp.colornewblack.withOpacity(0.7),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: s.height * 0.035,
                      ),
                      SizedBox(
                        height: s.height * 0.20,
                        width: s.width,
                        child: isDarkMode == true
                            ? Image.asset(ImangeAssests.imagedarkApp,
                            fit: BoxFit.fill)
                            : Image.asset(ImangeAssests.picemp12,
                            fit: BoxFit.fill),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: s.height * 0.015,
                                      top: s.height * 0.02),
                                  child: Text(
                                    "Applicants",
                                    style: TextStyle(
                                        color: ColorApp.colorprimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "Experience the best way to hire ",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: isDarkMode == true
                                          ? ColorApp.colorbackground
                                          .withOpacity(0.8)
                                          : ColorApp.colornewblack
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "best telent using Publish jobs",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: isDarkMode == true
                                          ? ColorApp.colorbackground
                                          .withOpacity(0.8)
                                          : ColorApp.colornewblack
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: s.height * 0.015,
                                      top: s.height * 0.02),
                                  child: Text(
                                    "Organize Hiring",
                                    style: TextStyle(
                                        color: ColorApp.colorprimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "Experience the best way to hire ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                      color: isDarkMode == true
                                          ? ColorApp.colorbackground
                                          .withOpacity(0.8)
                                          : ColorApp.colornewblack
                                          .withOpacity(0.7)),
                                ),
                                Text(
                                  "to get perfact match",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: isDarkMode == true
                                          ? ColorApp.colorbackground
                                          .withOpacity(0.8)
                                          : ColorApp.colornewblack
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: s.height * 0.05,
                ),
                Container(
                  color: isDarkMode == true
                      ? Color(0xff787777).withOpacity(0.2)
                      : ColorApp.colorwhite,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: s.height * 0.06, bottom: s.height * 0.05),
                    child: Column(
                      children: [
                        Text(
                          "How Publish Jobs Work",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode == true
                                  ? ColorApp.colorwhite
                                  : ColorApp.colornewblack),
                        ),
                        SizedBox(
                          height: s.height * 0.03,
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: s.width * 0.055, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)))),
                                  child: Container(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode == true
                                                ? ColorApp.colornewblack
                                                : ColorApp.colorwhite,
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: SizedBox(
                                                height: s.height * 0.04,
                                                width: s.width * 0.27,
                                                child: Image.asset(
                                                  ImangeAssests.joboffer,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                "Post a jobs",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : ColorApp
                                                        .colorblackgalf),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      height: s.height * 0.099,
                                      width: s.width * 0.280,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.orange,
                                              width: 3,
                                            ),
                                            left: BorderSide(
                                                width: 3, color: Colors.orange),
                                          )))),
                              ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)))),
                                  child: Container(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode == true
                                                ? ColorApp.colornewblack
                                                : ColorApp.colorwhite,
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: SizedBox(
                                                height: s.height * 0.04,
                                                width: s.width * 0.27,
                                                child: Image.asset(
                                                  ImangeAssests.picman,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                "Create Profile",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : ColorApp
                                                        .colorblackgalf),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      height: s.height * 0.099,
                                      width: s.width * 0.280,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.red,
                                              width: 3,
                                            ),
                                            left: BorderSide(
                                              width: 3,
                                              color: Colors.red,
                                            ),
                                          )))),
                              ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)))),
                                  child: Container(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode == true
                                                ? ColorApp.colornewblack
                                                : ColorApp.colorwhite,
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: SizedBox(
                                                height: s.height * 0.04,
                                                width: s.width * 0.27,
                                                child: Image.asset(
                                                  ImangeAssests.picbuilding,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                "Create Company",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : ColorApp
                                                        .colorblackgalf),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      height: s.height * 0.099,
                                      width: s.width * 0.280,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ColorApp.colorprimary,
                                              width: 3,
                                            ),
                                            left: BorderSide(
                                              width: 3,
                                              color: ColorApp.colorprimary,
                                            ),
                                          )))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: s.height * 0.05,
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: s.width * 0.055, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)))),
                                  child: Container(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode == true
                                                ? ColorApp.colornewblack
                                                : ColorApp.colorwhite,
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: SizedBox(
                                                height: s.height * 0.04,
                                                width: s.width * 0.27,
                                                child: Image.asset(
                                                  ImangeAssests.network,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                "Promote a Jobs",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : ColorApp
                                                        .colorblackgalf),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      height: s.height * 0.099,
                                      width: s.width * 0.280,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.deepPurple,
                                              width: 3,
                                            ),
                                            left: BorderSide(
                                              width: 3,
                                              color: Colors.deepPurple,
                                            ),
                                          )))),
                              ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)))),
                                  child: Container(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode == true
                                                ? ColorApp.colornewblack
                                                : ColorApp.colorwhite,
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: SizedBox(
                                                height: s.height * 0.04,
                                                width: s.width * 0.27,
                                                child: Image.asset(
                                                  ImangeAssests.approve,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                "Get Jobs Preview",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : ColorApp
                                                        .colorblackgalf),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      height: s.height * 0.099,
                                      width: s.width * 0.280,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ColorApp.colorprimary,
                                              width: 3,
                                            ),
                                            left: BorderSide(
                                              width: 3,
                                              color: ColorApp.colorprimary,
                                            ),
                                          )))),
                              ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)))),
                                  child: Container(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode == true
                                                ? ColorApp.colornewblack
                                                : ColorApp.colorwhite,
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: SizedBox(
                                                height: s.height * 0.04,
                                                width: s.width * 0.27,
                                                child: Image.asset(
                                                  ImangeAssests.place,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                "Multipal location",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorwhite
                                                        : ColorApp
                                                        .colorblackgalf),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      height: s.height * 0.099,
                                      width: s.width * 0.280,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ColorApp.colorblackgalf,
                                              width: 3,
                                            ),
                                            left: BorderSide(
                                              width: 3,
                                              color: ColorApp.colorblackgalf,
                                            ),
                                          )))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: s.height * 0.075),
                  child: Column(
                    children: [
                      Text(
                        "Employer Branding",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode == true
                                ? ColorApp.colorwhite
                                : ColorApp.colornewblack),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 2),
                        child: Text(
                          "Add your Company details and business locations for",
                          style: TextStyle(
                              color: isDarkMode == true
                                  ? ColorApp.colorbackground.withOpacity(0.8)
                                  : ColorApp.colornewblack.withOpacity(0.7),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        "Employer Branding",
                        style: TextStyle(
                            color: isDarkMode == true
                                ? ColorApp.colorbackground.withOpacity(0.8)
                                : ColorApp.colornewblack.withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: s.height * 0.025,
                      ),
                      SubmitButton(
                          borderRadius: BorderRadius.circular(12),
                          textColor: Colors.white,
                          heightButton: s.height * 0.05,
                          widthButton: s.width * 0.45,
                          backGroundColor: ColorApp.colorprimary,
                          textButton: "Create Company",
                          onPressed: () {}),
                      SizedBox(
                        height: s.height * 0.025,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          child: isDarkMode == true
                              ? Image.asset(
                            ImangeAssests.imageempbrand,
                          )
                              : Image.asset(
                            ImangeAssests.jobbrand,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: s.height * 0.036,
                ),
                Container(
                  color: isDarkMode == true
                      ? Color(0xff787777).withOpacity(0.2)
                      : ColorApp.colorwhite,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: s.height * 0.02),
                    child: Column(
                      children: [
                        SizedBox(
                          height: s.height * 0.035,
                        ),
                        Text(
                          "Post a job is Now Easy",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode == true
                                  ? ColorApp.colorwhite
                                  : ColorApp.colornewblack),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(top: s.height * 0.018, bottom: 2),
                          child: Text(
                            "Experiencs the best way to hire best telent using publish jobs",
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? ColorApp.colorbackground.withOpacity(0.8)
                                    : ColorApp.colornewblack.withOpacity(0.7),
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, bottom: 0),
                          child: Text(
                            "Use PJ's Default staging and create your custom stage to shortlist",
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? ColorApp.colorbackground.withOpacity(0.8)
                                    : ColorApp.colornewblack.withOpacity(0.7),
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          "and Organize your hiring ",
                          style: TextStyle(
                              color: isDarkMode == true
                                  ? ColorApp.colorbackground.withOpacity(0.8)
                                  : ColorApp.colornewblack.withOpacity(0.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: s.height * 0.025,
                        ),
                        SubmitButton(
                            borderRadius: BorderRadius.circular(12),
                            textColor: Colors.white,
                            heightButton: s.height * 0.05,
                            widthButton: s.width * 0.45,
                            backGroundColor: ColorApp.colorprimary,
                            textButton: "Post a Jobs",
                            onPressed: () {}),
                        Padding(
                          padding: EdgeInsets.only(
                              left: s.width * 0.06,
                              right: s.width * 0.06,
                              top: s.height * 0.045,
                              bottom: s.height * 0.05),
                          child: Image.asset(
                            ImangeAssests.image1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.036,
                ),
                Column(
                  children: [
                    Text(
                      "Promote Your Jobs",
                      style: TextStyle(
                          color: isDarkMode == true
                              ? ColorApp.colorwhite
                              : ColorApp.colorblack,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Promote Your Jobs on our platform for",
                      style: TextStyle(
                          color: isDarkMode == true
                              ? ColorApp.colorbackground.withOpacity(0.8)
                              : ColorApp.colornewblack.withOpacity(0.7),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "more result",
                      style: TextStyle(
                          color: isDarkMode == true
                              ? ColorApp.colorbackground.withOpacity(0.8)
                              : ColorApp.colornewblack.withOpacity(0.7),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SubmitButton(
                        borderRadius: BorderRadius.circular(12),
                        textColor: Colors.white,
                        heightButton: s.height * 0.05,
                        widthButton: s.width * 0.45,
                        backGroundColor: AppColors.colorprimary,
                        textButton: "Promote Jobs",
                        onPressed: () {}),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: s.height * 0.03, right: 10),
                      child: isDarkMode == true
                          ? Container(
                        child: Image.asset(ImangeAssests.darkcompanyep5,
                            fit: BoxFit.fill),
                      )
                          : Container(
                        child: Image.asset(ImangeAssests.companyep5,
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, id, title, businessName) {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    ABD abd = ABD();
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery
        .of(context)
        .size;
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
                  onTap: () {},
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

  showAlertDialogLogInFirst(BuildContext context, String text) {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    ABD abd = ABD();
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery
        .of(context)
        .size;
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
                                builder: (context) =>
                                    LogInScreen(
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
                    Get.to(LogInScreen(
                      checkNav: 'jobsScreen',
                    ));
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

// @override
// // TODO: implement wantKeepAlive
// bool get wantKeepAlive => throw UnimplementedError();
}
