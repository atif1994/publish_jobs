import 'dart:convert';

import 'dart:math';

import 'package:firstapp/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';

import '../profile_model/job_skr_pref_job_position.dart';



class ABD with ChangeNotifier {
  bool loading = false;
  bool loadingd = false;

  bool loadingEducationDelete = false;
  bool loadingJobSeekerDelete = false;



  bool loadingMartialStatus = false;



  bool loadingExcutiveDelete = false;
  bool loadingWorkAuthDelete = false;
  bool loadingLanguageDelete = false;
  bool loadingGalleryDelete = false;
  bool loadingPreferredPositionDelete = false;
  bool loadingTypeDelete = false;
  bool loadingInfo = false;


















  // ...
























  // List<JobSeekerJobTypeModel> jobTypeListData = [];
  //
  // Future<List<JobSeekerJobTypeModel>> getJobSeekerTypeModel() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String tokenHeader = await pref.getString('tokenProvider').toString();
  //
  //   Map<String, String> requestHeaders = {
  //     'Authorization': 'Bearer ' + tokenHeader
  //   };
  //   loading = true;
  //   notifyListeners();
  //   String url = "https://api.publish.jobs/api/get-jobseekerJobType";
  //   Response response = await http.get(Uri.parse(url), headers: requestHeaders);
  //   if (response.statusCode == 200) {
  //     print("get-jobseekerJobType api hittttt");
  //     var data = jsonDecode(response.body.toString());
  //     for (Map<String, dynamic> i in data) {
  //       jobTypeListData.add(JobSeekerJobTypeModel.fromJson(i));
  //       //notifyListeners();
  //     }
  //     loading = false;
  //     notifyListeners();
  //     return jobTypeListData;
  //   } else {
  //     print('failed get-jobseekerJobType api' + response.statusCode.toString());
  //     loading = false;
  //     notifyListeners();
  //     return jobTypeListData;
  //   }
  // }








  // jobSeekerAddPersonalInfo(
  //     String first_name,
  //     String last_name,
  //     String country_id,
  //     String city_id,
  //     String mobile,
  //     BuildContext context) async {
  //   loadingInfo = true;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String tokenHeader = await pref.getString('tokenProvider').toString();
  //   Map<String, String> requestHeaders = {
  //     'Authorization': 'Bearer ' + tokenHeader
  //   };
  //   notifyListeners();
  //   try {
  //     loadingInfo = true;
  //     notifyListeners();
  //     String url =
  //         "https://api.publish.jobs/api/jobseekerAddPersnolInfo?first_name=$first_name&last_name=$last_name&country_id=$country_id&city_id=$city_id&mobile=$mobile";
  //     Response response = await post(Uri.parse(url),
  //         body: {
  //           'first_name': first_name,
  //           "last_name": last_name,
  //           "country_id": country_id,
  //           "city_id": city_id,
  //           "mobile": mobile,
  //         },
  //         headers: requestHeaders);
  //     if (response.statusCode == 200) {
  //       // var data = jsonDecode(response.body.toString());
  //       loadingInfo = false;
  //       // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
  //       notifyListeners();
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => ApplayEducation()));
  //     } else {
  //       print('failed to add personal info status: ' + response.toString());
  //       loadingInfo = false;
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     loadingInfo = false;
  //     notifyListeners();
  //     print(e.toString());
  //   }
  // }









}
