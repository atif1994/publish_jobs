

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
class PostRelocationController with ChangeNotifier{
  bool loadingRelocation = false;
  void jobSeekerRelocationAdd(String status, BuildContext context) async {
    loadingRelocation = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingRelocation = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerAddRelocation?checked=$status";
      Response response = await post(Uri.parse(url),
          body: {
            'checked': status,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        loadingRelocation = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      } else {
        print('failed genderrrrrr');
        loadingRelocation = false;
        notifyListeners();
      }
    } catch (e) {
      loadingRelocation = false;
      notifyListeners();
      print(e.toString());
    }
  }

}