import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
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

import '../../../model/job_seeker_gender_model.dart';

class GetGenderLevelController{
  List<JobSeekerGenderModel> genderLevelListData = [];

  Future<List<JobSeekerGenderModel>> getGenderlevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    Response response;
    String url = "https://api.publish.jobs/api/get-gender";
    response = await http.get(Uri.parse(url), headers: requestHeaders);

    try{
      if (response.statusCode == 200) {
        print('get gender hit api');

        var data = jsonDecode(response.body.toString());
        for (Map<String, dynamic> i in data) {
          genderLevelListData.add(JobSeekerGenderModel.fromJson(i));
        }




        return genderLevelListData;
      }
      else {



        return genderLevelListData;
      }
      return genderLevelListData;

    }

    catch(e){
      print('marital status exception');
      print(e.toString());
    }
    return genderLevelListData;
  }
}