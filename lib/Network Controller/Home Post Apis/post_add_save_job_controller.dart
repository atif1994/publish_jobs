import 'dart:convert';

import 'package:firstapp/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../widgets/AlertDailog.dart';

class PostAddSaveJobController with ChangeNotifier {
  bool loadingJobSave = false;

  jobseekerAddSaveJob(String job_id, BuildContext context) async {
    loadingJobSave = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = pref.getString('tokenProvider').toString();
  //  print(tokenHeader);
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    notifyListeners();

    try {
      loadingJobSave = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerAddSaveJob?job_id=$job_id";
      Response response = await post(Uri.parse(url),
          body: {
            'job_id': job_id,
          },
          headers: requestHeaders);
      print("${response.body} job save response");
      if (response.statusCode == 200) {
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return MyDialog();
        //     });
        loadingJobSave = false;
        notifyListeners();
      }

      print('failed Job');
      loadingJobSave = false;
      notifyListeners();

      loadingJobSave = false;
      notifyListeners();
    } catch (e) {
      loadingJobSave = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
