import 'dart:convert';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Multi Select Dropdown Model/add_w_authorization_model.dart';
import 'package:http/http.dart' as http;

import '../model/Multi Select Dropdown Model/preferred_job_type_model.dart';
class PreferredJobTypeController extends GetxController {
  List<AddPreferedJobTypeModel> authorizationWorkData = [];
  List<MultiSelectItem> dropDownData = [];

  void jobSeekerPreferredJobType() async {
    authorizationWorkData.clear();
    dropDownData.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    String url = "https://api.publish.jobs/api/get-jobTypeOption";
    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      authorizationWorkData.clear();
      dropDownData.clear();
      var skilList = jsonDecode(response.body.toString());
      List<AddPreferedJobTypeModel> tempWorkAuthtData = [];
      skilList.forEach(
            (data) {
          tempWorkAuthtData.add(
            AddPreferedJobTypeModel(
              id: data['id'].toString(),
              title: data['title'],
            ),
          );
        },
      );
      authorizationWorkData.addAll(tempWorkAuthtData);
      dropDownData = authorizationWorkData.map((data) {
        return MultiSelectItem(data, data.title);
      }).toList();
      update();
    } else {
      print('failed');
    }
  }

}
