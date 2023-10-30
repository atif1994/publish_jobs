import 'dart:convert';

import 'package:firstapp/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';


class PostAddReportJobController with ChangeNotifier{
  bool loadingJobReport = false;

  jobseekerAddReportJob(String report_option_id, String description,
      String job_id, BuildContext context) async {
    loadingJobReport = true;
    dynamic data;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    loadingJobReport = true;
    notifyListeners();
    print(requestHeaders);
    // String url = "https://api.publish.jobs/api/jobseekerAddWorkAuthorization";
    Response response = await post(
        Uri.parse('https://api.publish.jobs/api/jobseekerAddReportJob'),
        body: {
          'report_option_id': report_option_id,
          'description': description,
          'job_id': job_id,
        },
        headers: requestHeaders);
    data = jsonDecode(response.body.toString());
    print(response.statusCode.toString() + "error show report");
    if (response.statusCode == 200) {
      loadingJobReport = false;
      var checkReport = data['status'].toString();
      if(checkReport == 'success' ){
        print("success");

      }
      else{
        Get.snackbar(
          "Report!",
          "failed",
          animationDuration: Duration(milliseconds: 500),
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
      }





      notifyListeners();


      // if(response.statusCode=="success"){
      //
      // }
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Bar()));
    } else {
      print('failed' + response.statusCode.toString());
      loadingJobReport = false;
      notifyListeners();
    }
  }
}