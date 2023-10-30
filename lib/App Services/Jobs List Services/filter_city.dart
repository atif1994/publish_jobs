import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class CityListService with ChangeNotifier {
  final String urlJoptype = "https://api.publish.jobs/api/jobTypeFilter";
  List jobTypeListData = [];
  List jobList = [];

  Future<String> getJobType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse(urlJoptype),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    jobTypeListData = resBody;
    notifyListeners();
    //  print(resBody);
    return "Sucess";
  }
}
