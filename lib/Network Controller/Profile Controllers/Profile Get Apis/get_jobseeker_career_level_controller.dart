import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:get/get.dart' hide Response;
import '../../../model/job_seeker_job_location_model.dart';
import '../../../model/job_seeker_career_level_model.dart';

class GetJobSeekerCareerLavel  {
  List<JobCareerLavelModel> preferredJobCareerLevel = [];

  Future<List<JobCareerLavelModel>> getJobSeekerCareerLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/get-jobseekerCareerLevel";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        preferredJobCareerLevel.add(JobCareerLavelModel.fromJson(i));
        //notifyListeners();
      }

      return preferredJobCareerLevel;
    } else {
      print('failed job seeker career level api hit' +
          response.statusCode.toString());


      return preferredJobCareerLevel;
    }
  }
}