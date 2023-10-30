import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../model/job_seeker_preferred_position_model.dart';
import '../../../model/job_seeker_preferred_type_model.dart';

class GetPreferredJobTypeController with ChangeNotifier{
  List<JobSeekerPreferredTypeModel> preferredJobTypeListData = [];
  bool isLoading = false;
  notifyListeners();

  Future<List<JobSeekerPreferredTypeModel>>
  getJobSeekerPreferredJobType() async {
    isLoading=true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerJobType";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();

      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        preferredJobTypeListData.add(JobSeekerPreferredTypeModel.fromJson(i));

        notifyListeners();
        //notifyListeners();
      }
      isLoading = false;
      return preferredJobTypeListData;
    } else {
      print('failed job seeker preferrsed job type api hit' +
          response.statusCode.toString());

      isLoading = false;
      notifyListeners();
      return preferredJobTypeListData;
    }
  }
}