import 'package:firstapp/model/get_salary_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;

import '../../../App Services/global_vars.dart';

class PostAddExpectedSalaryController with ChangeNotifier {
  bool addSalaryLoading = false;

  jobAddSalary(String id, String currency, String salaryType_id,
      String desired_pay, BuildContext context) async {
    addSalaryLoading = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };

    try {
      final Url =
          'https://api.publish.jobs/api/jobseekerAddExpectedSalary?id=$id&currency=$currency&salaryType_id=$salaryType_id&desired_pay=$desired_pay';
      Response response = await post(Uri.parse(Url),
          body: {
            'id': id,
            'currency': currency,
            'salaryType_id': salaryType_id,
            'desired_pay': desired_pay
          },
          headers: requestHeaders);
      if (response.statusCode == 200) {
        print(response.body.toString() + "show response");
        addSalaryLoading = false;
        notifyListeners();



        print("add salary successful");
      } else {
        addSalaryLoading = false;
        notifyListeners();
        print("shoW error not add successful");
      }
    } catch (e) {
      addSalaryLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
