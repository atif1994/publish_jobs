

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
class PostLanguageController with ChangeNotifier{
  bool loadingLanguage = false;
  addJobSeekerLanguage(preferredType) async {
    loadingLanguage = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader,
      "Content-Type": "application/json",
    };
    String url = 'https://api.publish.jobs/api/jobseekerAddLanguage';
    loadingLanguage = true;
    notifyListeners();
    Response response = await post(Uri.parse(url),
        body: jsonEncode(preferredType), headers: requestHeaders);
    loadingLanguage = false;
    notifyListeners();
    if (response.statusCode == 200) {
      loadingLanguage = false;
      notifyListeners();
      print('success fully added user languages');
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Bar(id: 2,)));
    } else {
      loadingLanguage = false;
      notifyListeners();
      print('failed language: ' + preferredType.toString());
      print('failed language: ' + response.statusCode.toString());
    }
  }

}