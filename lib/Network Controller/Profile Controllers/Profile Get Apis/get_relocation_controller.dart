import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/job_seeker_relocation_model.dart';

class GetRelocationController{
  Future<JobSeekerRelocationModel> getJobRelocation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http
          .get(
          Uri.parse('https://api.publish.jobs/api/get-jobseekerRelocation'),
          headers: requestHeaders)
          .timeout(Duration(seconds: 10));
      print('get jobs relocation hit:' + response.statusCode.toString());
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print('res job relocation statusssssssssssssssssss:');
        return JobSeekerRelocationModel.fromJson(data);
      } else {
        print('ress job relocation statusssssssssssssssssss:' +
            response.statusCode.toString());
        return JobSeekerRelocationModel.fromJson(data);
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
    return JobSeekerRelocationModel.fromJson(data);
  }
}