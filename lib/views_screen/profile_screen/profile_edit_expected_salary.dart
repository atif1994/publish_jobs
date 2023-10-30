import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_certificationList_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_salary_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_salary_type_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_delete_AlertApi_profilebase_controller.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/expacted_salary_model.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post__jobseekerAddExpectedSalary.dart';
import '../../utils/app_color.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';
import 'package:http/http.dart' as http;

import '../../widgets/update_appbar_widget.dart';
class EditExpectedSalary extends StatefulWidget {
  String? id;
  String? currency;
  String? paymentFreguency;
  String? pay;
  String? salarytypesId;

  EditExpectedSalary({Key? key, this.currency, this.paymentFreguency, this.pay,this.id,this.salarytypesId})
      : super(key: key);

  @override
  State<EditExpectedSalary> createState() => _EditExpectedSalaryState();
}

class _EditExpectedSalaryState extends State<EditExpectedSalary> {
  String currencyCode='';
  String currencyid='';
  getProfilePersonalInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http.get(
          Uri.parse('https://api.publish.jobs/api/user-general-get'),
          headers: requestHeaders);
      // .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        print(data);
        if (data['user_info'].toString() != 'null') {
          print((data['user_info']['first_name'] ?? 'null name'));
          print((data['user_info']['last_name'] ?? 'null last name'));
        }
        setState(() {
          currencyCode = (data['country_option'][0]['currency'][0]['currency_code']);
          currencyid = (data['country_option'][0]['currency'][0]['id']).toString();






        });
      } else {
        print('failed persnal info error status code: ' +
            response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString() + ' personalInfo exception');
    }
  }
  final String urlCareerLevel = "https://api.publish.jobs/api/get-salarytype";

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
    print(requestHeaders.toString()+ " "+"show header");
    var resBody = json.decode(res.body);
    setState(() {
      CareerLevelListData = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  String? salaryId;
  List careerLevelList = ['Entry Level'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCountryList();
    getProfilePersonalInfo();
    //this.postCityList();
  }

  String? currencyshow;
  String? newSalary;
  String? newSalaryValue='';
  String? degreeId;

  bool isAppbar = true;
  String? careerLevelSelection;
  TextEditingController desiredPayController = TextEditingController();

  GetSalaryTypeController salleryConroller = GetSalaryTypeController();

  @override
  Widget build(BuildContext context) {
    newSalary=    widget.paymentFreguency.toString();
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar:  UpdateAppBar(appBarText: "Edit Salary",image: ImangeAssests.dltImage,onPressed: (){
         SkillDeleteAlert(
            context,
             widget.id.toString(),
            "delete from Profile",
             "this wil delete from all section of you",
             "profile",
             "profileGalleryDelete",'');
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: s.height * 0.03, top: 6, left: 8, right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Your expected salary here",
                          style: TextStyle(
                              color: isDarkMode == true
                                  ? AppColors.colorwhite.withOpacity(0.69)
                                  : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  FutureBuilder<List<jobseekerSalaryTypeModel>>(
                      future: salleryConroller.getSalaryType(),
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
                          return Material(
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
                                  left: 8, right: 8, top: 8, bottom: s.height * 0.04),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 5, left: 6, bottom: 10),
                                        child: Icon(
                                          Icons.access_time,
                                          color: isDarkMode == true
                                              ? AppColors.colorwhite
                                              .withOpacity(0.69)
                                              : Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 5, left: 5, bottom: 10),
                                        child: Text(
                                          "Payment Frequency",
                                          style: TextStyle(
                                              color: isDarkMode == true
                                                  ? AppColors.colorwhite
                                                  .withOpacity(0.69)
                                                  : Colors.grey,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Material(
                                    elevation: 1,
                                    color: isDarkMode == true
                                        ? Color(0xff343434)
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: isDarkMode == true
                                              ? Colors.white.withOpacity(0.3)
                                              : Colors.black54
                                              .withOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: DropdownButton(
                                        icon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_downward_outlined,
                                            color: isDarkMode == true
                                                ? AppColors.colorwhite
                                                .withOpacity(0.69)
                                                : Colors.grey,
                                            size: 18,
                                          ),
                                        ),
                                        dropdownColor: isDarkMode == false
                                            ? ColorApp.colorwhite
                                            : ColorApp.colorblackgalf,
                                        elevation: 1,
                                        isExpanded: true,
                                        underline: Container(
                                          color: AppColors.colorblue,
                                        ),
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.pay.toString(),
                                            style: TextStyle(
                                                color: isDarkMode == true
                                                    ? AppColors.colorwhite
                                                    .withOpacity(0.69)
                                                    : Colors.grey),
                                          ),
                                        ),
                                        value: careerLevelSelection,
                                        onChanged: (v) {
                                          print(CareerLevelListData.toString() +
                                              "show value");
                                          int? countryIndex;
                                          int index =
                                          CareerLevelListData.indexWhere(
                                                  (item) => item["title"] == v);
                                          setState(() {
                                            careerLevelSelection = v as String;
                                            countryIndex =
                                                CareerLevelListData.indexOf(v);
                                            //countryId = (index!+1).toString();
                                            for (var i = 0;
                                            i < arrayLengh;
                                            i++) {
                                              if (snapshot.data![i].title ==
                                                  v) {
                                                degreeId = snapshot
                                                    .data![i].id
                                                    .toString();
                                                print(degreeId.toString() +
                                                    'Career Level ID');
                                              }
                                            }
                                          });
                                        },
                                        items: CareerLevelListData.map((v) {
                                          return DropdownMenuItem(


                                            value: v['title'],
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: s.width*0.04,top: 5,bottom: 4),
                                              child: Text(
                                                v['title'],
                                                style: TextStyle(
                                                    color: isDarkMode == true
                                                        ? AppColors.colorwhite
                                                        .withOpacity(0.69)
                                                        : Colors.black87.withOpacity(0.68)),
                                              ),
                                            ),
                                          );
                                        }).toList()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 14,
                                      bottom: 7,
                                      left: 6,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          size: 20,
                                          color: isDarkMode == true
                                              ? AppColors.colorwhite
                                              .withOpacity(0.69)
                                              : Colors.grey,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Desired pay",
                                            style: TextStyle(
                                                color: isDarkMode == true
                                                    ? AppColors.colorwhite
                                                    .withOpacity(0.69)
                                                    : Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Material(
                                      elevation: 1,
                                      color: isDarkMode == true
                                          ? Color(0xff343434)
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: isDarkMode == true
                                                ? Colors.white.withOpacity(0.3)
                                                : Colors.black54
                                                .withOpacity(0.3)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextFormField(


                                        onChanged: (value) {
                                          setState(() {
                                            newSalaryValue = value;
                                          });
                                        },

                                        initialValue:
                                        newSalary,

                                        validator: (formattedDate) {
                                          if (formattedDate!.isEmpty ||
                                              formattedDate == null) {
                                            return 'Please enter the start data';
                                          }
                                        },
                                          keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            color: isDarkMode == true
                                                ? AppColors.colorwhite
                                                .withOpacity(0.69)
                                                : Colors.black87.withOpacity(0.7),
                                            fontSize: 16),



                                        decoration: InputDecoration(


                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  left: s.width * 0.05,
                                                  top: s.height * 0.025),
                                              child: Text(
                                                currencyCode,
                                                style: TextStyle(
                                                    color: isDarkMode == true
                                                        ? AppColors.colorwhite
                                                        .withOpacity(0.69)
                                                        : Colors.black87.withOpacity(0.7)),
                                              ),
                                            ),
                                            prefixStyle: TextStyle(
                                                color: isDarkMode == true
                                                    ? AppColors.colorwhite
                                                    .withOpacity(0.69)
                                                    : Colors.grey),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 10, right: 10, top: 16)),

                                        //set it true, so that user will not able to edit text
                                      )),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: s.height * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4, right: 0),
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
                      child: Consumer<PostAddExpectedSalaryController>(
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

                                      print(currencyid.toString()+"add currency id");
                                      print(salaryId.toString()+"payment id");
                                      print(widget.id.toString()+"back  id");
                                      print(widget.paymentFreguency.toString()+"payment frequency");

                                       val.jobAddSalary(widget.id.toString(),currencyid.toString(),degreeId ??
                                           widget.salarytypesId.toString(),newSalaryValue.toString() == ''
                                           ? newSalary.toString()
                                           : newSalaryValue.toString(), context)

                                      ;
                                      Timer(Duration(seconds: 2), () {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          Provider.of<GetSalaryController>(
                                              context,
                                              listen: false)
                                              .jobGetSalary();

                                          Provider.of<GetSalaryController>(
                                              context,
                                              listen: false)
                                              .jobGetSalary();
                                        });
                                        Navigator.pop(context);
                                      });


                                      // Timer(Duration(seconds: 2), () {
                                      //   WidgetsBinding.instance
                                      //       .addPostFrameCallback((_) {
                                      //     Provider.of<GetJobSeekerCareerLevelController>(
                                      //         context,
                                      //         listen: false)
                                      //         .careerLevelListData
                                      //         .clear();
                                      //     Provider.of<GetJobSeekerCareerLevelController>(
                                      //         context,
                                      //         listen: false)
                                      //         .getJobSeekerCareerLevel();
                                      //   });
                                      //   Get.back();
                                      // });
                                    },
                                    child: Container(
                                        height: s.height * 0.05,
                                        width: s.width * 0.39,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(3)),
                                        child: Center(
                                          child: val.addSalaryLoading==
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
      ),
    );
  }
  SkillDeleteAlert(BuildContext context, id, deleteText, subtitle, subtitle2,
      uniqueId, title) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor:
      isDarkMode == true ? ColorApp.colorbgbtn : ColorApp.colorbgbtn,
      insetPadding: EdgeInsets.only(
        bottom: Get.height * 0.42,
        top: Get.height * 0.3,
        left: Get.width * 0.04,
        right: Get.width * 0.04,
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      actions: [
        Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: isDarkMode == true
                        ? ColorApp.colornewblack
                        : Colors.grey),
                width: MediaQuery.of(context).size.width,
                height: Get.height * 0.06,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.02, top: 12),
                  child: Text(
                    deleteText,
                    style: TextStyle(
                      color: isDarkMode == true
                          ? ColorApp.colorbackground
                          : ColorApp.colorbackground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  text: "this will delete" + " ",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "Montserrat",
                                                      fontSize: 15,
                                                      color: isDarkMode == true
                                                          ? ColorApp.colornewblack
                                                          : ColorApp.colornewblack),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: " " +
                                                          'from all section of Your Profile',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "Montserrat",
                                                          fontSize: 15,
                                                          color: isDarkMode == true
                                                              ? ColorApp.colornewblack
                                                              : ColorApp.colornewblack),
                                                    ),
                                                  ])),
                                        ],
                                      )),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.3,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorApp.colornewblack),
                      borderRadius: BorderRadius.circular(6),
                      color: ColorApp.colorbgbtn,
                    ),
                    child: Center(
                      child: Text(
                        'No, Thanks',
                        style: TextStyle(
                            fontSize: 15, color: ColorApp.colornewblack),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Consumer<PostDeleteAlertProfileBase>(
                  builder: (context, val, child) {
                    return ElevatedButton(
                      onPressed: () {
                        print(id.toString()+"show id of slaary delete");
                        val.jobSalaryDelete(id.toString(), context);

                        Provider.of<GetSalaryController>(context,listen: false) .jobGetSalary();
                        Timer(Duration(seconds: 2), () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Provider.of<GetSalaryController>(context,listen: false) .jobGetSalary();
                          });
                          Navigator.pop(context);


                        });

                      },
                      style: ButtonStyle(
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                        shadowColor: MaterialStateProperty.all(Colors.red),
                        backgroundColor:
                        MaterialStateProperty.all(ColorApp.colorprimary),
                      ),
                      child: val.loadingSalaryDelete == false
                          ? Text(
                        "Delete",
                        style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode == false
                                ? AppColors.colorwhite
                                : Colors.white),
                      )
                          : SizedBox(
                        child: CircularProgressIndicator(),
                        height: 25.0,
                        width: 25.0,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
