import 'dart:io';
import '../../../model/job_seeker_ready_to_work_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
class GetReadyToWorkController{
  Future<JobSeekerReadyToWorkModel> getJobReadyToWork() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http
          .get(
          Uri.parse(
              'https://api.publish.jobs/api/get-jobseekerReadyToWork'),
          headers: requestHeaders)
          .timeout(Duration(seconds: 10));
      print('get jobs relocation hit:' + response.statusCode.toString());
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print('res job ready To Work statusssssssssssssssssss:');
        return JobSeekerReadyToWorkModel.fromJson(data);
      } else {
        print('ress job Ready To Work statusssssssssssssssssss:' +
            response.statusCode.toString());
        return JobSeekerReadyToWorkModel.fromJson(data);
      }
    } on SocketException {
      Fluttertoast.showToast(
          msg: "Please Check Your Enternet Connectivity",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return JobSeekerReadyToWorkModel.fromJson(data);
  }
}