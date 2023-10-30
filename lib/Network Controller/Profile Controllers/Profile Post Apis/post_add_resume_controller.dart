import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart' hide Response;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../model/job_seeker_add_resume.dart';
import '../../../profile_model/job_skr_add_achivement_model.dart';
import 'package:get/get.dart' hide Response;


class PostAddResumeController with ChangeNotifier {
   bool loadingAddResume=false;
  // jobSeekerAddResume(
  //      file, id, BuildContext context) async {
  //
  //   loadingAddResume = true;
  //   notifyListeners();
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String tokenHeader = await pref.getString('tokenProvider').toString();
  //   Map<String, String> requestHeaders = {
  //     'Authorization': 'Bearer ' + tokenHeader
  //   };
  //
  //
  //   String url =
  //       'https://api.publish.jobs/api/jobseekerAddResume?file=$file&id=$id';
  //   Response response = await post(Uri.parse(url),
  //       body: {
  //         'file': file,
  //         'id': id,
  //       },
  //       headers: requestHeaders);
  //   loadingAddResume = false;
  //   notifyListeners();
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     print('add resume');
  //
  //     loadingAddResume = false;
  //     notifyListeners();
  //     return JobSeekerAddResume.fromJson(data);
  //   } else {
  //     print("file date resume");
  //     loadingAddResume = false;
  //     notifyListeners();
  //     return JobSeekerAddResume.fromJson(data);
  //   }
  // }
   jobSeekerAddResume(
       file ,
       String  id,

       BuildContext context) async {
     loadingAddResume = true;
     notifyListeners();
     SharedPreferences pref = await SharedPreferences.getInstance();
     String tokenHeader = await pref.getString('tokenProvider').toString();
     Map<String, String> requestHeaders = {
       'Authorization': 'Bearer ' + tokenHeader
     };

     try {
       loadingAddResume = true;
       notifyListeners();
       String url =
           'https://api.publish.jobs/api/jobseekerAddResume?file=$file&id=$id';

       Response response = await post(Uri.parse(url),
           body: {
             "file": file,
             "id": id,

           },
           headers: requestHeaders);


       if (response.statusCode == 200) {
         print(response.statusCode.toString() + " response");
         print('successfully added experience' +
             response.statusCode.toString() +
             response.body.toString());
         loadingAddResume = false;
         notifyListeners();


       } else {
         Get.defaultDialog(title: 'Error' + response.statusCode.toString());
         print(response.statusCode.toString() + 'ststusssss');
         print(
             'failed add experience status: ' + response.statusCode.toString());
         loadingAddResume = false;
         notifyListeners();
       }
     } catch (e) {
       Get.defaultDialog(title: 'Error with exception');
       loadingAddResume = false;
       print('here e');

       notifyListeners();
       print(e.toString());
     }
   }

}