import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../model/all_jobs_model.dart';
import '../../model/all_company_model.dart';
class GetCompanyListController{
  Future<AllCompanyListModel> getCompanyList(int page,String name ) async {
    dynamic data;
    try {
      final response = await http
          .get(Uri.parse(
          'http://api.publish.jobs/api/get-allCompanies?page=$page&&q=$name'))
          .timeout(Duration(seconds: 10));
      // print(response.body.toString()+"show all data");
      data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return AllCompanyListModel.fromJson(data);
      } else {
        print('failed all jobs statusssssss:' + response.statusCode.toString());
        return AllCompanyListModel.fromJson(data);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString()+"catchhhhhhhhhhhhhhh",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.toString() + "catchhhhhhhhhhhhhhh");
    }
    return AllCompanyListModel.fromJson(data);
  }
}