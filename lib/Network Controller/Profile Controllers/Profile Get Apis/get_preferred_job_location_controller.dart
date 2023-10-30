import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart' hide Response;

import '../../../model/job_seeker_job_location_model.dart';

class GetPreferredJobSeekerLocation with ChangeNotifier{
  List<JobSeekerJobLocationModel> preferredJobLocationListData = [];
  bool  isLoadingLocation =false;
  notifyListeners();
  Future<List<JobSeekerJobLocationModel>>
  getJobSeekerPreferredJobLocation() async {
    isLoadingLocation=true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerPreferredLocation";

    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        preferredJobLocationListData.add(JobSeekerJobLocationModel.fromJson(i));

        notifyListeners();

      }

      isLoadingLocation = false;
      return preferredJobLocationListData;
    } else {
      print('failed job seeker preferrsed location api hit' +
          response.statusCode.toString());
      isLoadingLocation = false;
      notifyListeners();
      return preferredJobLocationListData;
    }
  }
}