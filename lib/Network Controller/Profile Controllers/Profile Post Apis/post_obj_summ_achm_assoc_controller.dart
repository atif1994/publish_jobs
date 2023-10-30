import 'dart:convert';

import '../../../model/job_skr_add_smry_model.dart';
import '../../../profile_model/job_skr_add_achivement_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/foundation.dart';

import '../../../profile_model/job_skr_add_association_model.dart';
class PostObjSummaryAchivementAssociationController with ChangeNotifier{
  bool loadingAddAchievement = false;
  bool loadingSeeker = false;
  bool loadingassocation = false;
  bool loadingSeekerSummary = false;
  bool loadingAddAssociation = false;
  bool loadingExcutiveDelete = false;
  bool loadingAchievementDelete = false;
  bool loadingAssociationDelete = false;
  bool loadingAboutDelete = false;



  Future<jobSeekerAddAchievementModel> jobSeekerAddAchievement(
      String achievement, String id, BuildContext context) async {

    loadingAddAchievement = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    loadingAddAchievement = true;
    notifyListeners();
    String url =
        'https://api.publish.jobs/api/jobseekerAddAchievement?achievement=$achievement&id=$id';
    Response response = await post(Uri.parse(url),
        body: {
          'summary': achievement,
          'id': id,
        },
        headers: requestHeaders);
    loadingAddAchievement = false;

    notifyListeners();
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print('Updated successfully');

      loadingAddAchievement = false;

      return jobSeekerAddAchievementModel.fromJson(data);
    } else {
      loadingAddAchievement = false;

      return jobSeekerAddAchievementModel.fromJson(data);
    }
  }
  jobSeekerAddObjectives(
      String objective, String id, BuildContext context) async {
    loadingSeeker = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var data;
    try{
      String url =
          'https://api.publish.jobs/api/jobseekerAddObjective?objective=$objective&id=$id';
      Response response = await post(Uri.parse(url),
          body: {
            'objective': objective,
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        print('Updated successfully');
        loadingSeeker = false;
        notifyListeners();
        // return JobSeekerAddObjectiveModel.fromJson(data);
      } else {
        // loading = false;
        loadingSeeker = false;
        notifyListeners();
        print('failed addObjectice status: ' + response.statusCode.toString());
        //return JobSeekerAddObjectiveModel.fromJson(data);
      }
    }
    catch(e){
      print('handled');
    }
    // return JobSeekerAddObjectiveModel.fromJson(data);
  }
  Future<jobseekerAddSummaryModel> jobSeekerAddSummary(
      String summary, String id, BuildContext context) async {

    loadingSeekerSummary = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url =
        'https://api.publish.jobs/api/jobseekerAddSummary?summary=$summary&id=$id';
    Response response = await post(Uri.parse(url),
        body: {
          'summary': summary,
          'id': id,
        },
        headers: requestHeaders);
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      print('Updated successfully');

      loadingSeekerSummary = false;
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Bar(
      //               id: 2,
      //             )));
      return jobseekerAddSummaryModel.fromJson(data);
    } else {
      print('falield add summery status: ' + response.statusCode.toString());
      loadingSeekerSummary = false;
      return jobseekerAddSummaryModel.fromJson(data);
    }
  }
  Future <jobseekerAddAssociationModel> jobSeekerAddAssociation(
      String association, String id, BuildContext context) async {
    loadingAddAssociation = true;

    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url =
        'https://api.publish.jobs/api/jobseekerAddAssociation?association=$association&id=$id';
    Response response = await post(Uri.parse(url),
        body: {
          'association': association,
          'id': id,
        },
        headers: requestHeaders);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print('Updated successfully');
      loadingAddAssociation = false;

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Bar(
      //           id: 2,
      //         )));
      return jobseekerAddAssociationModel.fromJson(data);
    } else {
      loadingAddAssociation = false;

      return jobseekerAddAssociationModel.fromJson(data);
    }
  }
  void jobAboutDelete(String id, BuildContext context) async {
    loadingAboutDelete = true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    notifyListeners();

    try {
      loadingAboutDelete = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/jobseekerObjective-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        loadingAboutDelete = false;
        notifyListeners();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Bar(
        //               id: 2,
        //             )));

        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);

      } else {
        print('failed');
        loadingAboutDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingAboutDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }

  void jobExcutiveDelete(String id, BuildContext context) async {
    loadingExcutiveDelete = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    notifyListeners();
    try {
      loadingExcutiveDelete = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/jobseekerSummary-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        loadingExcutiveDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Bar(
        //               id: 2,
        //             )));
      } else {
        print('failed');
        loadingExcutiveDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingExcutiveDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }

  void jobAchievementDelete(String id, BuildContext context) async {
    loadingAchievementDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingAchievementDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerAchievement-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingAchievementDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Bar(
        //               id: 2,
        //             )));
      } else {
        print('failed');
        loadingAchievementDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingAchievementDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }

  void jobAssociationDelete(String id, BuildContext context) async {
    loadingAssociationDelete = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    notifyListeners();
    try {
      loadingAssociationDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerAssociation-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingAssociationDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Bar(
        //               id: 2,
        //             )));
      } else {
        print('failed');
        loadingAssociationDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingAssociationDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
}