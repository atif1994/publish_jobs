
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_available_country_model.dart';

class UserAvailableCountryController with ChangeNotifier{
  List<UserAvailableCountryModel> userAvailableCountryListData = [];
  bool isLoading = false;
  notifyListeners();
  Future<List<UserAvailableCountryModel>> userAvailableCountry() async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader =  pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    String url = "https://api.publish.jobs/api/userAvailableCountry";
    Response response = await http.get(Uri.parse(url),
        headers: requestHeaders);
    if (response.statusCode == 200) {

      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        userAvailableCountryListData.add(UserAvailableCountryModel.fromJson(i));
        notifyListeners();
      }
      isLoading = false;
      return userAvailableCountryListData;
    } else {
      isLoading = false;
      notifyListeners();

      return userAvailableCountryListData;
    }
  }
}