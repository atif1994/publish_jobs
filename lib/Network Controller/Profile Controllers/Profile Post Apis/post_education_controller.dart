
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/foundation.dart';

import '../../../App Services/global_vars.dart';
import '../../../views_screen/profile_screen/profile_base_screen.dart';
import '../Profile Get Apis/get_qualification_controller.dart';

class PostEducationController with ChangeNotifier{
  bool loadingEducationUpdate = false;
  bool loadingEducation = false;
  bool loadingEducationDelete = false;
  updateEducation(
      String id,
      String degree_id,
      String institute,
      String startYear,
      String endYear,
      degreeStatus,
      String fieldStudy,
      String description,
      BuildContext context) async {
    GetQualificationController().getEducationList();
    loadingEducationUpdate = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    notifyListeners();
    try {
      loadingEducationUpdate = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/qualification-update?id=$id&degree=$degree_id&institute=$institute&field_study=$fieldStudy&description=$description&start_year=$startYear&in_progress=$degreeStatus&end_year=$endYear";
      // print('here1');
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
            "degree": degree_id,
            "institute": institute,
            "field_study": fieldStudy,
            "description": description,
            "start_year": startYear,
            "end_year": endYear,
            "in_progress": degreeStatus,
          },
          headers: requestHeaders);
      // print('here2');

      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        print('successfully updatedd qualification');
        // var data = jsonDecode(response.body.toString());
        loadingEducationUpdate = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
        // print(institute+"issssssssssssin");
        // print(fieldStudy+"issssssssssss");
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Bar(
        //               id: 2,
        //             )));
      } else {
        Get.defaultDialog(title: 'failed');
        print(response.statusCode.toString() + 'ststusssss');
        print('failed update qualification status: ' +
            response.statusCode.toString());
        loadingEducationUpdate = false;
        notifyListeners();
      }
    } catch (e) {
      Get.defaultDialog(title: 'failed with exception');
      loadingEducationUpdate = false;
      print('here e');

      notifyListeners();
      print(e.toString());
    }
  }
  addEducation(
      String degree_id,
      String institute,
      String startYear,
      String endYear,
      degreeStatus,
      String field_study,

      BuildContext context
      ) async {
    GlobalVarData.addEducation = 'not null';
    loadingEducation = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingEducation = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerAddQualification?degree=$degree_id&institute=$institute&field_study=$field_study&start_year=$startYear&in_progress=$degreeStatus&end_year=2024-02-04";
      // print('here1');
      Response response = await post(Uri.parse(url),
          body: {
            "degree": degree_id,
            "institute": institute,
            "field_study": field_study,
            "start_year": startYear,
            "end_year": endYear,
            "in_progress": degreeStatus,
          },
          headers: requestHeaders);
      // print('here2');

      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        print('successfully added'+response.body.toString());

        loadingEducation = false;
        notifyListeners();


      } else {
        Get.defaultDialog(title: 'failed' + response.statusCode.toString());
        print(response.statusCode.toString() + 'ststusssss');
        print('failed add qualification status: ' +
            response.statusCode.toString());
        loadingEducation = false;
        notifyListeners();
      }
    } catch (e) {
      Get.defaultDialog(title: 'failed with exception');
      loadingEducation = false;
      notifyListeners();
      print('here e'+e.toString());


      print(e.toString());
    }
  }
  void jobEducationDelete(String id, BuildContext context) async {
    loadingEducationDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingEducationDelete = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/qualification-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingEducationDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Bar(
        //           id: 2,
        //         )));
      } else {
        Get.defaultDialog(title: 'Error' + response.statusCode.toString());
        print('failed');
        loadingEducationDelete = false;
        notifyListeners();
      }
    } catch (e) {
      Get.defaultDialog(title: 'Error with exception');
      loadingEducationDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }

}