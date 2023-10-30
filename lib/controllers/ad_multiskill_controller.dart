import 'dart:convert';

import 'package:firstapp/model/Multi%20Select%20Dropdown%20Model/add_skill_model.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../profile_model/job_seeker_skill_model.dart';
import 'package:http/http.dart' as http;
class AddSkillController extends GetxController {
  List<AddSkillModel> subjectData = [];
  List<MultiSelectItem> dropDownData = [];
    List<JobseekerSkillModel> skillListData = [];
    Future<List<JobseekerSkillModel>> jobSeekerSkill() async {
      subjectData.clear();
      dropDownData.clear();
      SharedPreferences pref = await SharedPreferences.getInstance();
      String tokenHeader = await pref.getString('tokenProvider').toString();

      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer ' + tokenHeader
      };

      String url = "https://api.publish.jobs/api/skillsJobseeker";
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        var skilList = jsonDecode(response.body.toString());
          List<AddSkillModel> tempSubjectData = [];
        skilList.forEach(
                (data) {
              tempSubjectData.add(
                AddSkillModel(
                  id: data['id'].toString(),
                  title: data['title'],
                ),
              );
            },
          );
          subjectData.addAll(tempSubjectData);
          dropDownData = subjectData.map((subjectdata) {
            return MultiSelectItem(subjectdata, subjectdata.title);
          }).toList();
          update();
        var data = jsonDecode(response.body.toString());
        print(response.body);
        for (Map<String, dynamic> i in data) {
          // print(response.body.toString()+"string responseeeeeeeeeeeeeeeeeeeeeeeeeeeee");
          skillListData.add(JobseekerSkillModel.fromJson(i));
          //notifyListeners();
        }
        return skillListData;
      } else {
        return skillListData;
      }
    }

}
