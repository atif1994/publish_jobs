import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../model/job_seeker_objective_model.dart';

class GetObjectController with ChangeNotifier{
  bool isLoading=false;

  Future<JobSeekerObjectiveModel> jobSeekerObjectives() async {
    isLoading=true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http
          .get(Uri.parse('https://api.publish.jobs/api/get-jobseekerObjective'),
          headers: requestHeaders)
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        isLoading=false;
        notifyListeners();
        data = jsonDecode(response.body.toString());
        return JobSeekerObjectiveModel.fromJson(data);
      } else {
        print('failed objective status: ' + response.statusCode.toString());
        return JobSeekerObjectiveModel.fromJson(data);
      }
    } catch (e) {
      isLoading=false;
      notifyListeners();
    }
    return JobSeekerObjectiveModel.fromJson(data);
  }
}