

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;

import '../../../App Services/global_vars.dart';
class PostMartialStatusController with ChangeNotifier{
  bool loadingMartialStatus = false;
  jobSeekerAddMartialStatus(String id, BuildContext context) async {
    loadingMartialStatus = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingMartialStatus = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerAddMaritalStatus?id=$id";

      Response response = await post(Uri.parse(url),
          body: {
            "id": id,
          },
          headers: requestHeaders);
      // print('here2');

      if (response.statusCode == 200) {
        print('successfully added');
        loadingMartialStatus = false;
        notifyListeners();
        GlobalVarData.maritalStatus = 'not null';
        Get.back();
      } else {
        print(response.statusCode.toString() + 'ststusssss');
        print(
            'failed add experience status: ' + response.statusCode.toString());
        loadingMartialStatus = false;
        notifyListeners();
      }
    } catch (e) {
      loadingMartialStatus = false;
      print('here e');

      notifyListeners();
      print(e.toString());
    }
  }

}