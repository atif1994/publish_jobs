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


class DataServices with ChangeNotifier {
  bool loadingAddCareerLevel = false;
  bool loadingEducationUpdate = false;
  bool loading = false;
  bool loadingMaritalStatus = false;
  bool loadingJobSeekerDelete = false;
  bool loadingWork = false;

  bool loadingRelocation = false;
  bool loadingInfo = false;
  bool loadingSeeker = false;
  bool loadingSeekerAssociation = false;
  bool emailCheckLoading = false;
  bool loadingEducationDelete = false;
  bool loadingAddExecutive = false;


  String emailCheck = 'guest';
  String token = '';

  setData(String tokenVal) {
    token = tokenVal;
    //email1 = emailVal;
    notifyListeners();
  }






//Get api used in personal info
//   Future<UserCustomDataModel> getProfilePersonalInfo() async {
//     UserCustomDataModel userCustomData = UserCustomDataModel();
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String tokenHeader = await pref.getString('tokenProvider').toString();
//     Map<String, String> requestHeaders = {
//       'Authorization': 'Bearer ' + tokenHeader
//     };
//     dynamic data;
//     try {
//       print('hit from try');
//       final response = await http.get(
//           Uri.parse('https://api.publish.jobs/api/get-persnolInfo'),
//           headers: requestHeaders);
//       // .timeout(Duration(seconds: 10));
//       if (response.statusCode == 200) {
//         print('get get personal info api hitttt');
//         data = jsonDecode(response.body.toString());
//         print(data);
//         notifyListeners();
//         // print((data['jobseeker_info']['first_name'] ?? 'null'));
//         // print((data['jobseeker_info']['last_name'] ?? 'null'));
//         // print((data['user_image']['image'] ?? 'null'));
//        // userCustomData.imageUrl='touseef';
//        // userCustomData.imageUrl='touseef';
//         userCustomData.email = data['email'];
//         if(data['user_image'].toString()!='null'){
//           userCustomData.imageUrl=data['user_image'];
//         }
//         else if(data['user_image'].toString()=='null'){
//           userCustomData.imageUrl='https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';
//         }
//         else if(data['jobseeker_info'].toString()!='null'){
//           print('runnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn if');
//           userCustomData.firstName = data['jobseeker_info']['first_name'];
//           userCustomData.lastName = data['jobseeker_info']['last_name'];
//         }
//         else if(data['jobseeker_info'].toString()=='null'){
//           print('runnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn if else');
//           userCustomData.firstName = '';
//           userCustomData.lastName  =  '';
//         }
//         else{
//           print('');
//         }
//         print(data['email'].toString()+'emailllllllllllllllll');
//         print(userCustomData.firstName.toString()+'usernameeeeeeeeeeee');
//         print(data['jobseeker_info'].toString()+'job seeker info else');
//         print('custom data of image url is'+userCustomData.imageUrl.toString());
//         return userCustomData;
//       } else {
//         print('failed persnal info error status code: ' +
//             response.statusCode.toString());
//         Get.to(Bar(id: 2,));
//         return UserCustomDataModel();
//       }
//     } catch (e) {
//       print(e.toString() + ' get personalInfo exception');
//       // Fluttertoast.showToast(
//       //     msg: "Please Check Your Enternet Connectivity",
//       //     toastLength: Toast.LENGTH_LONG,
//       //     gravity: ToastGravity.CENTER,
//       //     timeInSecForIosWeb: 2,
//       //     textColor: Colors.white,
//       //     fontSize: 16.0
//       // );
//     }
//     return UserCustomDataModel();
//   }

  // Future<UserDataNdProfileModel> getProfileImage(BuildContext context) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String tokenHeader = await pref.getString('tokenProvider').toString();
  //   Map<String, String> requestHeaders = {
  //     'Authorization': 'Bearer ' + tokenHeader
  //   };
  //   dynamic data;
  //   try {
  //     print(tokenHeader);
  //     final response = await http.get(
  //         Uri.parse('https://api.publish.jobs/api/get-user'),
  //         headers: requestHeaders);
  //     // .timeout(Duration(seconds: 10));
  //     if (response.statusCode == 200) {
  //       print('get profile image info api hitttt');
  //       print(response.body.toString());
  //       data = jsonDecode(response.body.toString());
  //       notifyListeners();
  //       return UserDataNdProfileModel.fromJson(data);
  //     } else {
  //       print('failed profile image error status code: ' +
  //           response.statusCode.toString());
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => Bar(
  //                 id: 2,
  //               )));
  //       return UserDataNdProfileModel.fromJson(data);
  //     }
  //   } catch (e) {
  //     print(e.toString() + ' personalInfo exception');
  //     // Fluttertoast.showToast(
  //     //     msg: "Please Check Your Enternet Connectivity",
  //     //     toastLength: Toast.LENGTH_LONG,
  //     //     gravity: ToastGravity.CENTER,
  //     //     timeInSecForIosWeb: 2,
  //     //     textColor: Colors.white,
  //     //     fontSize: 16.0
  //     // );
  //   }
  //   return UserDataNdProfileModel.fromJson(data);
  // }



//   List<JobsDetailsModel> jobDetailData = [];
//
//   Future<List<JobsDetailsModel>> jobDetail(String uuid) async {
// print("123444");
//     loading = true;
//     notifyListeners();
//
//     String url = "https://api.publish.jobs/api/job-detail?id=$uuid";
//
//     Response response = await post(Uri.parse(url), body: {
//       'id': uuid,
//     });
//     if (response.statusCode == 200) {
// print("4567");
//       print(response.toString()+"resposr show");
//       var data = jsonDecode(response.body.toString());
//       print(data+"dfkajhkdj");
//       for (Map<String, dynamic> i in data) {
//         print(data+"show data");
//         jobDetailData.add(JobsDetailsModel.fromJson(i));
//       }
//       loading = false;
//       notifyListeners();
//       return jobDetailData;
//     } else {
//       print('failed applied jobs status: ' + response.statusCode.toString());
//       loading = false;
//       notifyListeners();
//       return jobDetailData;
//     }
//   }























































  jobSubmit(String id, BuildContext context) async {
    loading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + '5|PL6l5AtzoS1TKo7HOlPLqQw21XMYgyalVC5WYFiA',
      //'Connection': 'Keep-Alive'
    };

    notifyListeners();
    try {
      loading = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/jobseekerAddApplyJob?id=$id";
      // print('here1');
      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
          },
          headers: requestHeaders);
      // print('here2');
      Get.defaultDialog(title: 'Here 2');
      if (response.statusCode == 200) {
        Get.defaultDialog(title: 'Successfully Updated');
        loading = false;
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
      } else if (response.statusCode == 500) {
        Get.defaultDialog(title: 'Already Applied this job');
      } else {
        Get.defaultDialog(title: 'failed' + response.statusCode.toString());
        print(response.statusCode.toString() + 'ststusssss');
        print('failed update qualification status: ' +
            response.statusCode.toString());
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      Get.defaultDialog(middleText: e.toString());
      loading = false;
      print('here e');

      notifyListeners();
      print(e.toString());
    }
  }


}
