import 'dart:async';
import 'dart:convert';

import 'package:firstapp/views_screen/profile_screen/profile_add_marital_status_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_gender_level_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_genderController.dart';
import '../../api/api.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/job_seeker_career_level_model.dart';
import '../../model/job_seeker_gender_model.dart';
import '../../utils/app_color.dart';
import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../App Services/api_services_provider.dart';

class AddGender extends StatefulWidget {
  AddGender({Key? key}) : super(key: key);

  @override
  State<AddGender> createState() => _AddGenderState();
}

class _AddGenderState extends State<AddGender> {
  final String urlGenderLevel = "https://api.publish.jobs/api/get-gender";

  // final String urlCity = "https://api.publish.jobs/api/country-cities?country=$countryId";
  List GenderListData = [];

  Future<String> getCountryList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse(urlGenderLevel),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      GenderListData = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  String? genderId;
  List genderLevelList = ['Entry Level'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCountryList();
    //this.postCityList();
  }

  bool isAppbar = true;
  String? genderLevelSelection;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ABD abd = ABD();
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AddAppBar(
        appBarText: "Gender",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 6, bottom: 8, top: 8),
                        child: Text(
                          "Identity yourself who you are",
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
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: isDarkMode == true
                    ? Color(0xff787777).withOpacity(0.2)
                    : ColorApp.colorwhite,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isDarkMode == true
                          ? Colors.white.withOpacity(0.3)
                          : Colors.black54.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: s.height * 0.04),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                  const EdgeInsets.only(bottom: 10, left: 4, top: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(right: 5, left: 5, bottom: 10),
                              child: Icon(
                                Icons.person_outline,
                                color: isDarkMode == true
                                    ? AppColors.colorwhite.withOpacity(0.69)
                                    : Colors.grey,
                                size: 26,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: 5, left: 5, bottom: 10),
                              child: Text(
                                "Gender",
                                style: TextStyle(
                                    color: isDarkMode == true
                                        ? AppColors.colorwhite.withOpacity(0.69)
                                        : Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "*",
                                style: TextStyle(
                                    color: isDarkMode == true
                                        ? AppColors.colorwhite.withOpacity(0.69)
                                        : Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 8),
                        child: FutureBuilder<List<JobSeekerGenderModel>>(
                            future: GetGenderLevelController().getGenderlevel(),
                            builder: (context, snapshot) {
                              var arrayLengh = snapshot.data?.length ?? 0;
                              for (var i = 0; i < arrayLengh; i++) {
                                genderLevelList.add(snapshot.data![i].title);
                              }
                              if (!snapshot.hasData) {
                                return
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
                                );
                              } else {
                                return Column(
                                  children: [
                                    Material(
                                      color: isDarkMode == true
                                          ? Color(0xff343434)
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: BorderSide(
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                      .withOpacity(0.3)
                                                  : Colors.black54
                                                      .withOpacity(0.3))),
                                      child: DropdownButton(
                                          icon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.arrow_downward_outlined,
                                              size: 20,
                                              color: isDarkMode == true
                                                  ? AppColors.colorwhite
                                                  .withOpacity(0.69)
                                                  : Colors.grey,
                                            ),
                                          ),
                                          dropdownColor: isDarkMode == false
                                              ? Colors.grey
                                              : Colors.grey,
                                          elevation: 1,
                                          isExpanded: true,
                                          underline: Container(
                                            color: AppColors.colorblue,
                                          ),
                                          hint: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Please select gender",
                                              style: TextStyle(
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite
                                                      .withOpacity(0.69)
                                                      : Colors.grey),
                                            ),
                                          ),
                                          value: genderLevelSelection,
                                          onChanged: (v) {
                                            int? countryIndex;
                                            int index =
                                                GenderListData.indexWhere(
                                                    (item) =>
                                                        item["title"] == v);
                                            setState(() {
                                              genderLevelSelection =
                                                  v as String;
                                              countryIndex =
                                                  GenderListData.indexOf(v);
                                              //countryId = (index!+1).toString();
                                              for (var i = 0;
                                                  i < arrayLengh;
                                                  i++) {
                                                if (snapshot.data![i].title ==
                                                    v) {
                                                  genderId = snapshot
                                                      .data![i].id
                                                      .toString();
                                                  print(genderId.toString() +
                                                      'Career Level ID');
                                                }
                                              }
                                            });
                                          },
                                          items: GenderListData.map((v) {
                                            return DropdownMenuItem(
                                              value: v['title'],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  v['title'],
                                                  style: TextStyle(
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : Colors.black
                                                          .withOpacity(
                                                          0.71)),
                                                ),
                                              ),
                                            );
                                          }).toList()),
                                    ),
                                  ],
                                );
                              }
                            }),
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
                    padding: EdgeInsets.only(left: 12, right: 0),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child:Consumer<PostGenderController>(
                      builder: (context, val, child) {
                        return Padding(
                          padding: EdgeInsets.only(top: 7, left: s.width * 0.04),
                          child: Center(
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: ColorApp.colorprimary,
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  splashColor:
                                  AppColors.colorindigo.withOpacity(0.8),
                                  onTap: () {
                                    val.jobSeekerAddGenderStatus(
                                        genderId.toString(), context);
                                  },
                                  child: Container(
                                      height: s.height * 0.05,
                                      width: s.width * 0.39,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3)),
                                      child: Center(
                                        child: val.loadingMartialStatus == false
                                            ? Text(
                                          "Save Changes",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isDarkMode == false
                                                  ? AppColors.colorwhite
                                                  : Colors.white),
                                        )
                                            : SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      ))),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: s.width * 0.16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.only(left: 8, top: 8),
            //         child: SubmitButton(
            //           textColor:
            //               isDarkMode == true ? Colors.white : Colors.grey,
            //           borderRadius: BorderRadius.circular(5),
            //           heightButton: s.height * 0.052,
            //           widthButton: s.width * 0.3,
            //           backGroundColor:
            //               isDarkMode == true ? Colors.grey : Colors.white,
            //           border: Border.all(color: Colors.black54),
            //           textButton: 'Cancel',
            //           onPressed: () {
            //             Get.back();
            //           },
            //         ),
            //       ),
            //       Consumer<PostGenderController>(
            //         builder: (context, val, child) {
            //           return Padding(
            //             padding: EdgeInsets.only(top: 7, left: s.width * 0.04),
            //             child: Center(
            //               child: Material(
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(5)),
            //                 color: ColorApp.colorprimary,
            //                 child: InkWell(
            //                     borderRadius: BorderRadius.circular(5),
            //                     splashColor:
            //                         AppColors.colorindigo.withOpacity(0.8),
            //                     onTap: () {
            //                       val.jobSeekerAddGenderStatus(
            //                           genderId.toString(), context);
            //                     },
            //                     child: Container(
            //                         height: s.height * 0.05,
            //                         width: s.width * 0.39,
            //                         decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(3)),
            //                         child: Center(
            //                           child: val.loadingMartialStatus == false
            //                               ? Text(
            //                                   "Save Changes",
            //                                   style: TextStyle(
            //                                       fontSize: 16,
            //                                       color: isDarkMode == false
            //                                           ? AppColors.colorwhite
            //                                           : Colors.white),
            //                                 )
            //                               : SizedBox(
            //                                   height: 25,
            //                                   width: 25,
            //                                   child: CircularProgressIndicator(
            //                                     strokeWidth: 3,
            //                                   ),
            //                                 ),
            //                         ))),
            //               ),
            //             ),
            //           );
            //         },
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
