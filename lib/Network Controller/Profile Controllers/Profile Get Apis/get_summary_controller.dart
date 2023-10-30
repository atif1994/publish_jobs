import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../model/job_seeker_summary_model.dart';

class GetSummaryController{
  Future<JobSeekerSummaryModel> jobSeekerSummary() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http
          .get(Uri.parse('https://api.publish.jobs/api/get-jobseekerSummary'),
          headers: requestHeaders)
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        return JobSeekerSummaryModel.fromJson(data);
      } else {
        print('failed summery: ' + response.statusCode.toString());
        return JobSeekerSummaryModel.fromJson(data);
      }
    } catch (e) {
      // print(e.toString());
    }
    return JobSeekerSummaryModel.fromJson(data);
  }
}