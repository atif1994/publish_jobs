

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
class PostPreferJobPositionController with ChangeNotifier{
  bool loadingAddPosition = false;

  // addJobSeekerPreferresPosition(preferredPositionData) async {
  //   loadingAddPosition=true;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String tokenHeader = await pref.getString('tokenProvider').toString();
  //   Map<String, String> requestHeaders = {
  //     'Authorization': 'Bearer ' + tokenHeader,
  //     "Content-Type": "application/json",
  //   };
  //   String url = 'https://api.publish.jobs/api/jobseekerAddJobPosition';
  //   Response response = await post(Uri.parse(url),
  //       body: jsonEncode(preferredPositionData), headers: requestHeaders);
  //   if (response.statusCode == 200) {
  //     loadingAddPosition=false;
  //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Bar(id: 2,)));
  //   } else {
  //     print('failed addObjectice status: ' + response.statusCode.toString());
  //   }
  // }

  addJobSeekerPreferresPosition(preferredPositionData, context) async {
    loadingAddPosition = true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();


    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader,
      "Content-Type": "application/json",
    };

    // loading=false;
    String url = 'https://api.publish.jobs/api/jobseekerAddJobPosition';
    loadingAddPosition = true;
    notifyListeners();
    print('skilll here 123123123');
    Response response = await post(Uri.parse(url),
        body: jsonEncode(preferredPositionData), headers: requestHeaders);
    loadingAddPosition = false;
    notifyListeners();
    if (response.statusCode == 200) {
      print('skilss added  successfully');

      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Bar(id: 2,)));
      loadingAddPosition = false;
      notifyListeners();
    } else {
      Get.defaultDialog(title: 'failed');
      loadingAddPosition = false;
      // loading=false;
      notifyListeners();
      print('failed addO status: ' + response.statusCode.toString());
    }
  }

}