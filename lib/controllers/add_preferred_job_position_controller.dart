import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Multi Select Dropdown Model/add_w_authorization_model.dart';
import 'package:http/http.dart' as http;

import '../model/Multi Select Dropdown Model/preferred_job_position_model.dart';

class PreferredJobPositionController extends GetxController {
  List<AddPreferedPositionModel> preferrefPositionData = [];
  List<MultiSelectItem> dropDownData = [];

  void jobSeekerPreferredPosition() async {
    Timer(
      Duration(seconds: 1),
      () {
        preferrefPositionData.clear();
        dropDownData.clear();
      },
    );
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    String url = "https://api.publish.jobs/api/get-jobPosition";
    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      var skilList = jsonDecode(response.body.toString());
      List<AddPreferedPositionModel> tempWorkAuthtData = [];
      skilList.forEach(
        (data) {
          tempWorkAuthtData.add(
            AddPreferedPositionModel(
              id: data['id'].toString(),
              title: data['title'],
            ),
          );
        },
      );

      preferrefPositionData.addAll(tempWorkAuthtData);

      dropDownData = preferrefPositionData.map((data) {
        return MultiSelectItem(data, data.title);
      }).toList();

      print(dropDownData);

      update();
    } else {
      print('failed');
    }
  }
}
