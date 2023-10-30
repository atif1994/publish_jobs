import '../../../model/job_type_filter_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GetJobTypeListController{
  List<JobTypeFilterModel> jobTypeData = [];

  Future<List<JobTypeFilterModel>> getjobTypeList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };


    String url = "https://api.publish.jobs/api/jobTypeFilter";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        jobTypeData .add(JobTypeFilterModel.fromJson(i));
      }

      return jobTypeData ;
    } else {
      print('failed jobtype filter status: ' + response.statusCode.toString());

      return jobTypeData ;
    }
  }
}