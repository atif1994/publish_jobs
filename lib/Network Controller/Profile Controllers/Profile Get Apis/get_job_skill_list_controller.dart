import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/job_skill_model.dart';
import '../../../profile_model/job_seeker_skill_model.dart';
import '../../../utils/app_urls.dart';
class GetJobSkillController with ChangeNotifier{
  List<JobseekerSkillModel> skillListData = [];
  bool isLoading = false;
  notifyListeners();

  Future<List<JobseekerSkillModel>> jobSeekerSkill() async {
    isLoading=true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerSkills";
    Response response = await http.get(Uri.parse(AppUrls.getJobseekerSkillsUrl),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        skillListData.add(JobseekerSkillModel.fromJson(i));

        notifyListeners();
        print("loading data false");
      }
      isLoading = false;
      return skillListData;
    } else {
      isLoading = false;

      print('failed jobSeekerSkill ' + response.statusCode.toString());
      return skillListData;
    }
  }
}