import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_careel_level.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobSeekercareer_apply_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_add_career_level_controller.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/job_seeker_career_level_model.dart';
import '../../utils/app_color.dart';

import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../applay_screen/applay_career_level_screen.dart';

class AddCareerLevel extends StatefulWidget {
  final String? navigationDeciderId;

  const AddCareerLevel({Key? key, this.navigationDeciderId}) : super(key: key);

  @override
  State<AddCareerLevel> createState() => _AddCareerLevelState();
}

class _AddCareerLevelState extends State<AddCareerLevel> {
  final String urlCareerLevel = "https://api.publish.jobs/api/get-careerlevel";

  // final String urlCity = "https://api.publish.jobs/api/country-cities?country=$countryId";
  List CareerLevelListData = [];

  Future<String> getCountryList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse(urlCareerLevel),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      CareerLevelListData = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  String? careerLevelId;
  List careerLevelList = ['Entry Level'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCountryList();
    //this.postCityList();
  }

  bool isAppbar = true;
  String? careerLevelSelection;

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AddAppBar(
        appBarText: "Career Level",
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
                          "Add Your career level give the best your are",
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
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
                      left: s.width * 0.04,
                      right: s.width * 0.05,
                      top: s.width * 0.07,
                      bottom: s.width * 0.07),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: 8, left: 12, bottom: 10),
                            child: Icon(
                              Icons.timeline_outlined,
                              color: isDarkMode == true
                                  ? AppColors.colorwhite.withOpacity(0.7)
                                  : Colors.grey,
                              size: 20,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: 5, left: 0, bottom: 10),
                            child: Text(
                              "Career Level",
                              style: TextStyle(
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite.withOpacity(0.7)
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
                                      ? AppColors.colorwhite.withOpacity(0.7)
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder<List<JobCareerLavelModel>>(
                          future: GetCareerController().getCareerLevel(),
                          builder: (context, snapshot) {
                            var arrayLengh = snapshot.data?.length ?? 0;
                            for (var i = 0; i < arrayLengh; i++) {
                              careerLevelList.add(snapshot.data![i].title);
                            }
                            if (!snapshot.hasData) {
                              return Padding(
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
                                  Container(
                                    decoration: BoxDecoration(

                                        borderRadius:
                                        BorderRadius.circular(4),
                                        color: isDarkMode == true
                                            ? Color(0xff343434)
                                            : Colors.white,
                                        border: Border.all(
                                            color: isDarkMode == true
                                                ? Colors.white.withOpacity(0.3)
                                                : Colors.black54.withOpacity(0.3)
                                        )),
                                    height: s.height * 0.0579,
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
                                            "Please select careel level",
                                            style: TextStyle(
                                                color: isDarkMode == true
                                                    ? AppColors.colorwhite
                                                        .withOpacity(0.69)
                                                    : Colors.grey),
                                          ),
                                        ),
                                        value: careerLevelSelection,
                                        onChanged: (v) {
                                          int? countryIndex;
                                          int index =
                                              CareerLevelListData.indexWhere(
                                                  (item) =>
                                                      item["title"] == v);
                                          setState(() {
                                            careerLevelSelection =
                                                v as String;
                                            countryIndex =
                                                CareerLevelListData.indexOf(
                                                    v);
                                            //countryId = (index!+1).toString();
                                            for (var i = 0;
                                                i < arrayLengh;
                                                i++) {
                                              if (snapshot.data![i].title ==
                                                  v) {
                                                careerLevelId = snapshot
                                                    .data![i].id
                                                    .toString();
                                                print(
                                                    careerLevelId.toString() +
                                                        'Career Level ID');
                                              }
                                            }
                                          });
                                        },
                                        items: CareerLevelListData.map((v) {
                                          return DropdownMenuItem(
                                            value: v['title'],
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 9),
                                              child: Text(
                                                v['title'],
                                                style: TextStyle(
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : Colors.black
                                                            .withOpacity(
                                                                0.71),
                                                    fontSize: 14),
                                              ),
                                            ),
                                          );
                                        }).toList()),
                                  ),
                                ],
                              );
                            }
                          }),
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
                    child: Consumer<PostCareerLevelController>(
                      builder: (context, val, child) {
                        return Padding(
                          padding:
                              EdgeInsets.only(top: 7, left: s.width * 0.04),
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
                                    val.jobSeekerAddCareerLevel(
                                        careerLevelId.toString(), context);
                                    ;
                                    Timer(Duration(seconds: 2), () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Provider.of<GetJobSeekerCareerLevelController>(
                                                context,
                                                listen: false)
                                            .getJobSeekerCareerLevel();
                                        Provider.of<GetJobSeekerCareerLevelController>(context, listen: false)
                                            .getJobSeekerCareerLevel();

                                      });
                                     Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                      height: s.height * 0.05,
                                      width: s.width * 0.39,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Center(
                                        child: val.loadingAddCareerLevel ==
                                                false
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
                                                child:
                                                    CircularProgressIndicator(
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
          ],
        ),
      ),
    );
  }
}
