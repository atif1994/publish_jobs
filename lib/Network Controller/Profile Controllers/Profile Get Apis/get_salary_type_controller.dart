import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:get/get.dart' hide Response;
import '../../../model/expacted_salary_model.dart';
import '../../../model/job_seeker_job_location_model.dart';
import '../../../model/job_seeker_career_level_model.dart';
class GetSalaryTypeController{
  List<jobseekerSalaryTypeModel> SalaryTypeData = [];

 Future <List<jobseekerSalaryTypeModel>>  getSalaryType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };


    String url = "https://api.publish.jobs/api/get-salarytype";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        SalaryTypeData.add(jobseekerSalaryTypeModel.fromJson(i));
      }

      return SalaryTypeData;
    } else {
      print('failed careeer level status: ' + response.statusCode.toString());

      return SalaryTypeData;
    }
  }
}