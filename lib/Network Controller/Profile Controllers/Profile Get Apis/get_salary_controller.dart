import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/get_salary_model.dart';

class GetSalaryController with ChangeNotifier{
  Future<GetjobseekerExpectedSalaryModel> jobGetSalary() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http
          .get(Uri.parse('https://api.publish.jobs/api/get-jobseekerExpectedSalary'),
          headers: requestHeaders)
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        return GetjobseekerExpectedSalaryModel.fromJson(data);
      } else {
        print('failed objective status: ' + response.statusCode.toString());
        return GetjobseekerExpectedSalaryModel.fromJson(data);
      }
    } catch (e) {
      // Fluttertoast.showToast(
      //     msg: "Please Check Your Enternet Connectivity",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 2,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
    }
    return GetjobseekerExpectedSalaryModel.fromJson(data);
  }
}