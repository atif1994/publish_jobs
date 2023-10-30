import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:get/get.dart' hide Response;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../model/GetjobSeekerCareerLevelModel.dart';
import '../../../model/job_seeker_career_level_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart' hide Response;

class GetJobSeekerCareerLevelController with ChangeNotifier {
  bool isLoadingCareer = false;

  notifyListeners();

  Future<JobSeekerCareerLevelModel> getJobSeekerCareerLevel() async {
    isLoadingCareer = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      String url = "https://api.publish.jobs/api/get-jobseekerCareerLevel";
      Response response =
          await http.get(Uri.parse(url), headers: requestHeaders);

      if (response.statusCode == 200) {
        isLoadingCareer=false;
        notifyListeners();
        data = jsonDecode(response.body.toString());
        JobSeekerCareerLevelModel.fromJson(data);
      } else {
        JobSeekerCareerLevelModel.fromJson(data);

        print('failed careeer level status: ' + response.statusCode.toString());
        isLoadingCareer = false;
      }
    } catch (e) {
      print(e.toString()+"show careel level error");
    }

    return JobSeekerCareerLevelModel.fromJson(data);
  }
}
