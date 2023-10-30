import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firstapp/model/country_list_model.dart';
import 'package:firstapp/model/email_check_model.dart';
import 'package:firstapp/model/job_seeker_ready_to_work_model.dart';
import 'package:firstapp/model/job_seeker_w_auth_model.dart';
import 'package:firstapp/model/job_skr_add_obj_model.dart';
import 'package:firstapp/model/saved_job_model.dart';
import 'package:firstapp/model/user_info_image_model.dart';
import 'package:firstapp/views_screen/Login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetWorkAuthorizationController with ChangeNotifier{
  List<JobSeekerWorkAuthorizationModel> workAuthListData = [];
  bool isLoading = false;
  notifyListeners();
  Future<List<JobSeekerWorkAuthorizationModel>>
  getJobSeekerWorkAuthorization() async {
    isLoading=true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerWorkAuthorization";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        workAuthListData.add(JobSeekerWorkAuthorizationModel.fromJson(i));

        notifyListeners();
      }
      isLoading = false;
      return workAuthListData;

    } else {
      isLoading = false;

      print('failed work authhhhhhhhhh' + response.statusCode.toString());

      return workAuthListData;
    }
  }
}