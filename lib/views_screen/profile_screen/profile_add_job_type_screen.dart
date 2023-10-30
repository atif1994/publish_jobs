import 'dart:async';
import 'dart:convert';

import 'package:firstapp/views_screen/profile_screen/profile_all_position_list_screen.dart';
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
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_preferred_job_type_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_add_preferjob_type_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_preferedjob_position_controller.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../controllers/add_preferred_job_position_controller.dart';
import '../../controllers/add_preferred_job_type_controller.dart';
import '../../controllers/add_w_authorizatin_controller.dart';
import '../../model/Multi Select Dropdown Model/add_w_authorization_model.dart';
import '../../model/Multi Select Dropdown Model/preferred_job_position_model.dart';
import '../../model/Multi Select Dropdown Model/preferred_job_type_model.dart';
import '../../profile_model/job_skr_jobtypeontion.dart';
import '../../utils/app_color.dart';
import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';

class AddPreferJobType extends StatefulWidget {
  const AddPreferJobType({Key? key}) : super(key: key);

  @override
  State<AddPreferJobType> createState() => _AddPreferJobTypeState();
}

class _AddPreferJobTypeState extends State<AddPreferJobType> {
  List<GetJobTypeOptionModel> preferJobTypeListData = [];

  @override
  void initState() {
    getpreferPositionList();
    super.initState();
  }

  Future<List<dynamic>> getpreferPositionList() async {
    List<dynamic> matches = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse("https://api.publish.jobs/api/get-jobTypeOption"),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    var data = json.decode(res.body.toString());
    print(data);
    for (Map<String, dynamic> i in data) {
      setState(() {
        preferJobTypeListData.add(GetJobTypeOptionModel.fromJson(i));
      });
    }
    setState(() {
      matches = resBody;
    });
    return matches;
  }

