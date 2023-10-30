import 'dart:convert';

import 'package:firstapp/Network%20Controller/Appbar%20Controller/get_appbar_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../Network Controller/Profile Controllers/Profile Get Apis/get_personal_Info_controller.dart';
import '../constants/color_app.dart';
import '../model/cuntom_user_profile_model.dart';
import '../utils/app_color.dart';

class AppBarShow extends StatefulWidget {
  String? profileImage;

  IconData? icon;
  AssetImage? assetImage;

  AppBarShow({Key? key, this.profileImage, this.icon, this.assetImage})
      : super(key: key);

  @override
  State<AppBarShow> createState() => _AppBarShowState();
}

class _AppBarShowState extends State<AppBarShow> {
  String? jobName;
  String? companyName;
  String? cityName;
  String? salaryShow;
  String? postedTime;
  String? imageUrl;
  String ?jobDescription;
  String ?JobId;
  String ?appBarImage;
  getProfilePersonalInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    //   try {
    final response = await http.get(
        Uri.parse('https://api.publish.jobs/api/user-general-get'),
        headers: requestHeaders);
    // .timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
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
      print('failed persnal info error status code: ' +
          response.statusCode.toString());
    }
    // }
    //  catch (e)
    //   {
    //     print(e.toString() + ' personalInfo exception profilebase');
    //   }
  }
  getJobCardValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      jobName = prefs.getString('jobName').toString();
      appBarImage = prefs.getString('appimgg').toString();
      JobId = prefs.getString('jobId').toString();
      companyName = prefs.getString('companyName').toString();
      cityName = prefs.getString('cityName').toString();
      salaryShow = prefs.getString('salaryShow').toString();
      postedTime = prefs.getString('postedTime').toString();
      imageUrl = prefs.getString('imageUrl').toString();
      jobDescription = prefs.getString('jobDescription').toString();
    });
  }
  @override
  void initState() {
    getJobCardValues();
    getProfilePersonalInfo();
    // TODO: implement initState
    super.initState();
  }
  String? firstName;
  String? lastName;
  String? profileImage;
  String? profileCity;
  String? mobile;
  String? email;

  List uesrCountryList = [];
  List countryListData = [];
String a ="atif ali".toString();


  @override
  Widget build(BuildContext context) {

    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: Container(
        color: isDarkMode == true
            ? Color(0xff343434)
            : Colors.white,
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
                        : ColorApp.colorblackgalf
                        .withOpacity(0.2),
                    elevation: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf
                              .withOpacity(0.2),
                          borderRadius:
                          BorderRadius.circular(8),
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
                            borderRadius:
                            BorderRadius.circular(50),
                            border: Border.all(
                                width: 1, color: Colors.white)),
                        child: CircleAvatar(
                          radius: 23,
                          backgroundImage: profileImage
                              .toString() !=
                              'null'
                              ? NetworkImage(
                              'https://api.publish.jobs/pjcloud/userAccountImage/' +
                                  profileImage.toString())
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
    );



  }
}
