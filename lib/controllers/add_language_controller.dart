import 'package:get/get.dart';

import '../model/Multi Select Dropdown Model/add_language_model.dart';

import 'dart:async';
import 'dart:convert';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class LanguageController extends GetxController {
  List<AddPreferedLanguageModel> authorizationWorkData = [];
  List<MultiSelectItem> dropDownData = [];

  void jobSeekerLanguage() async {
    authorizationWorkData.clear();
    dropDownData.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    String url = "https://api.publish.jobs/api/get-languages";
    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      authorizationWorkData.clear();
      dropDownData.clear();
      var skilList = jsonDecode(response.body.toString());
      List<AddPreferedLanguageModel> tempWorkAuthtData = [];
      skilList.forEach(
            (data) {
          tempWorkAuthtData.add(
            AddPreferedLanguageModel(
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
      print(authorizationWorkData.toString()+"show list of  language");
    }

    else {
      print('failed');
    }
  }
}
