import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../App Services/api_services_provider.dart';
import '../../App Services/global_vars.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_qualification_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_education_controller.dart';
import '../../api/api.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../profile_model/job_seeker_education_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../utils/app_color.dart';

import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/update_appbar_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';
import '../applay_screen/applay_qualification_screen.dart';

class EditEducation extends StatefulWidget {
  final String? id;
  final String? subjectUpdateData;
  final String? institueUpdateData;
  final String? descriptionUpdateData;
  final String? startDate;
  final String? endDate;
  final String? degreeStatus;
  final String? degreeId;
  final String? degreeData;
  final String? navigationDeciderId;

  EditEducation({
    Key? key,
    this.id,
    this.institueUpdateData,
    this.subjectUpdateData,
    this.degreeStatus,
    this.degreeId,
    this.descriptionUpdateData,
    this.degreeData,
    this.navigationDeciderId,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  State<EditEducation> createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
  String? selectedValue = null;
  bool isDark = false;
  String? degreeEducation;
  String? degreeId;
  bool value = false;
  List educationList = [];
  bool isProgress = false;
  bool lastdata = false;

  @override
  void initState() {
    super.initState();
    educationListFuture = GetQualificationController().getEducationList();
    this.getDegreesList();
    isProgress = widget.endDate == 'null' ? true : false;
    lastdata = widget.endDate == 'null' ? false : true;
  }

  List educationListData = [];

  Future<String> getDegreesList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse('https://api.publish.jobs/api/degrees'),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      educationListData = resBody;
    });
    print('resBody');
    return "Sucess";
  }

  TextEditingController institutionnameController = TextEditingController();
  TextEditingController fieldStudyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  Future<List<JobseekerEducationModel>>? educationListFuture;
  String? descriptionData;
  String? institutionData;
  String newInstitutionData = '';
  String? startDateData;
  String? endDateData;
  String? subjectsListData;

  //reserved
  String? instituteNew;
  String? descriptionNew;
  String? subjectListNew;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // end
  bool isAppbar = true;
   DateTime ?startDate;
  late DateTime endData;

  @override
  Widget build(BuildContext context) {
    descriptionData = widget.descriptionUpdateData!;
    institutionData = widget.institueUpdateData!;
    subjectsListData = widget.subjectUpdateData!;
    // DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(widget.startDate!);
    startDateData = widget.startDate;
    endDateData = widget.endDate;

    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: UpdateAppBar(
          appBarText: "Edit Education",
          image: ImangeAssests.dltImage,
          onPressed: () {
            SkillDeleteAlert(
                context,
                widget.id.toString(),
                "delete from Profile",
                "this wil delete from all section of you",
                "profile",
                "profileGalleryDelete",
                '');
          }),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(
                left: 12, right: 12, top: s.height * 0.06, bottom: 12),
            child: Column(
              children: [
                Material(
                  color: isDarkMode == true
                      ? Color(0xff787777).withOpacity(0.2)
                      : ColorApp.colorwhite,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: ColorApp.colorblackgalf.withOpacity(0.5),
                          width: 1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: s.height * 0.04, right: 0, top: 15, left: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ProfileFormField(
                            image: ImangeAssests.schoolImg,
                            initialName: institutionData,
                            mustText: "*",
                            hintText: "Please enter School/University Name",
                            onValidate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter School/University Name';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                newInstitutionData = value;
                              });
                            },
                            icon: Icons.person_outline,
                            textName: "School/ University",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 8, left: 6),
                          child: Row(
                            children: [
                              Icon(
                                Icons.school_outlined,
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf.withOpacity(0.7)
                                    : ColorApp.colorwhite.withOpacity(0.68),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Degree Name",
                                  style: TextStyle(
                                      color: isDarkMode == false
                                          ? ColorApp.colorblackgalf
                                              .withOpacity(0.7)
                                          : ColorApp.colorwhite
                                              .withOpacity(0.68),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    color: isDarkMode == false
                                        ? ColorApp.colorblackgalf
                                            .withOpacity(0.7)
                                        : ColorApp.colorwhite.withOpacity(0.68),
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 2),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: isDarkMode == true
                                    ? Color(0xff343434)
                                    : Colors.white,
                                border: Border.all(
                                    color: isDarkMode == true
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.black54.withOpacity(0.3))),
                            height: s.height * 0.0579,
                            child: DropdownButton(
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 26,
                                    color: isDarkMode == true
                                        ? AppColors.colorwhite.withOpacity(0.69)
                                        : Colors.grey,
                                  ),
                                ),
                                dropdownColor: Colors.grey,
                                elevation: 1,
                                isExpanded: true,
                                underline: Container(
                                  color: AppColors.colorwhite,
                                ),
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.degreeData.toString(),
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                                value: degreeEducation,
                                onChanged: (v) {
                                  setState(() {
                                    degreeEducation = v as String;
                                    //countryId = (index!+1).toString();
                                    for (var i = 0;
                                        i < educationListData.length;
                                        i++) {
                                      if (educationListData[i]['title'] == v) {
                                        degreeId = educationListData[i]['id']
                                            .toString();
                                        print(degreeId.toString() +
                                            'degree idddddddddddd');
                                      }
                                    }
                                  });
                                },
                                items: educationListData.map((v) {
                                  return DropdownMenuItem(
                                    value: v['title'],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        v['title'],
                                        style: TextStyle(
                                            color: isDarkMode == false
                                                ? ColorApp.colorblack
                                                : ColorApp.colorwhite
                                                    .withOpacity(0.9)),
                                      ),
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 8, left: 6),
                          child: Row(
                            children: [
                              Icon(
                                size: 20,
                                Icons.watch_later_outlined,
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf
                                    : ColorApp.colorwhite.withOpacity(0.6),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Date Attended",
                                  style: TextStyle(
                                      color: isDarkMode == false
                                          ? ColorApp.colorblackgalf
                                              .withOpacity(0.7)
                                          : ColorApp.colorwhite
                                              .withOpacity(0.68),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    color: isDarkMode == false
                                        ? ColorApp.colorblackgalf
                                            .withOpacity(0.7)
                                        : ColorApp.colorwhite.withOpacity(0.68),
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 9),
                                  child: TextFormField(
                                    onChanged: (value) {},
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black),
                                    readOnly: true,
                                    validator: (value) {},
                                    controller: startDateController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorApp.colorprimary),
                                      ),
                                      filled: true,
                                      fillColor: isDarkMode == true
                                          ? Color(0xff343434)
                                          : Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                      .withOpacity(0.3)
                                                  : Colors.black54
                                                      .withOpacity(0.3))),

                                      suffixIconConstraints: BoxConstraints(),
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 14),
                                        child: Icon(
                                          size: 15,
                                          Icons.calendar_month_sharp,
                                          color: isDarkMode == true
                                              ? AppColors.colorwhite
                                                  .withOpacity(0.6)
                                              : Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      hintText: startDateData.toString(),
                                      hintStyle: TextStyle(
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : Colors.black),
                                      isDense: true,
                                      // important line
                                      contentPadding: EdgeInsets.fromLTRB(
                                          5,
                                          12,
                                          0,
                                          12), // control your hints text size
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1960),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        //startDateController.clear();
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          startDateController.text =
                                              formattedDate; //set output date to TextField value.
                                          //startDateData=formattedDate;
                                        });
                                        startDate =
                                            DateTime.parse("$formattedDate");
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),

                                // TextFormField(
                                //   style: TextStyle(
                                //       color: isDarkMode == false
                                //           ? Colors.black
                                //           : Colors.black,
                                //       fontSize: 14),
                                //   controller: startDateController,
                                //   //editing controller of this TextField
                                //   // initialValue: startDateData,
                                //   decoration: InputDecoration(
                                //       contentPadding: EdgeInsets.fromLTRB(5, 9, 0, 9),
                                //       filled: true,
                                //       fillColor:isDarkMode==true?Colors.black54:Colors.white,
                                //       border: OutlineInputBorder(
                                //         borderSide: BorderSide(color: Colors.red),
                                //       ),
                                //       enabledBorder: OutlineInputBorder(
                                //           borderSide: BorderSide(
                                //               color: isDarkMode == true
                                //                   ? ColorApp.colorwhite
                                //                   : Colors.black54)),
                                //
                                //       suffixIconConstraints: BoxConstraints(
                                //
                                //
                                //       ),
                                //       suffixIcon: Icon(
                                //           Icons.calendar_month_sharp,
                                //           size: 18,
                                //           color: ColorApp.colorblackgalf),
                                //
                                //       hintText: startDateData.toString(),
                                //       hintStyle: TextStyle(
                                //           color: isDarkMode == false
                                //               ? Colors.black
                                //               : Colors.black)
                                //   ),
                                //   readOnly: true,
                                //   //set it true, so that user will not able to edit text
                                //   onTap: () async {
                                //     DateTime? pickedDate =
                                //         await showDatePicker(
                                //             context: context,
                                //             initialDate: DateTime.now(),
                                //             firstDate: DateTime(1960),
                                //             //DateTime.now() - not to allow to choose before today.
                                //             lastDate: DateTime(2101));
                                //
                                //     if (pickedDate != null) {
                                //       //startDateController.clear();
                                //       print(
                                //           pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                //       String formattedDate =
                                //           DateFormat('yyyy-MM-dd')
                                //               .format(pickedDate);
                                //       print(
                                //           formattedDate); //formatted date output using intl package =>  2021-03-16
                                //       //you can implement different kind of Date Format here according to your requirement
                                //
                                //       setState(() {
                                //         startDateController.text =
                                //             formattedDate; //set output date to TextField value.
                                //         //startDateData=formattedDate;
                                //       });
                                //     } else {
                                //       print("Date is not selected");
                                //     }
                                //   },
                                // )
                              ),
                              Visibility(
                                visible: lastdata,
                                child: Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black),
                                    readOnly: true,
                                    validator: (value) {

                                    },
                                    controller: endDateController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorApp.colorprimary),
                                      ),
                                      filled: true,
                                      fillColor: isDarkMode == true
                                          ? Color(0xff343434)
                                          : Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                      .withOpacity(0.3)
                                                  : Colors.black54
                                                      .withOpacity(0.3))),

                                      suffixIconConstraints: BoxConstraints(),
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 14),
                                        child: Icon(
                                          size: 15,
                                          Icons.calendar_month_sharp,
                                          color: isDarkMode == true
                                              ? AppColors.colorwhite
                                                  .withOpacity(0.6)
                                              : Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      hintText: endDateData.toString(),
                                      hintStyle: TextStyle(
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : Colors.black),
                                      isDense: true,
                                      // important line
                                      contentPadding: EdgeInsets.fromLTRB(
                                          5,
                                          12,
                                          0,
                                          12), // control your hints text size
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1960),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        //startDateController.clear();
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          endDateController.text =
                                              formattedDate; //set output date to TextField value.
                                          //startDateData=formattedDate;
                                        });
                                        endData =
                                            DateTime.parse("$formattedDate");
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30.0,
                                width: 30.0,
                                child: Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: AppColors.colorprimary,
                                    focusColor: Colors.blue,
                                    side: BorderSide(
                                      color: isDarkMode == false
                                          ? Colors.grey
                                          : Colors.white,
                                      //your desire colour here
                                      width: 1.5,
                                    ),
                                    value: isProgress,
                                    onChanged: (value) {
                                      setState(() {
                                        this.isProgress = value!;
                                        //endDateController.clear();
                                        lastdata = lastdata ? false : true;
                                      });
                                    }),
                              ),
                              Expanded(
                                  child: Text(
                                " I am currently enrolled here",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode == false
                                      ? ColorApp.colorblackgalf.withOpacity(0.7)
                                      : ColorApp.colorwhite.withOpacity(0.68),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: s.height * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0, right: 10),
                        child: SubmitButton(
                            border: Border.all(
                                color: isDarkMode == false
                                    ? AppColors.colorblack
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
                      Consumer<PostEducationController>(
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
                                      if (_formkey.currentState!.validate()) {
                                        val.updateEducation(
                                            widget.id.toString(),
                                            degreeId ??
                                                widget.degreeId.toString(),
                                            newInstitutionData.toString() == ''
                                                ? institutionData.toString()
                                                : newInstitutionData.toString(),
                                            startDateController.text == ''
                                                ? startDateData.toString()
                                                : startDateController.text,
                                            endDateController.text == ''
                                                ? endDateData.toString()
                                                : endDateController.text,
                                            isProgress.toString(),
                                            subjectListNew ??
                                                subjectsListData.toString(),
                                            descriptionNew ??
                                                descriptionData.toString(),
                                            context);
                                        print((instituteNew ??
                                                institutionData.toString()) +
                                            'subject list id');
                                        Provider.of<GetQualificationController>(
                                                context,
                                                listen: false)
                                            .educationListData
                                            .clear();

                                        Timer(Duration(seconds: 5), () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            Provider.of<GetQualificationController>(
                                                    context,
                                                    listen: false)
                                                .getEducationList();
                                          });
                                          Get.back();
                                        });
                                      }
                                    },
                                    child: Container(
                                        height: s.height * 0.055,
                                        width: s.width * 0.36,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Center(
                                          child: val.loadingEducationUpdate ==
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
                    ],
                  ),
                ),
              ],
            ),
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
                                          text:
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
                Consumer<PostEducationController>(
                  builder: (context, val, child) {
                    return ElevatedButton(
                      onPressed: () {
                        // val.jobEducationDelete(widget.id.toString(), context);
                        //
                        // Provider.of<GetQualificationController>(
                        //     context,
                        //     listen: false)
                        //     .educationListData
                        //     .clear();
                        //
                        // Timer(Duration(seconds: 1), () {
                        //   WidgetsBinding.instance
                        //       .addPostFrameCallback((_) {
                        //     Provider.of<GetQualificationController>(
                        //         context,
                        //         listen: false)
                        //         .getEducationList();
                        //   });
                        //   Get.back();
                        //   Get.back();
                        //
                        // });
                        val.jobEducationDelete(widget.id.toString(), context);

                        Provider.of<GetQualificationController>(context,
                                listen: false)
                            .educationListData
                            .clear();
                        Timer(Duration(seconds: 2), () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Provider.of<GetQualificationController>(context,
                                    listen: false)
                                .getEducationList();
                          });
                          Get.back();
                          Get.back();
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
                      child: val.loadingEducationDelete == false
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
                              height: 20.0,
                              width: 20.0,
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
