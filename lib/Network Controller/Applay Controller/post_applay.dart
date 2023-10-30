import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;

class PostJobApplayController with ChangeNotifier {
  bool ApplayLoading = false;

  ApplayPost(String job_id, BuildContext context) async {
    ApplayLoading = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    String url =
        "https://api.publish.jobs/api/jobseekerAddApplyJob?job_id=$job_id";
    try {
      Response response = await post(Uri.parse(url),
          body: {"job_id": job_id}, headers: requestHeaders);
      if(response.statusCode==200){
        ApplayLoading=false;
        notifyListeners();
        print("applay job data");

      }else{
        ApplayLoading=false;
        notifyListeners();
        print("error");
      }
    } catch (e) {
      print(e.toString()+"Catch error");

    }
  }
}
