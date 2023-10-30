import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class CountryListService with ChangeNotifier {

  List countryListData = [];

  Future<String> getCountryList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse('https://api.publish.jobs/api/countries'),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
      countryListData = resBody;
    notifyListeners();
    // print(resBody);
    return "Sucess";
  }
}
