import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/get_resume_model.dart';


class GetResumeController with ChangeNotifier {
  List<GetResumeModel> resumeListData = [];
  bool isLoading = false;
  notifyListeners();
  Future<List<GetResumeModel>>  GetResume() async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerResume";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        resumeListData.add(GetResumeModel.fromJson(i));
        notifyListeners();
      }
      isLoading = false;
      return resumeListData;
    } else {
      print('failed qualification status: ' + response.statusCode.toString());
      isLoading = false;
      return resumeListData;
    }
  }
}
