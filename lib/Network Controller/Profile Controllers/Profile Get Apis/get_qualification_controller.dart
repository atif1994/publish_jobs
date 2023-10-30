import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/degree_list_model.dart';
import '../../../profile_model/job_seeker_education_model.dart';


class GetQualificationController with ChangeNotifier{
  List<JobseekerEducationModel> educationListData = [];
  bool isLoading = false;
  notifyListeners();
  Future<List<JobseekerEducationModel>> getEducationList() async {
     isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-qualifications";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        educationListData.add(JobseekerEducationModel.fromJson(i));
        notifyListeners();
      }
      isLoading = false;
      return educationListData;
    } else {
      print('failed qualification status: ' + response.statusCode.toString());
      isLoading = false;
      return educationListData;
    }
  }
}