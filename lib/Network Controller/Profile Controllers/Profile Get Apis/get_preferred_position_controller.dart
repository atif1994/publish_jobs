import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../model/job_seeker_preferred_position_model.dart';

class GetPreferredPositionController with ChangeNotifier{
  List<JobSeekerPreferredPositionModel> preferredPositionListData = [];
  bool isLoading = false;
  notifyListeners();

  Future<List<JobSeekerPreferredPositionModel>>
  getJobSeekerPreferredPosition() async {
    isLoading=true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerJobPosition";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        preferredPositionListData
            .add(JobSeekerPreferredPositionModel.fromJson(i));

        notifyListeners();
        //notifyListeners();
      }
      isLoading = false;
      return preferredPositionListData;
    } else {
      print('failed job seeker preferrsed position api hit' +
          response.statusCode.toString());
      isLoading = false;
      notifyListeners();
      return preferredPositionListData;
    }
  }
}