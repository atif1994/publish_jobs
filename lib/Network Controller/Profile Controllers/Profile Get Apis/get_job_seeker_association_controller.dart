import '../../../profile_model/job_seeker_association_model.dart';
import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';
class GetJobSeekerAssociationController{
  Future<jobseekerAssociationModel> jobSeekerAssociation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http
          .get(Uri.parse(AppUrls.getJobseekerAssociationUrl),
          headers: requestHeaders)
          .timeout(Duration(seconds: 10));
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        return jobseekerAssociationModel.fromJson(data);
      } else {
        print('failed');
        return jobseekerAssociationModel.fromJson(data);
      }
    } catch (e) {}
    print(e.toString());
    return jobseekerAssociationModel.fromJson(data);
  }
}