

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;

import '../../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
class PostPreferJobLocationController with ChangeNotifier{
  bool loadingPreferLocation = false;
  jobSeekerAddPreferedLocation(
      String country_id, String city_id, BuildContext context) async {
    loadingPreferLocation = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingPreferLocation = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/jobseekerAddPreferredLocation";
      Response response = await post(Uri.parse(url),
          body: {
            "country_id": country_id,
            "city_id": city_id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        loadingPreferLocation = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();

      } else {
        print('failed to add personal info status: ' + response.toString());
        loadingPreferLocation = false;
        notifyListeners();
      }
    } catch (e) {
      loadingPreferLocation = false;
      notifyListeners();
      print(e.toString());
    }
  }

}