
import 'package:flutter/cupertino.dart';

import '../../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../../model/cuntom_user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart' hide Response;
class GetAppBarImageController with ChangeNotifier{
  String userProfileImage="https://api.publish.jobs/pjcloud/userAccountImage/";
  String? isNull;
  jobSeekerAppbarImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http
          .get(Uri.parse('https://api.publish.jobs/api/user-general-get'),
          headers: requestHeaders)
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        userProfileImage = userProfileImage+data['user_image']['image'];
        notifyListeners();
        isNull = data['user_image']['image'].toString();
        notifyListeners();
        //  return UserCustomDataModel.fromJson(data);
      } else {
        print('failed objective status: ' + response.statusCode.toString());
        //return UserCustomDataModel.fromJson(data);
      }
    } catch (e) {

    }
    // return UserCustomDataModel.fromJson(data);
  }

}