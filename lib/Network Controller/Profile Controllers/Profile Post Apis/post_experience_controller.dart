

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/foundation.dart';
class PostExperienceController with ChangeNotifier{
  bool loadingAddExperience = false;
  bool loadingExperienceDelete = false;
  bool loadingUpdateWorkExperience = false;

  addExperience(
      String title,
      String company,
      String description,
      String start_date,
      String end_date,
      String currently_work,
      BuildContext context) async {
    loadingAddExperience = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingAddExperience = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/AddWorkExperience?title=$title&company=$company&description=$description&start_date=$start_date&end_date=$end_date&currently_work=$currently_work";

      Response response = await post(Uri.parse(url),
          body: {
            "title": title,
            "company": company,
            "description": description,
            "start_date": start_date,
            "end_date": end_date,
            "currently_work": currently_work,
          },
          headers: requestHeaders);


      if (response.statusCode == 200) {
        print(response.statusCode.toString() + " response");
        print('successfully added experience' +
            response.statusCode.toString() +
            response.body.toString());
        loadingAddExperience = false;
        notifyListeners();


      } else {
        Get.defaultDialog(title: 'Error' + response.statusCode.toString());
        print(response.statusCode.toString() + 'ststusssss');
        print(
            'failed add experience status: ' + response.statusCode.toString());
        loadingAddExperience = false;
        notifyListeners();
      }
    } catch (e) {
      Get.defaultDialog(title: 'Error with exception');
      loadingAddExperience = false;
      print('here e');

      notifyListeners();
      print(e.toString());
    }
  }
  void jobExperienceDelete(String id, BuildContext context) async {
    loadingExperienceDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingExperienceDelete = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/workExperience-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingExperienceDelete = false;
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
        loadingExperienceDelete = false;
        notifyListeners();
      }
    } catch (e) {
      Get.defaultDialog(title: 'Error jobexperience delete');
      loadingExperienceDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
  jobSeekerUpdateWorkExperience(
      String id,
      String title,
      String company,
      String description,
      String start_date,
      String end_date,
      String currently_work,
      BuildContext context) async {
    loadingUpdateWorkExperience = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingUpdateWorkExperience = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/workExperience-update?id=$id& company=$company&title=$title&description=$description&start_date=$start_date&end_date=$end_date&currently_work=$currently_work";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
            " company": company,
            "title": title,
            "description": description,
            "start_date": start_date,
            "end_date": end_date,
            "currently_work": currently_work,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        loadingUpdateWorkExperience = false;
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
        loadingUpdateWorkExperience = false;
        notifyListeners();
      }
    } catch (e) {
      Get.defaultDialog(title: 'Error work experience');
      loadingUpdateWorkExperience = false;
      notifyListeners();
      print(e.toString());
    }
  }
}