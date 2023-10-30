import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:get/get.dart' hide Response;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';


import '../../../model/job_seeker_career_level_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart' hide Response;
class GetCareerController with ChangeNotifier{
  List<JobCareerLavelModel> careerLevelListData = [];
  bool isLoadingCareer = true;
  notifyListeners();

  Future<List<JobCareerLavelModel>> getCareerLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };


    String url = "https://api.publish.jobs/api/get-careerlevel";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        careerLevelListData.add(JobCareerLavelModel.fromJson(i));
        isLoadingCareer = false;
        notifyListeners();
      }

      return careerLevelListData;
    } else {
      print('failed careeer level status: ' + response.statusCode.toString());
      isLoadingCareer = false;
      notifyListeners();
      return careerLevelListData;
    }
  }
}