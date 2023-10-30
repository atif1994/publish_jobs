import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'package:get/get.dart' hide Response;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';




import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart' hide Response;
import '../../../model/job_seeker_gallary_model.dart';

class GetGalleryController with ChangeNotifier {
  List<JobSeekerGalleryModel> galleryListData = [];
  bool isGetGalleryLoading = false;
  notifyListeners();

  Future<List<JobSeekerGalleryModel>> getGallery() async {
    isGetGalleryLoading=true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };


    String url = "https://api.publish.jobs/api/get-jobseekerGallery";
    Response response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      notifyListeners();
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        galleryListData.add(JobSeekerGalleryModel.fromJson(i)

        );
        notifyListeners();
      }
      isGetGalleryLoading=false;
      return galleryListData;
    } else {
      print('failed gallery status: ' + response.statusCode.toString());
      isGetGalleryLoading=false;
      return galleryListData;
    }
  }
}