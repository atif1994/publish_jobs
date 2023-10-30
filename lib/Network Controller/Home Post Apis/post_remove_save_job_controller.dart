import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/AlertDailog.dart';
import '../../widgets/remove_alert_Dailog.dart';
class PostRemoveSaveJobController with ChangeNotifier{
  bool loadingJobSave = false;

  void jobseekerRemoveSaveJob(String job_id, BuildContext context) async {
    loadingJobSave = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    print(tokenHeader);
    Map<String, String> requestHeaders = {
      'Authorization':
      'Bearer ' + tokenHeader
    };
    notifyListeners();

    try {
      loadingJobSave = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/jobseekerRemoveSaveJob?job_id=$job_id";
      Response response = await post(Uri.parse(url),
          body: {
            'job_id': job_id,
          },
          headers: requestHeaders);
      print(response.body.toString() + "job removed response");
      if (response.statusCode == 200) {
        // showDialog(
        //     context: context,
        //     builder: (_) {
        //       return RemoveMyDialog();
        //     });

        loadingJobSave = false;

        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();
      }
    } catch (e) {
      loadingJobSave = false;
      notifyListeners();
      print(e.toString());
    }
  }

}