import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/job_seeker_certification_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GetCertificationController with ChangeNotifier{
  List<JobSeekerCertificationsModel> certificationsListData = [];
  bool isLoading = false;
  notifyListeners();
  Future<List<JobSeekerCertificationsModel>> jobSeekerCertifications() async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerAchievement";
    Response response = await http.get(Uri.parse(url),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        certificationsListData.add(JobSeekerCertificationsModel.fromJson(i));

        notifyListeners();
      }
      isLoading = false;
      return certificationsListData;
    } else {
      print('failed jobSeekerCertificate' + response.statusCode.toString());
      isLoading = false;
      notifyListeners();

      return certificationsListData;
    }
  }
}