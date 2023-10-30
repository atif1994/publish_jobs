import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_country_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_preferred_job_location_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_add_prefered_location_controller.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/country_list_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';

class AddPreferJobLocation extends StatefulWidget {
  const AddPreferJobLocation({Key? key}) : super(key: key);

  @override
  State<AddPreferJobLocation> createState() => _AddPreferJobLocationState();
}

class _AddPreferJobLocationState extends State<AddPreferJobLocation> {
  @override
  TextEditingController firstnameC = TextEditingController();
  TextEditingController lastnameC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController phnumberC = TextEditingController();
  final String urlCountry = "https://api.publish.jobs/api/countries";

  // final String urlCity = "https://api.publish.jobs/api/country-cities?country=$countryId";
  bool isAppbar = true;
  String? countrySelection;
  String? citySelection;
  String? countryId;
  String? cityId;
  List countryList = ['lahore'];

  // List cityList = ["islamabad", "lahore", "karachi"];
  List countryListData = [];

  Future<String> getCountryList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse(urlCountry),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      countryListData = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  List cityListData = [];

  Future<String> postCityList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await post(
        Uri.parse(
            "https://api.publish.jobs/api/country-cities?country=$countryId"),
        body: {
          'country': countryId,
        },
        headers: requestHeaders);
    var resBody = json.decode(res.body);
    setState(() {
      cityListData = resBody;
      print(cityListData.toString() + 'dflkjglkdfjglkdfgjkddddddddddd');
    });
    print(resBody);
    return "Sucess";
  }
bool cityShow=false;
  @override
  void initState() {
    print(countryId.toString()+"lllllllllllllllll");
    // TODO: implement initState
    super.initState();
    this.getCountryList();
    this.postCityList();
  }

  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AddAppBar(
        appBarText: "Preferred job Location",
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: 4, top: 12, left: s.width * 0.04, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tell your desire job location where you went to work ",
                          style: TextStyle(
                              color: isDarkMode == true
                                  ? AppColors.colorwhite.withOpacity(0.69)
                                  : Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<CountriesListModel>>(
                  future: GetCountryListController().getCountriesList(),
                  builder: (context, snapshot) {
                    var arrayLengh = snapshot.data?.length ?? 0;
                    for (var i = 0; i < arrayLengh - 1; i++) {
                      countryList.add(snapshot.data![i].title);
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Padding(
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
                      ));
                    } else {
                      return Padding(
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
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4, bottom: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 5, left: 6),
                                              child: Icon(
                                                Icons.location_on_outlined,
                                                size: 18,
                                                color: isDarkMode == true
                                                    ? AppColors.colorwhite.withOpacity(0.69)
                                                    : Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              AppString.country,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite.withOpacity(0.69)
                                                      : Colors.grey),
                                            ),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),

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
                                              padding: const EdgeInsets.only(
                                                  right: 10),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                AppString.selectCountry,
                                                style: TextStyle(
                                                    color: isDarkMode == true
                                                        ? AppColors.colorwhite
                                                        .withOpacity(0.69)
                                                        : Colors.grey),
                                              ),
                                            ),
                                            value: countrySelection,
                                            onChanged: (v) {
                                              int? countryIndex;
                                              int index = countryListData
                                                  .indexWhere((item) =>
                                                      item["title"] == v);
                                              setState(() {
                                                citySelection = null;
                                             cityShow=true;
                                                countrySelection = v as String;
                                                countryIndex =
                                                    countryListData.indexOf(v);
                                                //countryId = (index!+1).toString();
                                                for (var i = 0;
                                                    i < arrayLengh - 1;
                                                    i++) {
                                                  if (snapshot.data![i].title ==
                                                      v) {
                                                    countryId = snapshot
                                                        .data![i].id
                                                        .toString();
                                                    print(countryId.toString() +
                                                        'country idddddd');
                                                  }
                                                }
                                                postCityList();
                                              });
                                            },
                                            items: countryListData.map((v) {
                                              return DropdownMenuItem(
                                                value: v['title'],
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                  ),
                                ),
                                Visibility(
                                  visible: cityShow,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4, bottom: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 5, left: 6),
                                                child: Icon(
                                                  Icons.location_on_outlined,
                                                  size: 18,
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite.withOpacity(0.69)
                                                      : Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                AppString.city,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite.withOpacity(0.69)
                                                      : Colors.grey,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
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
                                                padding: const EdgeInsets.only(
                                                    right: 10),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  AppString.selectCity,
                                                  style: TextStyle(
                                                      color:isDarkMode == true
                                                          ? AppColors.colorwhite
                                                          .withOpacity(0.69)
                                                          : Colors.grey),
                                                ),
                                              ),
                                              value: citySelection,
                                              onChanged: (v) {
                                                setState(() {
                                                  for (var i = 0;
                                                      i <=
                                                          cityListData.length - 1;
                                                      i++) {
                                                    if (cityListData[i]
                                                            ['title'] ==
                                                        v) {
                                                      cityId = cityListData[i]
                                                              ['id']
                                                          .toString();
                                                      print(cityId.toString() +
                                                          ' city id');
                                                    }
                                                  }
                                                  citySelection = v as String;
                                                  this.citySelection = v;
                                                });
                                              },
                                              items: cityListData.map((v) {
                                                return DropdownMenuItem(
                                                  value: v['title'],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
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
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
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
            //
            //       // Padding(
            //       //   padding: const EdgeInsets.only(left: 5),
            //       //   child: Container(
            //       //     height: s.height * 0.050,
            //       //     width: s.width * 0.35,
            //       //     decoration: BoxDecoration(
            //       //       borderRadius: BorderRadius.circular(22),
            //       //     ),
            //       //     child: ElevatedButton(
            //       //       onPressed: () {
            //       //
            //       //       },
            //       //       style: ButtonStyle(
            //       //         // shadowColor: MaterialStateProperty.all(Colors.red),
            //       //         backgroundColor: MaterialStateProperty.all(
            //       //             Colors.deepPurpleAccent),
            //       //       ),
            //       //       child:val.isLoadingLocation==true?CircularProgressIndicator() Text(
            //       //         "Save changes",
            //       //         style: TextStyle(
            //       //             color: isDarkMode == false
            //       //                 ? AppColors.colorwhite
            //       //                 : Colors.white),
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
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
                    padding:  EdgeInsets.only(right: s.width*0.03),
                    child: Consumer<PostPreferJobLocationController>(
                      builder: (context, val, child) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Center(
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              color: ColorApp.colorprimary.withOpacity(0.8),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  splashColor:
                                  AppColors.colorindigo.withOpacity(0.8),
                                  onTap: () {
                                    val
                                        .jobSeekerAddPreferedLocation(
                                        countryId.toString(),
                                        cityId.toString(),
                                        context);
                                    Timer(Duration(seconds: 0), () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Provider.of<GetPreferredJobSeekerLocation>(
                                            context,
                                            listen: false)
                                            .preferredJobLocationListData
                                            .clear();
                                        Provider.of<GetPreferredJobSeekerLocation>(
                                            context,
                                            listen: false)
                                            .getJobSeekerPreferredJobLocation();
                                      });
                                   Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                      height: s.height * 0.05,
                                      width: s.width * 0.36,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3)),
                                      child: Center(
                                        child: val.loadingPreferLocation == false
                                            ? Text(
                                          "Save Changes",
                                          style: TextStyle(
                                              color: isDarkMode == false
                                                  ? AppColors.colorwhite
                                                  : Colors.white),
                                        )
                                            : SizedBox(
                                          height: 25,
                                            width: 25,

                                            child: CircularProgressIndicator()),
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
