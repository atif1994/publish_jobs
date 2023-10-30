import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:get/get.dart' hide Response;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';


import '../../../model/jobseekergetmaritalstatus.dart';

class GetMaritalStatusController{
  List<JobSeekerMaritalStatusModel> maritalLevelListData = [];

  Future<List<JobSeekerMaritalStatusModel>> getMaritallevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    Response response;
    String url = "https://api.publish.jobs/api/get-maritalstatus";
    response = await http.get(Uri.parse(url), headers: requestHeaders);

    try{
      if (response.statusCode == 200) {
        print('Martial status hit api');
        print('here merital 1');
        var data = jsonDecode(response.body.toString());
        for (Map<String, dynamic> i in data) {
          maritalLevelListData.add(JobSeekerMaritalStatusModel.fromJson(i));
        }
        print('here merital 2');
        print(maritalLevelListData.toString()+' marital api data');

        print(maritalLevelListData.toString()+' marital api data');
        return maritalLevelListData;
      }
      else {
        print('failed Martial status : ' + response.statusCode.toString());

        print(maritalLevelListData.toString()+' marital api data');
        return maritalLevelListData;
      }
      return maritalLevelListData;

    }

    catch(e){
      print('marital status exception');
      print(e.toString());
    }
    return maritalLevelListData;
  }
}