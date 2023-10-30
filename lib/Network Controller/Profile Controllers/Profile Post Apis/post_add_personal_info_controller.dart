import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';

import '../../../App Services/global_vars.dart';
import '../../../views_screen/applay_screen/applay_experience_screen.dart';
import '../../../views_screen/applay_screen/applay_qualification_screen.dart';
import '../Profile Get Apis/get_personal_Info_controller.dart';
import '../Profile Get Apis/get_qualification_controller.dart';

class PostAddPersonalInfoController with ChangeNotifier {
  bool loadingInfo = false;

  String navDeciderr ='';

  jobSeekerAddPersonalInfo(String first_name, String last_name,
      String country_id, String mobile,String mobile_code, BuildContext context) async {
    loadingInfo = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    notifyListeners();
    try {
      loadingInfo = true;
      notifyListeners();
      String url = "https://api.publish.jobs/api/user-general-update";
      Response response = await post(Uri.parse(url),
          body: {
            'first_name': first_name,
            "last_name": last_name,
            "country_id": country_id,
            "mobile": mobile,
            "mobile_code":mobile_code,
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        print("successful load");
        // var data = jsonDecode(response.body.toString());
        loadingInfo = false;
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        notifyListeners();







      } else {
        print('failed to add personal info status: ' +
            response.statusCode.toString());
        loadingInfo = false;
        notifyListeners();
      }
    } catch (e) {
      loadingInfo = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
