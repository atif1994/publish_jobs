import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../profile_model/job_seeker_work_experience_model.dart';
import 'dart:convert';
import '../../../utils/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:get/get.dart' hide Response;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class GetExperienceController with ChangeNotifier{
  List<JobseekerWorkExperienceModel> workexperienceListData = [];
  bool isLoading = false;
  notifyListeners();
  Future<List<JobseekerWorkExperienceModel>> getWorkExperienceList() async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    // String url = "https://api.publish.jobs/api/get-workExperience";
    Response response = await http.get(Uri.parse(AppUrls.getWorkExperienceUrl),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        workexperienceListData.add(JobseekerWorkExperienceModel.fromJson(i));

        notifyListeners();
      }
      isLoading = false;
      return workexperienceListData;
    } else {



      print('failed workExperience api!' + response.statusCode.toString());
      isLoading = false;
      return workexperienceListData;
    }
  }
}