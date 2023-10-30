import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/job_seeker_language_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GetLanguageController with ChangeNotifier{
  List<JobSeekerLanguageModel> languageListData = [];
  bool  isLoadinglanguage = false;
  notifyListeners();
  Future<List<JobSeekerLanguageModel>>
  getJobSeekerLanguage() async {
    isLoadinglanguage = true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerLanguage";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        languageListData.add(JobSeekerLanguageModel.fromJson(i));

        notifyListeners();
        //notifyListeners();
      }
      isLoadinglanguage = false;
      return languageListData;
    } else {
      print('failed work authhhhhhhhhh' + response.statusCode.toString());
      isLoadinglanguage = false;
      notifyListeners();
      return languageListData;
    }
  }
}