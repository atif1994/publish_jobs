import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;

class UpdatePasswordController with ChangeNotifier {
  bool UpdateLoading = false;
  bool isIncorrectPassWord = false;
  var data;
  String invelidPassword='initial';

  Future<void>  UpdatePassword(String current_password, String password,
      String password_confirmation,BuildContext context) async {
    UpdateLoading = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    print(requestHeaders.toString()+"shot header");
    String url =
        "https://api.publish.jobs/api/updatePassword?current_password=$current_password&password=$password&password_confirmation=$password_confirmation";
    try {
      Response res = await post(Uri.parse(url),
          body: {
            "current_password": current_password,
            "password": password,
            "password_confirmation": password_confirmation
          },
          headers: requestHeaders);
      if (res.statusCode == 200) {
        UpdateLoading = false;
        notifyListeners();
        print(res.body.toString());
        data = jsonDecode(res.body.toString());
        invelidPassword=data['message'];
        notifyListeners();


        print("Response is successfully generated");


      }
      else if  (res.statusCode == 201) {
        UpdateLoading = false;
        notifyListeners();
        print(res.body.toString());
        data = jsonDecode(res.body.toString());
        print(data['message']);
        invelidPassword=data['message'];

        notifyListeners();


        print("Response is successfully generated");


      }
      else {

        UpdateLoading = false;
        notifyListeners();

      }



    } catch (e) {
      UpdateLoading = false;
      notifyListeners();
      print(e.toString() + "updata error");
    }
  }

}
