import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../../model/cuntom_user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart' hide Response;
class GetPersonalInfoController with ChangeNotifier{
  String firstName='';
  String lastName='';
  String email='';
  String countryCode='';
  String countryName='';
  String phoneNo='';
  String image='';
  //Future<UserCustomDataModel>
  jobSeekerPersonalInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http
          .get(Uri.parse('https://api.publish.jobs/api/user-general-get'),
          headers: requestHeaders)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(tokenHeader);
        }
        data = jsonDecode(response.body.toString());
     //   firstName = data['email'];
        notifyListeners();
        if (kDebugMode) {
          print(data+"ggggggggggggggggggg");
        }
       // return UserCustomDataModel.fromJson(data);
      } else {
        print('failed objective status: ' + response.statusCode.toString());
       // return UserCustomDataModel.fromJson(data);
      }
    } catch (e) {

    }
    //return UserCustomDataModel.fromJson(data);
  }

}