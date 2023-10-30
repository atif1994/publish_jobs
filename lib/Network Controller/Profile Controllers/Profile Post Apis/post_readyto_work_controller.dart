

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
class PostReadyToWorkController with ChangeNotifier{
  bool loadingWork = false;
  bool checkLoadingWork = false;
  void jobSeekerReadyToWorkAdd(String status, BuildContext context) async {
    loadingWork = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingWork = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerAddReadyToWork?checked=$status";
      Response response = await post(Uri.parse(url),
          body: {
            'checked': status,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        checkLoadingWork = true;
        notifyListeners();
        loadingWork = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      } else {
        print('failed ready to work');
        loadingWork = false;
        notifyListeners();
      }
    } catch (e) {
      loadingWork = false;
      notifyListeners();
      print(e.toString());
    }
  }

}