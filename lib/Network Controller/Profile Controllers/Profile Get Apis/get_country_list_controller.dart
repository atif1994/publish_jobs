import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:get/get.dart' hide Response;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';


import '../../../model/job_seeker_career_level_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart' hide Response;
import '../../../model/country_list_model.dart';

class GetCountryListController{
  List<CountriesListModel> countryListData = [];

  Future<List<CountriesListModel>> getCountriesList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };


    String url = "https://api.publish.jobs/api/countries";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        countryListData.add(CountriesListModel.fromJson(i));
      }

      return countryListData;
    } else {
      print('failed countries status: ' + response.statusCode.toString());

      return countryListData;
    }
  }
}