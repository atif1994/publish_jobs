

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
class PostPreferJobTypeController with ChangeNotifier{
  bool isLoading = false;
  notifyListeners();
  addJobSeekerPreferresJobType(preferredType) async {
    isLoading = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader,
      "Content-Type": "application/json",
    };
    String url = 'https://api.publish.jobs/api/jobseekerAddJobType';
    Response response = await post(Uri.parse(url),
        body: jsonEncode(preferredType), headers: requestHeaders);
    if (response.statusCode == 200) {
      isLoading = false;
      notifyListeners();
      print('preffered job type'+preferredType.toString());
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Bar(id: 2,)));
    } else {
      isLoading = false;
      notifyListeners();
      print('failed addObjectice status: ' + response.statusCode.toString());
    }
  }

}