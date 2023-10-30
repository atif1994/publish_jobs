import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/job_skill_model.dart';
import '../../../profile_model/job_seeker_skill_model.dart';
import '../../../utils/app_urls.dart';
import '../../../model/job_seeker_gender_model.dart';

class GetJobSeekerGenderController with ChangeNotifier {


  Future<JobSeekerGenderModel> getJobSeekerGender() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerGender";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic data;
    try {
      if (response.statusCode == 200) {
        notifyListeners();
        data = jsonDecode(response.body.toString());
        JobSeekerGenderModel.fromJson(data);
        //notifyListeners();
      }else {
        print('failed get-jobseekerGender api' + response.statusCode.toString());

        return JobSeekerGenderModel.fromJson(data);
      }
    } catch (e) {

    }
    return JobSeekerGenderModel.fromJson(data);
  }
}