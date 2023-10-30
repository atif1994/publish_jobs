import 'dart:async';
import 'dart:convert';

import 'package:firstapp/constants/color_app.dart';
import 'package:firstapp/widgets/buttonSubmit_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../App Services/api_services_provider.dart';
import '../../App Services/global_vars.dart';
import '../../Network Controller/General Controllers/user_available_country_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_country_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_personal_Info_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_add_personal_info_controller.dart';
import '../../constants/image_assets.dart';
import '../../model/country_list_model.dart';
import '../../model/user_available_country_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/jobscard_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';
import '../../../model/cuntom_user_profile_model.dart';
import 'applay_qualification_screen.dart';

class ApplayPersonalInfoScreen extends StatefulWidget {
  String? image;

  ApplayPersonalInfoScreen({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  State<ApplayPersonalInfoScreen> createState() =>
      _ApplayPersonalInfoScreenState();
}

class _ApplayPersonalInfoScreenState extends State<ApplayPersonalInfoScreen> {
  final String urlCountry = "https://api.publish.jobs/api/userAvailableCountry";
  String? countrySelection;
  String? countryId;
  String? citySelection;
  bool isAppbar = true;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? mobile_code;
  String? mobile_code1;
  String? profileImage;

  // final String urlCity = "https://api.publish.jobs/api/country-cities?country=$countryId";
  List countryListData = [];

  // Future<List<CountriesListModel>>? countriesListFuture;
  List countryList = ['lahore'];

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCardWidget();
    getProfilePersonalInfo();

    this.getCountryList();
    getCountryListData();
    //countriesListFuture=DataServices().getCountriesList;
    //this.postCityList();
  }

  List uesrCountryList = [];
  int indecator = 1;

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


  String newFirstName = '';
  String newLastName = '';
  String newPhonNumber = '';
  String FirstName = '';
  String? LastName;
  String? countrySelectionAll;
  String phonNumber = '';
  final _formKey = GlobalKey<FormState>();
  String? _dropdownError;
  String? _selectedItem;

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
String? firstNameinit;
String? lastNameinit;
  String? countryinit;
  String? mobileinit;

  @override
  Widget build(BuildContext context) {

firstNameinit=firstName==null?"":firstName.toString();
lastNameinit=lastName==null?"":lastName.toString();
mobileinit=mobile==null?"":mobile.toString();


    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    if (GlobalVarData.personalInfoApplyData == 'not null') {
      GlobalVarData.personalApplayFuture =
          GetPersonalInfoController().jobSeekerPersonalInfo();
      GlobalVarData.personalInfoApplyData = 'null';
    }

    final s = MediaQuery.of(context).size;
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
      backgroundColor: isDarkMode == true
          ? ColorApp.colornewblack
          : ColorApp.colorbackground,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      indecator.toString() + "/" + "10",
                      style: TextStyle(
                          color: isDarkMode == false
                              ? ColorApp.colorblackgalf.withOpacity(0.7)
                              : ColorApp.colorwhite.withOpacity(0.68)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearPercentIndicator(
                  //leaner progress bar
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 6.0,
                  percent: indecator / 10,

                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: AppColors.colorprimary,
                  backgroundColor: isDarkMode == true
                      ? ColorApp.colorwhite
                      : ColorApp.colorblackgalf.withOpacity(0.5),
                ),
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
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
                                    textButton: "Previous",
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ApplayQualificationScreen(
                                                              indecator:
                                                              indecator + 1,
                                                              image:
                                                              widget.image,
                                                            )));
                                              }
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