  String idData='';
  String title='';
  GetJobTypeOptionModel skillModel = GetJobTypeOptionModel();
  List<GetJobTypeOptionModel?> _selectedjobTipe = [];
  List<dynamic> selectedJobTypeId = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final _items = preferJobTypeListData
        .map((Skill) => MultiSelectItem<GetJobTypeOptionModel?>(
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
        appBarText: "Prefer job Type",
      ),
      body:  Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 10, left: 9, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tell you desire job type to the Employers",
                              style: TextStyle(
                                  color: isDarkMode == false
                                      ? AppColors.colorblack.withOpacity(0.8)
                                      : ColorApp.colorwhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                              "Prefered Jobs Type",
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
                      ):
                      MultiSelectBottomSheetField<GetJobTypeOptionModel?>(
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
                          color:isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf,
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
                            "Search Prefer Jobs Type",
                            style: TextStyle(
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf
                                    : ColorApp.colorbackground
                                    .withOpacity(0.7)),
                          ),
                        ),
                        buttonText: Text(
                          "Please select your Jobs type",
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
                            _selectedjobTipe =
                            values as List<GetJobTypeOptionModel?>;
                            print(_selectedjobTipe.toString() +
                                'selecteddddddddddddddddddddddd');
                          });
                          _multiSelectKey.currentState!.validate();
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (item) {
                           // _selectedAnimalsdata=item?.id.toString() as List<GetJobTypeOptionModel?>;
                            setState(() {
                              _selectedjobTipe.remove(item);
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
                  Consumer<PostPreferJobTypeController>(
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
                                for(int i = 0;i < _selectedjobTipe.length; i++){
                                 setState(() {
                                   selectedJobTypeId.add(_selectedjobTipe[i]!.id??0);
                                 });
                                }
                                 var data = {'jobType': selectedJobTypeId};
                                 val.addJobSeekerPreferresJobType(data);
                                Timer(Duration(seconds: 2), () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Provider.of<GetPreferredJobTypeController>(
                                        context,
                                        listen: false)
                                        .preferredJobTypeListData
                                        .clear();
                                    Provider.of<GetPreferredJobTypeController>(
                                        context,
                                        listen: false)
                                        .getJobSeekerPreferredJobType();
                                  });
                                 Navigator.pop(context);
                                });


                              },
                              // },
                              child: Center(
                                child: val.isLoading == false
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
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: s.width * 0.022, right: s.width * 0.058, top: 10),
            //   child: Material(
            //     color: isDarkMode == false
            //         ? Colors.white
            //         : const Color(0xff38373c),
            //     elevation: 1,
            //     shape: RoundedRectangleBorder(
            //         side: BorderSide(color: Colors.black54, width: 1),
            //         borderRadius: BorderRadius.circular(
            //           12,
            //         )),
            //     child: Padding(
            //       padding: EdgeInsets.only(
            //           left: s.width * 0.04,
            //           right: s.width * 0.05,
            //           top: s.width * 0.07,
            //           bottom: s.width * 0.07),
            //       child: Column(
            //         children: [
            //           Row(
            //             children: [
            //               Padding(
            //                 padding:
            //                     EdgeInsets.only(right: 5, left: 5, bottom: 10),
            //                 child: Icon(
            //                   Icons.location_on_outlined,
            //                   color: isDarkMode == false
            //                       ? ColorApp.colorblack.withOpacity(0.8)
            //                       : ColorApp.colorwhite,
            //                   size: 21,
            //                 ),
            //               ),
            //               Padding(
            //                 padding:
            //                     EdgeInsets.only(right: 5, left: 5, bottom: 10),
            //                 child: Text(
            //                   "Prefered Jobs Position",
            //                   style: TextStyle(
            //                     color: isDarkMode == false
            //                         ? ColorApp.colorblack.withOpacity(0.8)
            //                         : ColorApp.colorwhite,
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.only(bottom: 10),
            //                 child: Text(
            //                   "*",
            //                   style: TextStyle(
            //                     color: isDarkMode == false
            //                         ? ColorApp.colorblack.withOpacity(0.8)
            //                         : ColorApp.colorwhite,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           GetBuilder<PreferredJobPositionController>(
            //               builder: (controller) {
            //             return Column(
            //               children: [
            //                 Material(
            //                   elevation: 1,
            //                   color: Colors.white,
            //                   child: MultiSelectDialogField(
            //                     items: controller.dropDownData,
            //                     title: const Text(
            //                       "Select Subject",
            //                       style: TextStyle(color: Colors.black),
            //                     ),
            //                     selectedColor: Colors.black,
            //                     buttonIcon: const Icon(
            //                       Icons.arrow_downward_outlined,
            //                       color: Colors.grey,
            //                       size: 18,
            //                     ),
            //                     buttonText: Text(
            //                       "Please select your job Position",
            //                       style: TextStyle(
            //                         color: Colors.grey,
            //                         fontSize: 16,
            //                       ),
            //                     ),
            //                     onConfirm: (results) {
            //                       subjectData = [];
            //                       for (var i = 0; i < results.length; i++) {
            //                         AddPreferedPositionModel data =
            //                             results[i] as AddPreferedPositionModel;
            //                         Map<String, dynamic> mapDataTest = {
            //                           'id': data.id,
            //                           'title': data.title
            //                         };
            //
            //                         // print(data.id);
            //                         // print(data.title);
            //                         // print('ggggggggg');
            //                         subjectData.add(data.id);
            //                         dataTest.add(mapDataTest);
            //                         // print(dataTest);
            //                         // print('uuuuuuuuuuuu');
            //                       }
            //
            //                       final List<Map<String, dynamic>> mapList =
            //                           skillList
            //                               .map((s) => {
            //                                     'id': s,
            //                                     'uuid': false,
            //                                     'title': s,
            //                                     'status': false,
            //                                     'created_at': s,
            //                                     'updated_at': false,
            //                                   })
            //                               .toList();
            //                       //print("data $subjectData");
            //                       //controller.jobSeekerSkill();
            //                       //_selectedAnimals = results;
            //                     },
            //                   ),
            //                 ),
            //               ],
            //             );
            //           })
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding:
            //       EdgeInsets.only(top: s.height * 0.02, left: s.width * 0.17),
            //   child: Row(
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.only(
            //             right: s.width * 0.02, left: s.width * 0.048),
            //         child: SubmitButton(
            //             border: Border.all(color: Colors.black87),
            //             textColor: isDarkMode == true
            //                 ? AppColors.colorwhite
            //                 : AppColors.colorblack,
            //             backGroundColor:
            //                 isDarkMode == true ? Colors.grey : Colors.white,
            //             borderRadius: BorderRadius.circular(12),
            //             heightButton: s.height * 0.054,
            //             widthButton: s.width * 0.30,
            //             textButton: "Cancel",
            //             onPressed: () {
            //               Navigator.pop(context);
            //             }),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 5),
            //         child: Container(
            //           height: s.height * 0.050,
            //           width: s.width * 0.35,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(22),
            //           ),
            //           child: ElevatedButton(
            //             onPressed: () {
            //               PostPreferJobPositionController()
            //                   .addJobSeekerPreferresPosition(dataTest);
            //
            //             },
            //             style: ButtonStyle(
            //               // shadowColor: MaterialStateProperty.all(Colors.red),
            //               backgroundColor: MaterialStateProperty.all(
            //                   Colors.deepPurpleAccent),
            //             ),
            //             child: Text(
            //               "Save changes",
            //               style: TextStyle(
            //                   color: isDarkMode == false
            //                       ? AppColors.colorwhite
            //                       : Colors.white),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
