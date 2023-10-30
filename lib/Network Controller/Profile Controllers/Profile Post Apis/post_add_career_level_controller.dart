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
class PostCareerLevelController with ChangeNotifier{
  bool loadingAddCareerLevel = false;
  jobSeekerAddCareerLevel(String id, BuildContext context) async {
    loadingAddCareerLevel = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingAddCareerLevel = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerAddCareerLevel?id=$id";

      Response response = await post(Uri.parse(url),
          body: {
            "id": id,
          },
          headers: requestHeaders);
      // print('here2');

      if (response.statusCode == 200) {
        print('successfully added');
        loadingAddCareerLevel = false;
        notifyListeners();
        // GlobalVarData.careelLevel = 'not null';

      } else {
        print(response.statusCode.toString() + 'ststusssss');
        print(
            'failed add experience status: ' + response.statusCode.toString());
        loadingAddCareerLevel = false;
        notifyListeners();
      }
    } catch (e) {
      loadingAddCareerLevel = false;
      print('here e');

      notifyListeners();
      print(e.toString());
    }
  }

}