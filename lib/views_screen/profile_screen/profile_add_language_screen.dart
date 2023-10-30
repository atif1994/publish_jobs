import 'dart:async';
import 'dart:convert';

import 'package:firstapp/api/api.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_gender_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_wrk_auth_country_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_language_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_add_language_controller.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../controllers/add_language_controller.dart';
import '../../model/Multi Select Dropdown Model/add_language_model.dart';
import '../../model/Multi Select Dropdown Model/preferred_job_position_model.dart';
import '../../model/job_seeker_career_level_model.dart';
import '../../profile_model/Job_language_model.dart';
import '../../utils/app_color.dart';
import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';

class AddLanguage extends StatefulWidget {
  const AddLanguage({Key? key}) : super(key: key);

  @override
  State<AddLanguage> createState() => _AddLanguageState();
}

class _AddLanguageState extends State<AddLanguage> {
  List<GetLanguageModel> languageListData = [];

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
      Uri.parse("https://api.publish.jobs/api/get-languages"),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    var data = json.decode(res.body.toString());
    print(data);
    for (Map<String, dynamic> i in data) {
      setState(() {
        languageListData.add(GetLanguageModel.fromJson(i));
      });
    }
    setState(() {
      matches = resBody;
    });
    return matches;
  }

  String idData='';
  String title='';
  GetLanguageModel skillModel = GetLanguageModel();

  List<GetLanguageModel?> _selectedlanguageTipe = [];
  List<GetLanguageModel?> _selectedAnimalsdata = [];
  List<dynamic> selectedlanguageId = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final _items = languageListData
        .map((Skill) => MultiSelectItem<GetLanguageModel?>(
        Skill, Skill.title.toString()))
        .toList();
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    List subjectData = [];
    List dataTest = [];

    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AddAppBar(
        appBarText: "Language",
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 0, bottom: 3, top: 8),
                            child: Text(
                              "To be able to Add Your language skill to your resume",
                              style: TextStyle(
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite.withOpacity(0.69)
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6, bottom: 3),
                            child: Text(
                              "You must judge your abilities with full honesty",
                              style: TextStyle(
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite.withOpacity(0.69)
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 6,
                            ),
                            child: Text(
                              "regarding speaking,writing,and reading",
                              style: TextStyle(
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite.withOpacity(0.69)
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
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
                      left: 5, right: 4, top: 8, bottom: s.height * 0.026),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 6),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 5, left: 7, bottom: 7),
                              child: Icon(
                                Icons.access_time,
                                color: isDarkMode == true
                                    ? AppColors.colorwhite.withOpacity(0.69)
                                    : Colors.grey,
                                size: 20,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 5, left: 5, bottom: 10),
                              child: Text(
                                "Language",
                                style: TextStyle(
                                    color: isDarkMode == true
                                        ? AppColors.colorwhite.withOpacity(0.69)
                                        : Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
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
                      ): Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5),
                        child: MultiSelectBottomSheetField<GetLanguageModel?>(
                          confirmText: Text(
                            "Ok",
                            style: TextStyle(
                                color: ColorApp.colorprimary, fontSize: 19),
                          ),
                          cancelText: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 19,

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
                              "Search language",
                              style: TextStyle(
                                  color: isDarkMode == false
                                      ? ColorApp.colorblackgalf
                                      : ColorApp.colorbackground
                                      .withOpacity(0.7)),
                            ),
                          ),
                          buttonText: Text(
                            "Please Select Language",
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
                              _selectedlanguageTipe =
                              values as List<GetLanguageModel?>;
                              print(_selectedlanguageTipe.toString() +
                                  'selecteddddddddddddddddddddddd');
                            });
                            _multiSelectKey.currentState!.validate();
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            onTap: (item) {
                              _selectedAnimalsdata=item?.id.toString() as List<GetLanguageModel?>;
                              setState(() {
                                _selectedlanguageTipe.remove(item);
                              });
                              _multiSelectKey.currentState!.validate();
                            },
                          ),
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
                  Consumer<PostLanguageController>(
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
                                for (int i = 0;
                                i < _selectedlanguageTipe.length;
                                i++) {
                                  setState(() {
                                    selectedlanguageId.add(
                                        _selectedlanguageTipe[i]!.id ?? 0);
                                  });
                                }
                                var data = {
                                  'language': selectedlanguageId
                                };
                                val.addJobSeekerLanguage(
                                    data,);

                                Timer(Duration(seconds: 2), () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Provider.of<GetLanguageController>(
                                        context,
                                        listen: false)
                                        .languageListData
                                        .clear();
                                    Provider.of<GetLanguageController>(
                                        context,
                                        listen: false)
                                        .getJobSeekerLanguage();
                                  });
                                 Navigator.pop(context);
                                });
                              },
                              child: Center(
                                child: val.loadingLanguage == false
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
