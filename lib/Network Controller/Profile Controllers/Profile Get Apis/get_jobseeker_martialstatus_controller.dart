import 'package:flutter/cupertino.dart';

import '../../../model/job_seeker_martial_status_model.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/job_skill_model.dart';
import '../../../profile_model/job_seeker_skill_model.dart';
import '../../../utils/app_urls.dart';
import '../../../model/job_seeker_gender_model.dart';
class GetJobSeekerMartialStatusController with ChangeNotifier {


  Future<JobSeekerStatusModel> getJobSeekerMartialStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerMaritalStatus";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    dynamic data;
   try{
     if (response.statusCode == 200) {

       notifyListeners();
       data = jsonDecode(response.body.toString());
       JobSeekerStatusModel.fromJson(data);


     } else {
       print('failed get-jobseekerGender api' + response.statusCode.toString());

       return JobSeekerStatusModel.fromJson(data);
     }
   }catch(e){

   }
    return JobSeekerStatusModel.fromJson(data);
  }
}