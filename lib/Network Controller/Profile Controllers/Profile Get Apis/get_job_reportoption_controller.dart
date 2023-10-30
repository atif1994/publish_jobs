import '../../../model/job_ReportOption_Web_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';
class GetJobReportOptionController{
  List<JobReportOptionWebModel> jobReportOptionListData = [];

  Future<List<JobReportOptionWebModel>> jobReportOption() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };


    Response response = await http.get(
        Uri.parse("https://api.publish.jobs/api/jobReportOptionWeb"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        jobReportOptionListData.add(JobReportOptionWebModel.fromJson(i));
        //notifyListeners();
      }

      return jobReportOptionListData;
    } else {
      print(
          'failed  jobReportOptionWeb  api ' + response.statusCode.toString());

      return jobReportOptionListData;
    }
  }
}