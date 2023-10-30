import 'dart:convert';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Multi Select Dropdown Model/add_w_authorization_model.dart';
import 'package:http/http.dart' as http;
class WorkAuthorizationController extends GetxController {
  List<AddWorkAuthorizationModel> authorizationWorkData = [];
  List<MultiSelectItem> dropDownData = [];
  void jobSeekerWorkAuthorization() async {
    authorizationWorkData.clear();
    dropDownData.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    String url = "https://api.publish.jobs/api/countries";
    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      var skilList = jsonDecode(response.body.toString());
      List<AddWorkAuthorizationModel> tempWorkAuthtData = [];
      skilList.forEach(
            (data) {
              tempWorkAuthtData.add(
            AddWorkAuthorizationModel(
              id: data['id'].toString(),
              title: data['title'],
            ),
          );
        },
      );
      print('temp12333333');
      print(tempWorkAuthtData);
      print('temp44444444');
      authorizationWorkData.addAll(tempWorkAuthtData);
      print('tempeeeeeee');
      print(authorizationWorkData);
      print('tempdddddddddddd');
      dropDownData = authorizationWorkData.map((data) {
        return MultiSelectItem(data, data.title);
      }).toList();
      print('templlllllll');
      print(dropDownData);
      print('tempmmmmmmmmmm');
      update();
    } else {
      print('failed');
    }
  }

}
