import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/saved_job_model.dart';
import 'dart:async';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;

class GetSavedJobsController extends ChangeNotifier{
  bool isLoading = false;
  Future<SavedJobModel> getSavedJobs() async {
    isLoading = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };


    var data;


    try {
      final response = await http.get(
          Uri.parse(
              'https://api.publish.jobs/api/get-savedJobs?page=undefined'),
          headers: requestHeaders);
      data = jsonDecode(response.body.toString());
      notifyListeners();

      if (response.statusCode == 200) {

        isLoading = false;
        notifyListeners();
        return SavedJobModel.fromJson(data);
      } else {
        isLoading = false;
        notifyListeners();

      }
    } catch (e) {

      isLoading = false;
      notifyListeners();
    }
    return SavedJobModel.fromJson(data);
  }
}