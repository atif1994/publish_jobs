

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/foundation.dart';
class PostDeleteAlertProfileBase with ChangeNotifier{
  bool loadingSkillDelete = false;
  bool loadingSkillDeleteApplay = false;
  bool loadingExcutiveDelete = false;
  bool loadingWorkAuthDelete = false;
  bool loadingLanguageDelete = false;
  bool loadingGalleryDelete = false;
  bool loadingPreferredPositionDelete = false;
  bool loadingCertificationDelete = false;
  bool loadingSalaryDelete = false;
  bool loadingEducationDelete = false;
  bool loadingJobSeekerDelete = false;
  bool loadingJobLocationDelete = false;
  bool loadingJobTypeDelete = false;
  bool loadingJobCareerDelete = false;
  void jobSkillDelete(String id, BuildContext context) async {
    loadingSkillDelete = true;
    loadingSkillDeleteApplay = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingSkillDelete = true;
      loadingSkillDeleteApplay = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/jobseekerSkill-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingSkillDelete = false;
        loadingSkillDeleteApplay = false;
        notifyListeners();
      } else {
        print('failed');
        loadingSkillDelete = false;
        loadingSkillDeleteApplay = false;

        notifyListeners();
      }
    } catch (e) {
      loadingSkillDelete = false;
      loadingSkillDeleteApplay = false;

      notifyListeners();
      print(e.toString());
    }
  }
  void jobWorkAuthDelete(String id, BuildContext context) async {
    loadingWorkAuthDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingWorkAuthDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerWorkAuthorization-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingWorkAuthDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      } else {
        print('failed');
        loadingWorkAuthDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingWorkAuthDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
  void jobLanguageDelete(String id, BuildContext context) async {
    loadingLanguageDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingLanguageDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerLanguage-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingLanguageDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      } else {
        print('failed');
        loadingLanguageDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingLanguageDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
  void jobGalleryDelete(String id, BuildContext context) async {
    loadingGalleryDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingGalleryDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerGallery-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingGalleryDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      } else {
        print('failed');
        loadingGalleryDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingGalleryDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
  void jobTypeDeleteLocation(String id, BuildContext context) async {
    loadingJobLocationDelete = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    notifyListeners();
    try {
      loadingJobLocationDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerPreferredLocation-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        loadingJobLocationDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      } else {
        print('failed');
        loadingJobLocationDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingJobLocationDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
  void jobTypeDelete(String id, BuildContext context) async {
    loadingJobTypeDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingJobTypeDelete = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/jobseekerJobType-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        loadingJobTypeDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      } else {
        print('failed');
        loadingJobTypeDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingJobTypeDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
  jobSeekerDeleteCareerLevel(String id, BuildContext context) async {
    loadingJobCareerDelete = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    notifyListeners();
    try {
      loadingJobCareerDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerCareerLevel-delete/$id";

      Response response = await post(Uri.parse(url),
          body: {
            "id": id,
          },
          headers: requestHeaders);
      // print('here2');

      if (response.statusCode == 200) {
        print('successfully added');
        loadingJobCareerDelete = false;
        notifyListeners();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Bar(
        //           id: 2,
        //         )));
      } else {
        print(response.statusCode.toString() + 'ststusssss');
        print(
            'failed add experience status: ' + response.statusCode.toString());
        loadingJobCareerDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingJobCareerDelete = false;
      print('here e');

      notifyListeners();
      print(e.toString());
    }
  }



  void jobPreferredPositionDelete(String id, BuildContext context) async {
    loadingPreferredPositionDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingPreferredPositionDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerJobPosition-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingPreferredPositionDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      } else {
        print('failed');
        loadingPreferredPositionDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingPreferredPositionDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
  void jobTraningDelete(String id, BuildContext context) async {
    loadingCertificationDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingCertificationDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerAchievement-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        loadingCertificationDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();

      } else {
        print('failed');
        loadingCertificationDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingCertificationDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
  void jobSalaryDelete(String id, BuildContext context) async {
    loadingSalaryDelete = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingSalaryDelete = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerExpectedSalary-delete/$id";
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        print("Salary Deleta successfully");
        loadingSalaryDelete = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      } else {
        print('failed');
        loadingSalaryDelete = false;
        notifyListeners();
      }
    } catch (e) {
      loadingSalaryDelete = false;
      notifyListeners();
      print(e.toString());
    }
  }
}