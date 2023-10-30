import 'package:firstapp/component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
class PostApplayLaterController with ChangeNotifier{
  ApplayLater(String job_id, BuildContext context) async {

    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    String url =
        "https://api.publish.jobs/api/jobseekerAddSaveJob?job_id=$job_id";
    try {
      Response response = await post(Uri.parse(url),
          body: {"job_id": job_id}, headers: requestHeaders);
      if(response.statusCode==200){
        print("applay job Later");

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Bar(id: 2,)),);

      }else{

        print("error");
      }
    } catch (e) {
      print(e.toString()+"Catch error");

    }
  }





}