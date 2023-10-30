import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_skill_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_work_authorization_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_delete_AlertApi_profilebase_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_job_skill_controller.dart';
import '../../api/api.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';

import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_work_authorization_controller.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../controllers/add_w_authorizatin_controller.dart';
import '../../model/Multi Select Dropdown Model/add_w_authorization_model.dart';
import '../../model/get_skill_model.dart';
import '../../profile_model/job_seeker_work_authorizaltion_model.dart';
import '../../utils/app_color.dart';
import '../../widgets/buttonSubmit_widget.dart';

class AddWorkAuthorization extends StatefulWidget {
  const AddWorkAuthorization({Key? key}) : super(key: key);

  @override
  State<AddWorkAuthorization> createState() => _AddWorkAuthorizationState();
}

class _AddWorkAuthorizationState extends State<AddWorkAuthorization> {
  List<GetWorkAuthorizationModel> workAuthorizationListData = [];

  @override
  void initState() {
    getAuthrizedList();
    super.initState();
  }

  Future<List<dynamic>> getAuthrizedList() async {
    List<dynamic> matches = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse("https://api.publish.jobs/api/countries"),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    var data = json.decode(res.body.toString());
    print(data);
    for (Map<String, dynamic> i in data) {
      setState(() {
        workAuthorizationListData.add(GetWorkAuthorizationModel.fromJson(i));
      });
    }
    setState(() {
      matches = resBody;
    });
    return matches;
  }

  String idData='';
   String title='';
  GetWorkAuthorizationModel skillModel = GetWorkAuthorizationModel();
  List<GetWorkAuthorizationModel?> _selectedWorkAuthorizationTipe = [];
  List<GetWorkAuthorizationModel?> _selectedAnimalsdata = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  List<dynamic> selectedworkAuthId = [];


