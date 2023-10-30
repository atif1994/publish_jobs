import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;

class UpdateTrainingCertification with ChangeNotifier {
  bool loadingUpdateCertificiton = false;

  UpdataTrainingCertification(
      String id,
      String certificate,
      String institute,
      String description,
      String start_date,
      String end_date,
      BuildContext context) async {
    loadingUpdateCertificiton = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      loadingUpdateCertificiton = true;
      notifyListeners();
      String url =
          "https://api.publish.jobs/api/achievement-update?id=$id&certificate=$certificate&institute=$institute&description=$description&start_date=$start_date&end_date=$end_date";

      Response response = await post(Uri.parse(url),
          body: {
            'id': id,
            "certificate": certificate,
            "institute": institute,
            "description": description,
            "start_date": start_date,
            "end_date": end_date,
          },
          headers: requestHeaders);

      if (response.statusCode == 200) {
        print(response.statusCode.toString() + " response");
        print('successfully added experience' +
            response.statusCode.toString() +
            response.body.toString());
        loadingUpdateCertificiton = false;
        notifyListeners();
      } else {
        Get.defaultDialog(title: 'Error' + response.statusCode.toString());

        loadingUpdateCertificiton = false;
        notifyListeners();
      }
    } catch (e) {
      Get.defaultDialog(title: 'Error with exception');
      loadingUpdateCertificiton = false;
      print('here e');

      notifyListeners();
      print(e.toString());
    }
  }
}
