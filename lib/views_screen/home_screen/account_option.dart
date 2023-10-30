import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../App Services/global_vars.dart';
import '../../Network Controller/General Controllers/user_available_country_controller.dart';
import '../../Network Controller/Home Get Apis/get_socila_link_controller.dart';
import '../../Network Controller/Home Post Apis/post_register_api_withsession_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_country_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobseeker_gender_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_personal_Info_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_add_personal_info_controller.dart';
import '../../Network Controller/UpdatePassword Controller/updata_password_controller.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/country_list_model.dart';
import '../../model/cuntom_user_profile_model.dart';
import '../../model/job_seeker_gender_model.dart';
import '../../model/profile_personal_info_model.dart';
import '../../model/user_available_country_model.dart';
import '../../utils/app_color.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../widgets/appbar_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';

class AccountOption extends StatefulWidget {
  String? firstName;
  String? lastName;
  String? profileImage;
  String? profileCity;
  String? imageLink;
  String? email;
  String? mobile;
   AccountOption({Key? key, this.firstName,
    this.lastName,
    this.profileImage,
    this.profileCity,
    this.email,
    this.mobile,
    this.imageLink}) : super(key: key);

  @override
  State<AccountOption> createState() => _AccountOptionState();
}

class _AccountOptionState extends State<AccountOption>
    with TickerProviderStateMixin {
  String? countryId;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? profileCity;
  String? imageLink;
  bool _obscureText = true;
  bool _obscureText2 = true;
  String? email;
  String? citySelection;
  List uesrCountryList = [];
  String? countrySelection;
  final String urlCountry = "https://api.publish.jobs/api/userAvailableCountry";
  Future<ProfilePersonalInfoModel>? personalInfoFuture;
  final String urlSocialLick = "https://api.publish.jobs//api/social-option-get";
  String? countrySelectionAll;
  List countryList = ['lahore'];
  String newFirstName = '';
  String newLastName = '';
  String newPhonNumber = '';
  String FirstName = '';
  String? LastName = '';
  String? mobile;
  String phonNumber = '';
  String _password = '';
  String _confirmPassword = '';
  String? degreeEducation;
  String? sociallink;

  String? degreeId;
  dynamic? socialId;


  List educationListData = [];

  Future<String> getDegreesList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse('https://api.publish.jobs/api/degrees'),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      educationListData = resBody;
    });
    //print(resBody);
    return "Sucess";
  }

  static Future<List<JobSeekerGenderModel>>? genderListFuture;
  late TabController _tabController;
  FocusNode _textFieldFocus = FocusNode();
  FocusNode _textFieldFocus1 = FocusNode();
  FocusNode _textFieldFocus2 = FocusNode();
  FocusNode _textFieldFocus3 = FocusNode();
  Color _color = Color(0xff343434);
  Color _color1 = Color(0xff343434);
  Color _color2 = Color(0xff343434);
  Color _color3 = Color(0xff343434);
  bool isIconVisible = false;
  List countryListData = [];
  bool isIconVisibleNewPassword = false;
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
    print(resBody);
    return "Sucess";
  }

  bool isAppbar = true;

  String? mobile_code;
  String? mobile_code1;


  // final String urlCity = "https://api.publish.jobs/api/country-cities?country=$countryId";


  // Future<List<CountriesListModel>>? countriesListFuture;


  String? countryName;
  String? countryNameAvailable;
  List countryListDataall = [];

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

          setState(() {
            firstName = data['user_info']['first_name'].toString();
            lastName = data['user_info']['last_name'].toString();
          });

          if (data['user_image'].toString() != 'null') {
            profileImage = (data['user_image']['image'] ?? '');
          }
          countryName = data['country_option'][0]['title'];
          uesrCountryList = data['country_option'];
          if (uesrCountryList.isNotEmpty) {
            uesrCountryList.add(data['country_option'][0]['title']);
          }
          if (data['user_mobile'].toString() != 'null') {
            mobile = (data['user_mobile']['mobile'] ?? 'null');
          }
          mobile_code1 = data["user_mobile"]["country_mob_code"]["code"];
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
  // Future<String> getCountryListData() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String tokenHeader = await pref.getString('tokenProvider').toString();
  //   Map<String, String> requestHeaders = {
  //     'Authorization': 'Bearer ' + tokenHeader
  //   };
  //   var res = await http.get(
  //     Uri.parse("https://api.publish.jobs/api/countries"),
  //     headers: requestHeaders,
  //   );
  //   var resBody = json.decode(res.body) as List;
  //   setState(() {
  //     countryListDataall = resBody;
  //   });
  //   print(resBody.toString() + "gggggggggggg");
  //   return "Sucess";
  // }

  @override
  void initState() {
    this.getCountryList();
    this.getDegreesList();
    this.getCountryList();
    getCountryListData();
    // this.getSocialLink();

    // this.getSocialList();
    // TODO: implement initState
    getProfilePersonalInfo();
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
    GlobalVarData.genderListFuture =
        GetJobSeekerGenderController().getJobSeekerGender();

    // GlobalVarData.personalApplayFuture =
    //     GetPersonalInfoController().jobSeekerPersonalInfo();
    // GetCountryListController().getCountriesList();


    //countriesListFuture=DataServices().getCountriesList;
    //this.postCityList();
  }

  String? _selectedItem;
  String? _dropdownError;

  _validateForm() {
    bool _isValid = _formKey.currentState!.validate();
    if (_selectedItem == null) {
      setState(() => _dropdownError = "Please select an option!");
      _isValid = false;
    }
    if (_isValid) {
      //form is valid
    }
  }
  List socialListData = [];
  Future<String> getCountryListData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse("https://api.publish.jobs/api/countries"),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body) as List;
    setState(() {
      countryListDataall = resBody;
    });
    print(resBody.toString() + "gggggggggggg");
    return "Sucess";
  }
  Future<String> getSocialLink() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse('https://api.publish.jobs/api/social-option-get'),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      socialListData = resBody;
    });
    print(resBody+"show list");
    return "Sucess";
  }

  List socialLink = ["google", "facebook", "skype"];
  String? _dropDownValue;
  bool selectedLink = false;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPassWordController = TextEditingController();
  TextEditingController conFormPasswordController = TextEditingController();
  String? firstNameinit;
  String? lastNameinit;
  String? countryinit;
  String? mobileinit;
  @override
  Widget build(BuildContext context) {

    firstNameinit=firstName==null?"":firstName.toString();
    lastNameinit=lastName==null?"":lastName.toString();
    mobileinit=mobile==null?"":mobile.toString();
    print(socialListData.length.toString()+"socail links");
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
          AppBarShow(profileImage: widget.profileImage),
        ],
      ),
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [


            FutureBuilder(
                future: GlobalVarData.personalInfoFuture,
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: s.height * 0.025),
                          child: CircleAvatar(
                            radius: 33,
                            backgroundImage:widget.profileImage.toString() != 'null'
                                ? NetworkImage(
                                'https://api.publish.jobs/pjcloud/userAccountImage/' +
                                  widget.profileImage!)
                                : NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                            child: Stack(children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 2, right: 2),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.white70,
                                    child: Icon(CupertinoIcons.camera,
                                        color: ColorApp.colorprimary, size: 12),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (widget.firstName.toString() == 'null'
                                  ? ''
                                  : widget.firstName.toString()  + " ") +
                                  (widget.lastName.toString() == 'null'
                                      ? ''
                                      : widget.lastName.toString() + " "),
                              style: TextStyle(
                                color: isDarkMode == true
                                    ? Colors.white
                                    : AppColors.colordark,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                         widget. email ?? ''.toString(),
                          style: TextStyle(
                            color: isDarkMode == true
                                ? ColorApp.colorbackground.withOpacity(0.9)
                                : AppColors.colordark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border:
                              Border.all(width: 1, color: Colors.white)),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.colorgray,
                            backgroundImage:widget.profileImage.toString() != 'null'
                                ? NetworkImage(
                                'https://api.publish.jobs/pjcloud/userAccountImage/' +
                                    widget.profileImage.toString())
                                : NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                            widget.  firstName ??
                                  '' + " " + (widget.lastName ?? 'ggg').toString(),
                              style: TextStyle(
                                color: isDarkMode == true
                                    ? Colors.white
                                    : AppColors.colordark,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(widget.email.toString())
                      ],
                    );
                  }
                }),
            Container(
              height: s.height,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: ColorApp.colorblackgalf,
                              ),
                            )),
                        child: TabBar(
                          labelPadding: EdgeInsets.only(
                            right: s.width * 0.099,
                          ),
                          labelColor: AppColors.colorpurpal,
                          isScrollable: true,
                          // add this property
                          unselectedLabelColor: isDarkMode == false
                              ? ColorApp.colorblackgalf
                              : ColorApp.colorwhite.withOpacity(0.8),
                          indicatorColor: AppColors.colorpurpal,
                          indicatorPadding: EdgeInsets.only(
                            right: 0,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "General",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Change Password",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.only(left: 17),
                                child: Text(
                                  "Social links",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          controller: _tabController,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        widgetGeneral(),


                        widgetChangePassword(),
                        widgetSocialLink(),
                      ],
                      controller: _tabController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//General widget used in data
  Widget widgetGeneral() {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: s.height * 0.016,
              ),
              Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(
                      left: s.width*0.04,
                      right: 2,
                      top: 8,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: s.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Personal Information",
                                style: TextStyle(
                                    color: isDarkMode == false
                                        ? ColorApp.colorblackgalf
                                        .withOpacity(0.7)
                                        : ColorApp.colorwhite.withOpacity(0.68),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ProfileFormField(
                            key: Key(firstNameinit.toString()),
                            initialName: firstNameinit.toString(),
                            hintText: "Please Enter First Name",
                            image: ImangeAssests.personImg,
                            mustText: '',
                            onValidate: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter first Name';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                newFirstName = val;
                              });
                            },

                            icon: Icons.person_outline,
                            textName: "first Name",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ProfileFormField(
                            key: Key(lastNameinit.toString()),
                            image: ImangeAssests.personImg,
                            mustText: '',
                            onValidate: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter last Name';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                newLastName = val;
                                print('object');
                              });
                            },
                            hintText: "Please Enter Last Name",
                            initialName:lastNameinit,
                            icon: Icons.person_outline,
                            textName: "Last Name",
                          ),
                        ),
                        FutureBuilder<List<UserAvailableCountryModel>>(
                            future: UserAvailableCountryController()
                                .userAvailableCountry(),
                            builder: (context, snapshot) {
                              var arrayLengh = snapshot.data?.length ?? 0;
                              for (var i = 0; i < arrayLengh; i++) {
                                countryList.add(snapshot.data![i].title);
                                countryNameAvailable =
                                    snapshot.data![i].title.toString();
                                print(countryNameAvailable.toString() +
                                    "show countrt");
                              }

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: isDarkMode == false
                                                ? ColorApp.colorblackgalf
                                                : ColorApp.colorwhite
                                                .withOpacity(0.7),
                                            size: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3, right: 2),
                                            child: Text(
                                              'Country',
                                              style: TextStyle(
                                                  color: isDarkMode == false
                                                      ? ColorApp.colorblackgalf
                                                      : ColorApp.colorwhite
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 13),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                          color: isDarkMode == true
                                              ? Color(0xff343434)
                                              : Colors.white,
                                          border: Border.all(
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                  .withOpacity(0.3)
                                                  : Colors.black54
                                                  .withOpacity(0.3))),
                                      height: s.height * 0.0579,
                                      child: DropdownButton(
                                        icon: Padding(
                                          padding:
                                          const EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 30,
                                          ),
                                        ),
                                        dropdownColor: isDarkMode == false
                                            ? ColorApp.colorblackgalf
                                            : ColorApp.colorblackgalf,
                                        elevation: 1,
                                        isExpanded: true,
                                        underline: Container(
                                          color: AppColors.colorblue,
                                        ),
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            countryNameAvailable==null?'':countryNameAvailable.toString(),
                                            style: TextStyle(
                                                color: isDarkMode == true
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                        value: countrySelection,
                                        onChanged: (v) {
                                          int? countryIndex;
                                          int se = countryListData.indexWhere(
                                                  (item) => item["title"] == v);
                                          setState(() {
                                            _selectedItem = v as String?;
                                            _dropdownError = null;
                                            citySelection = null;
                                            countrySelection = v as String;
                                            countryIndex =
                                                countryListData.indexOf(v);
                                            //countryId = (index!+1).toString();
                                            for (var i = 0;
                                            i < arrayLengh;
                                            i++) {
                                              if (snapshot.data![i].title ==
                                                  v) {
                                                print('id country');
                                                countryId = snapshot.data![i].id
                                                    .toString();

                                                print(countryId.toString() +
                                                    'country idd');
                                              }
                                            }
                                          });
                                        },
                                        items: countryListData.map((v) {
                                          return DropdownMenuItem(
                                            value: v['title'],
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                v['title'],
                                                style: TextStyle(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colornewblack
                                                        : ColorApp.colorwhite),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 6, bottom: 5),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 4, top: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.email_outlined,
                                      color: isDarkMode == false
                                          ? ColorApp.colorblackgalf
                                          : ColorApp.colorwhite
                                          .withOpacity(0.7),
                                      size: 17,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Text(
                                        "Email Address",
                                        style: TextStyle(
                                            color: isDarkMode == false
                                                ? ColorApp.colorblackgalf
                                                : ColorApp.colorwhite
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(
                                          color: isDarkMode == false
                                              ? ColorApp.colorblackgalf
                                              : ColorApp.colorwhite
                                              .withOpacity(0.9),
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 13, top: 7, bottom: 4),
                                child: TextFormField(
                                    enabled: false,
                                    initialValue: email,
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? ColorApp.colorprimary
                                            .withOpacity(0.8)
                                            : ColorApp.colorprimary
                                            .withOpacity(0.8)),
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: isDarkMode == true
                                                  ? ColorApp.colorprimary
                                                  .withOpacity(0.8)
                                                  : ColorApp.colorprimary
                                                  .withOpacity(0.8))),
                                      filled: true,
                                      fillColor: isDarkMode == true
                                          ? Color(0xff343434)
                                          : Colors.white,
                                      hintText: email,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: isDarkMode == true
                                                  ? ColorApp.colorprimary
                                                  .withOpacity(0.8)
                                                  : ColorApp.colorprimary
                                                  .withOpacity(0.8))),
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: isDarkMode == true
                                              ? ColorApp.colorprimary
                                              : ColorApp.colorprimary,
                                          fontWeight: FontWeight.w300),
                                      contentPadding: EdgeInsets.only(
                                          left: 10.0,
                                          top: 13.0,
                                          bottom: 13.0,
                                          right: 10),
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: isDarkMode == true
                                                ? ColorApp.colorprimary
                                                .withOpacity(0.8)
                                                : ColorApp.colorprimary
                                                .withOpacity(0.8)),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: s.width * 0.31,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: s.height * 0.03, right: 13),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: isDarkMode == true
                                          ? Color(0xff343434)
                                          : Colors.white,
                                      border: Border.all(
                                          color: isDarkMode == true
                                              ? Colors.white.withOpacity(0.3)
                                              : Colors.black54
                                              .withOpacity(0.3))),
                                  height: s.height * 0.0579,
                                  child: DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 15,
                                      ),
                                    ),
                                    dropdownColor: isDarkMode == false
                                        ? ColorApp.colorblackgalf
                                        : ColorApp.colorblackgalf,
                                    elevation: 1,
                                    isExpanded: true,
                                    underline: Container(
                                      color: AppColors.colorblue,
                                    ),
                                    onChanged: (v) {
                                      print(v.toString() + "show id of data");
                                      setState(() {
                                        countrySelectionAll = v as String?;
                                        mobile_code = v;
                                      });
                                    },
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        mobile_code1 == null
                                            ? ' select code'
                                            : mobile_code1.toString(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: isDarkMode == true
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    value: countrySelectionAll,
                                    items: countryListDataall.map((v) {
                                      return DropdownMenuItem(
                                        value: v['id'].toString(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                v['code'],
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: isDarkMode == false
                                                        ? ColorApp.colornewblack
                                                        : ColorApp.colorwhite),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: s.height * 0.03, right: 10),
                                  child: TextFormField(
                                      key: Key(mobileinit.toString()),
                                      maxLength: 10,
                                      style: TextStyle(
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black.withOpacity(0.71),
                                      ),
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      validator: (val) {
                                        // if (val == null || val.isEmpty) {
                                        //   return 'Please enter  number';
                                        // }
                                        // if (val.length < 10) {
                                        //   return 'Please enter valid number';
                                        // }
                                        // return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) {
                                        setState(() {
                                          newPhonNumber = val;
                                          print('object');
                                        });
                                      },
                                      initialValue: mobileinit,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorApp.colorprimary),
                                        ),
                                        filled: true,
                                        fillColor: isDarkMode == true
                                            ? Color(0xff343434)
                                            : Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: isDarkMode == true
                                                    ? Colors.white.withOpacity(0.3)
                                                    : Colors.black54
                                                    .withOpacity(0.3))),
                                        hintText: "Please Enter Number",
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: isDarkMode == true
                                                ? AppColors.colorwhite
                                                .withOpacity(0.69)
                                                : Colors.grey,
                                            fontWeight: FontWeight.w300),
                                        contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            top: 13.0,
                                            bottom: 13.0,
                                            right: 10),
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                        ),
                                      )),
                                )

                              // ProfileFormField(
                              //
                              //   mustText: '',
                              //   hintText: '',
                              //   onValidate: (val) {
                              //     if (val == null || val.isEmpty) {
                              //       return 'Please enter first number';
                              //     }
                              //     return null;
                              //   },
                              //   keyBordType: TextInputType.number,
                              //   onChanged: (val) {
                              //     setState(() {
                              //       newPhonNumber = val;
                              //       print('object');
                              //       print(widget.firstName! + 'firstname');
                              //     });
                              //   },
                              //   initialName: ,
                              //
                              //
                              // ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Row(

                        children: [
                          Padding(
                            padding:  EdgeInsets.only( ),
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
                                textButton: "Cancel",
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: s.width*0.22),
                            child: Consumer<PostAddPersonalInfoController>(
                              builder: (context, val, child) {
                                return    Center(
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    color: ColorApp.colorprimary,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(6),
                                        splashColor:
                                        AppColors.colorindigo.withOpacity(0.8),
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            val.jobSeekerAddPersonalInfo(
                                                newFirstName == ''
                                                    ? firstNameinit.toString()
                                                    : newFirstName,
                                                newLastName == ''
                                                    ? lastNameinit.toString()
                                                    : newLastName,
                                                countryId.toString() ==
                                                    'null'
                                                    ? ''
                                                    : countryId.toString(),
                                                newPhonNumber == ''
                                                    ? mobileinit.toString()
                                                    : newPhonNumber,
                                                mobile_code.toString() == ''
                                                    ? mobile_code1
                                                    .toString()
                                                    : mobile_code
                                                    .toString(),
                                                context);

                                          }
                                        },
                                        child: Container(
                                            height: s.height * 0.05,
                                            width: s.width * 0.36,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3)),
                                            child: Center(
                                                child: Text(
                                                  "Saves Changes",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: isDarkMode == false
                                                          ? AppColors.colorwhite
                                                          : Colors.white),
                                                )))),
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget widgetChangePassword() {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Column(
      children: [
        Form(
          key: _formKey2,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: s.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(left: s.width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Confirm it's you",
                        style: TextStyle(
                          color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.01,
                      ),
                      Text(
                        "Change your password you need to add you current password first",
                        style: TextStyle(
                            color: isDarkMode == true
                                ? ColorApp.colorwhite
                                : ColorApp.colorblackgalf),
                      ),
                      SizedBox(
                        height: s.height * 0.01,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            color: isDarkMode == true
                                ? Colors.white.withOpacity(0.8)
                                : Colors.grey,
                          ),
                          Container(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 0.25,
                                sigmaY: 0.25,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Current Password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode == true
                                        ? ColorApp.colorbackground
                                        .withOpacity(0.8)
                                        : ColorApp.colorblackgalf,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(right: 6),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(color: ColorApp.colorprimary,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                ),
                Consumer<UpdatePasswordController>(
                  builder: (context, val, child) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              //try this
                              value.isNotEmpty
                                  ? setState(() => isIconVisible = true)
                                  : setState(() => isIconVisible = false);
                              //or

                              //the result is the same it's just a shortcode
                            },
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter current password ';
                              }

                              return null;
                            },
                            style: TextStyle(
                              color: isDarkMode == true
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.71),
                            ),
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 13,color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf),
                                hintText: "Type Your Current Password*",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: isDarkMode == true
                                            ? Colors.white.withOpacity(0.3)
                                            : Colors.black54.withOpacity(0.3))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                contentPadding: EdgeInsets.fromLTRB(
                                    s.width * 0.06, 10, 10, 0),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 13),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: isIconVisible == true
                                        ? Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: isDarkMode == true
                                          ? Colors.grey
                                          : AppColors.colorpurpal,
                                    )
                                        : Text(""),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorApp.colorprimary))),
                          ),
                          if (val.invelidPassword == 'invalid password') ...[
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: s.width * 0.15, top: 6),
                                  child: Text(
                                    "Please enter Current Password Correct",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          ] else ...[
                            const SizedBox()
                          ],
                          Padding(
                            padding: EdgeInsets.only(left: s.width * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: s.height * 0.01,
                                ),
                                Text(
                                  "Enter New Password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblack
                                  ),
                                ),
                                SizedBox(
                                  height: s.height * 0.01,
                                ),
                                Text(
                                  "Create a new password that is at least 8 characters long and should include a combination of numbers, letters and special characters",
                                  style: TextStyle(
                                      color: isDarkMode == true
                                          ? ColorApp.colorwhite
                                          : ColorApp.colorblackgalf),
                                ),
                                SizedBox(
                                  height: s.height * 0.01,
                                ),
                              ],
                            ),
                          ),

                          // Visibility(
                          //     visible: val.isIncorrectPassWord == true,
                          //     child: Text("error"))
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: isDarkMode == true
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey,
                      ),
                      Container(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 0.25,
                            sigmaY: 0.25,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "NewPassword",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMode == true
                                    ? ColorApp.colorbackground.withOpacity(0.8)
                                    : ColorApp.colorblackgalf,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    onChanged: (value) {
                      _password = value;
                      value.isNotEmpty
                          ? setState(() => isIconVisibleNewPassword = true)
                          : setState(() => isIconVisibleNewPassword = false);
                    },
                    controller: newPassWordController,
                    obscureText: _obscureText2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter newPassword password';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: isDarkMode == true
                          ? Colors.white
                          : Colors.black.withOpacity(0.71),
                    ),
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                            icon: isIconVisibleNewPassword == true
                                ? Icon(
                              _obscureText2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: isDarkMode == true
                                  ? Colors.grey
                                  : AppColors.colorpurpal,
                            )
                                : Text(""),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: isDarkMode == true
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.black54.withOpacity(0.3))),
                        hintText: "Please enter new Password",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: isDarkMode == true
                                ? AppColors.colorwhite.withOpacity(0.69)
                                : Colors.grey,
                            fontWeight: FontWeight.w300),
                        contentPadding:
                        EdgeInsets.fromLTRB(s.width * 0.06, 10, 10, 0),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: ColorApp.colorprimary))),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: isDarkMode == true
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey,
                      ),
                      Container(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 0.25,
                            sigmaY: 0.25,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Confirm Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMode == true
                                    ? ColorApp.colorbackground.withOpacity(0.8)
                                    : ColorApp.colorblackgalf,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    obscureText: _obscureText2,
                    controller: conFormPasswordController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Confirm password';
                      }
                      if (value != _password) {
                        return 'Confirm password not matching';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: isDarkMode == true
                          ? Colors.white
                          : Colors.black.withOpacity(0.71),
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: isDarkMode == true
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.black54.withOpacity(0.3))),
                        hintText: "Corfirm Password",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: isDarkMode == true
                                ? AppColors.colorwhite.withOpacity(0.69)
                                : Colors.grey,
                            fontWeight: FontWeight.w300),
                        contentPadding:
                        EdgeInsets.fromLTRB(s.width * 0.06, 10, 10, 0),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: ColorApp.colorprimary))),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: s.height * 0.03, left: 0, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 3, left: 4),
                child: SubmitButton(
                    border: Border.all(
                        color: isDarkMode == false
                            ? AppColors.colorblack
                            : Colors.white.withOpacity(0.3)),
                    textColor: isDarkMode == true
                        ? AppColors.colorwhite
                        : AppColors.colorblack,
                    backGroundColor:
                    isDarkMode == true ? Color(0xff343434) : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    heightButton: s.height * 0.05,
                    widthButton: s.width * 0.30,
                    textButton: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Consumer<UpdatePasswordController>(
                builder: (context, val, child) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Center(
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: ColorApp.colorprimary,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            splashColor: AppColors.colorindigo.withOpacity(0.8),
                            onTap: () {

                              if (_formKey2.currentState!.validate()) {

                                val.UpdatePassword(
                                    passwordController.text.toString(),
                                    newPassWordController.text.toString(),
                                    conFormPasswordController.text.toString(),
                                    context).then((value) {
                                  if( val.invelidPassword=='password changed successfully'){
                                    print(val.invelidPassword.toString()+"on ui side");
                                    showAlertDialog(context);
                                  }

                                }).onError((error, stackTrace){
                                  print("Aleart Dailog error");
                                });


                              }
                            },
                            child: Container(
                                height: s.height * 0.05,
                                width: s.width * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3)),
                                child: Center(
                                  child: val.UpdateLoading == false
                                      ? Text(
                                    "Update Password",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode == false
                                            ? AppColors.colorwhite
                                            : Colors.white),
                                  )
                                      : SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ))),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

