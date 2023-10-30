

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
class PostWorkAuthorizationController with ChangeNotifier{
  bool loadingAddSkill = false;
  addJobSeekerAuth(workAuthorization, context) async {
    loadingAddSkill = true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();


    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader,
      "Content-Type": "application/json",
    };

    // loading=false;
    String url = 'https://api.publish.jobs/api/jobseekerAddWorkAuthorization';
    loadingAddSkill = true;
    notifyListeners();
    print('skilll here 123123123');
    Response response = await post(Uri.parse(url),
        body: jsonEncode(workAuthorization), headers: requestHeaders);
    loadingAddSkill = false;
    notifyListeners();
    if (response.statusCode == 200) {
      print('skilss added  successfully');

      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Bar(id: 2,)));
      loadingAddSkill = false;
      notifyListeners();
    } else {
      Get.defaultDialog(title: 'failed');
      loadingAddSkill = false;
      // loading=false;
      notifyListeners();
      print('failed addO status: ' + response.statusCode.toString());
    }
  }
  // addJobSeekerAuth(authData) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String tokenHeader = await pref.getString('tokenProvider').toString();
  //   Map<String, String> requestHeaders = {
  //     'Authorization': 'Bearer ' + tokenHeader,
  //     "Content-Type": "application/json",
  //   };
  //   String url = 'https://api.publish.jobs/api/jobseekerAddWorkAuthorization';
  //   Response response = await post(Uri.parse(url),
  //       body: jsonEncode(authData), headers: requestHeaders);
  //   if (response.statusCode == 200) {
  //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Bar(id: 2,)));
  //   } else {
  //     print('failed addObjectice status: ' + response.statusCode.toString());
  //   }
  // }


}