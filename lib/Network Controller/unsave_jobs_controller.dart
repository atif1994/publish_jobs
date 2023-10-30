import 'dart:convert';

import 'package:firstapp/model/test_unsaved_jobs_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class UnsavedJObsWithoutAuthentication with ChangeNotifier{
  Future<TestUsavedjobModel> getAppliedJobs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    print(tokenHeader + "token header applay");
    var data;
    print(data.toString()+"show list of applay");
    try {
      final response = await http.get(
          Uri.parse(
              'https://api.publish.jobs/api/get-appliedJobs?page=undefined'),
          headers: requestHeaders);
      data = jsonDecode(response.body.toString());
      print(data.toString()+"applay data ");
      if (response.statusCode == 200) {
        print('get applayed hittttttt');
        return TestUsavedjobModel.fromJson(data);
      } else {
        print(
            'failed saved job other status: ' + response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString() + "savded jobs exception");
    }
    return TestUsavedjobModel.fromJson(data);
  }
}