//widget sociallink used in data
  Widget widgetSocialLink() {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: s.height * 0.015, left: s.width * 0.039),
                    child: Text(
                      "Do you have an online portfolio to share,or a relative project or presentation ? Link it here",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: isDarkMode == true
                              ? Colors.white.withOpacity(0.75)
                              : ColorApp.colorblackgalf,
                          fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: isDarkMode == true
                              ? Color(0xff343434)
                              : Colors.white,
                          border: Border.all(
                              color: isDarkMode == true
                                  ? Colors.white.withOpacity(0.3)
                                  : Colors.black54.withOpacity(0.3))),
                      height: s.height * 0.0579,
                      child: DropdownButton(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 26,
                              color: isDarkMode == true
                                  ? AppColors.colorwhite.withOpacity(0.69)
                                  : Colors.grey,
                            ),
                          ),
                          dropdownColor: isDarkMode == false
                              ? ColorApp.colorblackgalf
                              : ColorApp.colorblackgalf,
                          elevation: 1,
                          isExpanded: true,
                          underline: Container(
                            color: AppColors.colorblue,
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Please Select you Social link',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite
                                      .withOpacity(0.69)
                                      : Colors.grey,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          value: sociallink,
                          onChanged: (v) {
                            setState(() {
                              _dropdownError = null;
                              sociallink = v as String;
                              //countryId = (index!+1).toString();
                              for (var i = 0;
                              i < socialListData.length;
                              i++) {
                                if (socialListData[i]['title'].toString() == v) {
                                  socialId = socialListData[i]['id']
                                      .toString();
                                  print(socialId.toString() +
                                      'social id idddddddddddd');
                                }
                              }
                            });
                          },
                          items: socialListData.map((v) {
                            return DropdownMenuItem(
                              value: "v['title']",
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                 " v['title']",
                                  style: TextStyle(
                                      color: isDarkMode == true
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),

                  SizedBox(
                    height: s.height * 0.03,
                  ),
                  Visibility(
                      visible: selectedLink,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "hello"),
                      ))

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 11, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 3, left: 4),
                    child: SubmitButton(
                        border: Border.all(
                            color: isDarkMode == false
                                ? AppColors.colorblack
                                : Colors.white.withOpacity(0.3)),
                        textColor: isDarkMode == true
                            ? AppColors.colorwhite
                            : AppColors.colorblack,
                        backGroundColor: isDarkMode == true
                            ? Color(0xff343434)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        heightButton: s.height * 0.05,
                        widthButton: s.width * 0.30,
                        textButton: "Cancel",
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Consumer<PostAddPersonalInfoController>(
                    builder: (context, val, child) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Center(
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: ColorApp.colorprimary,
                            child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                splashColor:
                                AppColors.colorindigo.withOpacity(0.8),
                                onTap: () {},
                                child: Container(
                                    height: s.height * 0.05,
                                    width: s.width * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Center(
                                      child: val.loadingInfo == false
                                          ? Text(
                                        "Linked Account",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMode == false
                                                ? AppColors.colorwhite
                                                : Colors.white),
                                      )
                                          : SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    ))),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget widgettextdata(
      text,
      image,
      ) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 8, right: 0, bottom: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      child: Image.asset(image,
                          color:
                          isDarkMode == true ? Colors.white : Colors.black,
                          fit: BoxFit.fill),
                    ),
                    Container(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 0.25,
                          sigmaY: 0.25,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            text,
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? ColorApp.colorbackground.withOpacity(0.8)
                                    : ColorApp.colorblackgalf),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textformwidget(name, onchange, onvalidation) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return TextFormField(
      validator: onvalidation,
      onChanged: onchange,
      style: TextStyle(
          color: isDarkMode == true
              ? ColorApp.colorbackground
              : ColorApp.colornewblack),
      initialValue: name,
      decoration: InputDecoration(
          contentPadding:
          EdgeInsets.only(left: s.width * 0.09, top: 0, bottom: 0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode == true
                  ? ColorApp.colorwhite.withOpacity(0.5)
                  : ColorApp.colorblackgalf.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApp.colorprimary))
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    final s=MediaQuery.of(context).size;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      insetPadding: EdgeInsets.only(right: s.width*0.01,top:s.height*0.2,bottom: s.height*0.43) ,

      content: Column(
        children: [
          Container(
            height: s.height*0.075,
            width: s.width*0.17,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.deepPurple.withOpacity(0.1)
            ),
            child:    Padding(
              padding: EdgeInsets.only(right: 7),
              child: Container(
                child: Image.asset(

                  height: s.height*0.025,
                  ImangeAssests.shieldImage,
                  width: s.width * 0.099,
                ),
              ),
            ),
          ),
          SizedBox(height: 12,),
          Text("Passwords Reset successfully!",style: TextStyle(
              color: ColorApp.colorblack,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 12,),
          Text("Your now use your new password to login into your account!",style: TextStyle(
              color: ColorApp.colorblackgalf
          ),),
          SizedBox(height: 12,),
          Consumer<PostRegisterApiWithSessionController>(
              builder: (context, val, child) {
                return InkWell(
                  onTap: (){
                    Provider.of<PostRegisterApiWithSessionController>(
                        context,
                        listen: false)
                        .logoutAPI(context);
                  },
                  child: Container(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.colorprimary
                    ),
                    width: s.width,
                    height: s.height*0.05,
                    child: Center(child:val.loading?CircularProgressIndicator():


                    Text("Login",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),)),
                  ),
                );
              })


        ],
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
}
