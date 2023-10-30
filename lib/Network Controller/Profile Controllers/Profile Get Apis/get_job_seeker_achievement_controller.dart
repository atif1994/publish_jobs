import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../profile_model/job_seeker_achievement_model.dart';
import '../../../utils/app_urls.dart';

class GetJobSeekerAchievementController{
  Future<jobseekerAchievementModel> jobSeekerAchievement() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http
          .get(Uri.parse(AppUrls.getJobseekerAchievementUrl),
          headers: requestHeaders)
          .timeout(Duration(seconds: 10));
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        return jobseekerAchievementModel.fromJson(data);
      } else {
        print('failed');
        // return jobseekerAchievementModel.fromJson(data);
      }
    } catch (e) {}
    print(e.toString());
    return jobseekerAchievementModel.fromJson(data);
  }
}