  @override
  Widget build(BuildContext context) {
    final _items = workAuthorizationListData
        .map((Skill) => MultiSelectItem<GetWorkAuthorizationModel?>(
            Skill, Skill.title.toString()))
        .toList();
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    List subjectData = [];
    List dataTest = [];

    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AddAppBar(
        appBarText: "Work Authorization",
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 10, top: 10, left: 9, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add those Countries in which you are Authorization to work",
                        style: TextStyle(
                            color: isDarkMode == false
                                ? AppColors.colorhalfgray
                                : ColorApp.colorwhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: s.width * 0.010, right: s.width * 0.020, top: 10),
              child: Material(
                color: isDarkMode == true
                    ? Color(0xff787777).withOpacity(0.2)
                    : ColorApp.colorwhite,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isDarkMode == true
                          ? Color(0xff343434)
                          : Colors.black54.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: s.width * 0.03,
                      right: s.width * 0.03,
                      top: s.width * 0.07,
                      bottom: s.width * 0.08),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: 5, left: 5, bottom: 10),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: isDarkMode == false
                                  ? ColorApp.colorblackgalf
                                  : ColorApp.colorwhite,
                              size: 21,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: 5, left: 5, bottom: 10),
                            child: Text(
                              "Country",
                              style: TextStyle(
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf
                                    : ColorApp.colorwhite,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "*",
                              style: TextStyle(
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf
                                    : ColorApp.colorwhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _items.isEmpty?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                        child: Container(
                          width: s.width,
                          color: isDarkMode == false
                              ? Colors.white
                              : const Color(0xff38373c),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.white30,
                            child: Container(
                              child: Column(
                                children: [

                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Container(
                                              width: s.width * 0.4,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets
                                                  .symmetric(
                                                  vertical: 2.0),
                                            ),

                                            Container(
                                              width: s.width * 0.4,
                                              height: 15.0,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ): MultiSelectBottomSheetField<GetWorkAuthorizationModel?>(
                        confirmText: Text(
                          "Ok",
                          style: TextStyle(
                              color: ColorApp.colorprimary, fontSize: 19),
                        ),
                        cancelText: Text(
                          "Cancel",
                          style: TextStyle(   fontSize: 19,

                              color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf),
                        ),
                        searchIcon: Icon(
                          Icons.search,
                          color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf,
                        ),
                        backgroundColor: isDarkMode == false
                            ? ColorApp.colorwhite
                            : Color(0xff787777),
                        buttonIcon: Icon(
                          Icons.arrow_downward_outlined,
                          color: isDarkMode == true
                              ? AppColors.colorwhite.withOpacity(0.69)
                              : Colors.grey,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isDarkMode == true
                                  ? Colors.white.withOpacity(0.3)
                                  : Colors.black54.withOpacity(0.3)),
                          color: isDarkMode == true
                              ? Color(0xff343434)
                              : Colors.white,
                        ),
                        key: _multiSelectKey,
                        initialChildSize: 0.7,
                        maxChildSize: 0.95,
                        title: Padding(
                          padding: EdgeInsets.only(
                            left: s.width * 0.06,
                          ),
                          child: Text(
                            "Search country",
                            style: TextStyle(
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf
                                    : ColorApp.colorbackground
                                        .withOpacity(0.7)),
                          ),
                        ),
                        buttonText: Text(
                          "Please Select a Country",
                          style: TextStyle(
                              color: isDarkMode == true
                                  ? AppColors.colorwhite.withOpacity(0.69)
                                  : Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        items: _items,
                        searchable: true,
                        validator: (values) {
                          if (values == null || values.isEmpty) {
                            return "Required";
                          }
                          List names = values.map((e) => e!.title).toList();
                          if (names.contains("Frog")) {
                            return "Frogs are weird!";
                          }
                          return null;
                        },
                        onConfirm: (values) {
                          setState(() {
                            Map<String, dynamic> mapDataTest = {
                              // 'id': values['id'].toString(),
                              // 'title': values['title'].toString()
                            };
                            // subjectData.add(suggestion['id']);
                            dataTest.add(mapDataTest);
                            print(dataTest.toString() + "data test 123");
                            _selectedWorkAuthorizationTipe =
                                values as List<GetWorkAuthorizationModel?>;
                            print(_selectedWorkAuthorizationTipe.toString() +
                                'selecteddddddddddddddddddddddd');
                          });
                          _multiSelectKey.currentState!.validate();
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (item) {
                            // _selectedAnimalsdata=item?.id.toString() as List<GetWorkAuthorizationModel?>;
                            setState(() {
                              _selectedWorkAuthorizationTipe.remove(item);
                            });
                            _multiSelectKey.currentState!.validate();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: s.height * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 10),
                    child: SubmitButton(
                        border: Border.all(
                            color: isDarkMode == false
                                ? AppColors.colorblack.withOpacity(0.3)
                                : Colors.white.withOpacity(0.2)),
                        textColor: isDarkMode == true
                            ? AppColors.colorwhite
                            : AppColors.colorblack,
                        backGroundColor: isDarkMode == true
                            ? Color(0xff343434)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        heightButton: s.height * 0.05,
                        widthButton: s.width * 0.30,
                        textButton: "Cancel",
                        onPressed: () {
                       Navigator.pop(context);
                        }),
                  ),
                  Consumer<PostWorkAuthorizationController>(
                    builder: (context, val, child) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8, top: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorApp.colorprimary,
                              borderRadius: BorderRadius.circular(6)),
                          height: s.height * 0.054,
                          width: s.width * 0.30,
                          child: GestureDetector(
                              onTap: () {
                                for(int i = 0;i < _selectedWorkAuthorizationTipe.length; i++){
                                  print(_selectedWorkAuthorizationTipe[i]!.id.toString()+"show all list");
                                  setState(() {
                                    selectedworkAuthId.add(_selectedWorkAuthorizationTipe[i]!.id??0);
                                  });
                                }
                                var data = {'workAuthorization': selectedworkAuthId};
                                val.addJobSeekerAuth(
                                    data, context);
                                Timer(Duration(seconds: 2), () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Provider.of<GetWorkAuthorizationController>(
                                            context,
                                            listen: false)
                                        .workAuthListData
                                        .clear();
                                    Provider.of<GetWorkAuthorizationController>(
                                            context,
                                            listen: false)
                                        .getJobSeekerWorkAuthorization();
                                  });
                                  Navigator.pop(context);
                                });
                                // showAlertDialog(context);
                              },
                              // },
                              child: Center(
                                child: val.loadingAddSkill == false
                                    ? Text(
                                        "Save Changes",
                                        style: TextStyle(
                                            color: isDarkMode == false
                                                ? AppColors.colorwhite
                                                : Colors.white),
                                      )
                                    : CircularProgressIndicator(),
                              )),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
