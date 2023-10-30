import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../views_screen/Login_screen/otp_screen.dart';

class ForgotPasswordController with ChangeNotifier {
  bool forgotLoading = false;

  ForgotpasswordData(String email, BuildContext context) async {
    forgotLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    print(tokenHeader);
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    notifyListeners();

    try {
      forgotLoading = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/linkpassword?email=$email";
      Response response = await post(Uri.parse(url),
          body: {
            'email': email,
          },
          headers: requestHeaders);
      print(response.body.toString()+"response sent your email");
      if (response.statusCode == 200) {
        print("successful hit email");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
      } else {
        print("failded forgot password");
        forgotLoading = false;
        notifyListeners();

        forgotLoading = false;
        notifyListeners();
      }
    } catch (e) {
      forgotLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
