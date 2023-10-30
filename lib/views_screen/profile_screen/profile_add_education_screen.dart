import 'dart:async';
import 'dart:convert';

import 'package:firstapp/component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../App Services/api_services_provider.dart';
import '../../App Services/global_vars.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_qualification_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_education_controller.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';

import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/update_appbar_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';
import '../applay_screen/applay_person_info_screen.dart';
import '../applay_screen/applay_qualification_screen.dart';

class AddEducation extends StatefulWidget {
  final String? navDecider;

  AddEducation({Key? key, this.navDecider}) : super(key: key);

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  String? selectedValue = null;
  bool isDark = false;
  String? degreeEducation;
  String? degreeId;
  bool value = false;
  List educationList = [];
  bool isProgress = false;
  bool lastdata = true;

  @override
  void initState() {
    super.initState();
    this.getDegreesList();
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
    //print(resBody);
    return "Sucess";
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String? _dropdownError;

  String? descriptionData;
  String? institutionData;
  String? startDateData;
  String? endDateData;
  String? subjectsListData;

  _validateForm(String? validationValue) {
    bool _isValid = _formkey.currentState!.validate();

    if (validationValue == null) {
      setState(() => _dropdownError = "Please select an option!");
      _isValid = false;
    } else
      setState(() => _dropdownError = "");
    _isValid = false;

    if (_isValid) {
      Text("");
    }
  }
  late DateTime startDate;
  late DateTime endData;

  //reserved
  String? instituteNew;
  String? descriptionNew;
  String? subjectListNew;


  // end
  bool isAppbar = true;
  bool iconshow = true;

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AddAppBar(
        appBarText: "Add Education",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 1, left: 7, bottom: s.height * 0.04),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        "Add Your education give the best you are.",
                        style: TextStyle(
                            color: isDarkMode == false
                                ? ColorApp.colorblack.withOpacity(0.6)
                                : ColorApp.colorbackground.withOpacity(0.69),
                            fontWeight: FontWeight.w600),
                      )),
                    ],
                  ),
                ),
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
                        left: 12, right: 0, top: 8, bottom: s.height * 0.04),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        ProfileFormField(
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
                              institutionData = value;
                            });
                          },
                          icon: Icons.account_balance,
                          textName: "School/ University",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 8, left: 6),
                          child: Row(
                            children: [
                              Icon(
                                Icons.school_outlined,
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf
                                    : ColorApp.colorwhite.withOpacity(0.6),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Degree Name",
                                  style: TextStyle(
                                      color: isDarkMode == false
                                          ? ColorApp.colorblackgalf
                                          : ColorApp.colorwhite
                                              .withOpacity(0.6),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    color: isDarkMode == false
                                        ? ColorApp.colorblackgalf
                                        : ColorApp.colorwhite.withOpacity(0.6),
                                    fontWeight: FontWeight.w500),
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
                                dropdownColor: isDarkMode == false
                                    ? ColorApp.colorblackgalf
                                    : ColorApp.colorblackgalf,
                                elevation: 1,
                                isExpanded: true,
                                underline: Container(
                                  color: AppColors.colorblue,
                                ),
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Please Select you degree',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: isDarkMode == true
                                            ? AppColors.colorwhite
                                                .withOpacity(0.69)
                                            : Colors.grey,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                value: degreeEducation,
                                onChanged: (v) {
                                  setState(() {
                                    _dropdownError = null;
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
                                            color: isDarkMode == true
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                        _dropdownError == null
                            ? SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(left: 5, top: 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      _dropdownError ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                        ProfileFormField(
                          image: ImangeAssests.schoolImg,
                          initialName: subjectsListData,
                          mustText: "*",
                          hintText: "The Field Of Study field is required",
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'The Field Of Study field is required';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              subjectsListData = value;
                            });
                          },
                          icon: Icons.account_balance,
                          textName: "Major Subjects or Field Of Study",
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
                                          : ColorApp.colorwhite
                                              .withOpacity(0.6),
                                      fontWeight: FontWeight.w500),
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
                          padding: const EdgeInsets.only(left: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 9),
                                  child: TextFormField(
                                    onChanged: (value) {

                                    },
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black),
                                    readOnly: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter start date';
                                      } else {
                                        return null;
                                      }
                                    },
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
                                      hintText: 'From',
                                      isDense: true,
                                      // important line
                                      contentPadding:
                                          EdgeInsets.fromLTRB(5, 12, 0, 12),
                                      // control your hints text size
                                      hintStyle: TextStyle(
                                          letterSpacing: 2,
                                          fontSize: 14,
                                          color: isDarkMode == true
                                              ? AppColors.colorwhite
                                                  .withOpacity(0.69)
                                              : Colors.grey,
                                          fontWeight: FontWeight.w300),
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
                                            pickedDate);

                                        //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDatestart =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        print(
                                            formattedDatestart); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement
                                      startDate = DateTime.parse("$formattedDatestart");



                                        setState(() {
                                          startDateController.text =
                                              formattedDatestart; //set output date to TextField value.
                                          //startDateData=formattedDate;
                                        });

                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: lastdata,
                                child: Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: TextFormField(

                                      validator: (value) {
                                        if (isProgress == null ||
                                            value!.isEmpty) {
                                          return "EndDate or InProgress";
                                        }
                                        if(startDate.isAfter(endData)){
                                          return "End Date Not valid";

                                        }

                                      },
                                      style: TextStyle(
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : Colors.black),
                                      readOnly: true,
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
                                        hintText: 'to',
                                        hintStyle: TextStyle(
                                            letterSpacing: 2,
                                            fontSize: 14,
                                            color: isDarkMode == true
                                                ? AppColors.colorwhite
                                                    .withOpacity(0.69)
                                                : Colors.grey,
                                            fontWeight: FontWeight.w300),
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
                                          endData = DateTime.parse("$formattedDate");

                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30.0,
                                width: 30.0,
                                child: Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    activeColor: Colors.white,
                                    checkColor: AppColors.colorprimary,
                                    focusColor: Colors.blue,
                                    side: BorderSide(
                                      color: isDarkMode == true
                                          ? AppColors.colorwhite
                                              .withOpacity(0.6)
                                          : Colors.black.withOpacity(0.7),
                                      //your desire colour here
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
                              Text(
                                " I'm currently work here",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode == false
                                      ? ColorApp.colorblackgalf.withOpacity(0.7)
                                      : ColorApp.colorwhite.withOpacity(0.68),
                                ),
                              )
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
                                color: ColorApp.colorprimary,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    splashColor:
                                        AppColors.colorindigo.withOpacity(0.8),
                                    onTap: () {
                                      print(degreeId.toString());
                                      print(institutionData.toString());
                                      print(startDateController.toString());
                                      print(endDateController.toString());
                                      print(isProgress.toString());
                                      print(subjectsListData.toString());

                                      if (_formkey.currentState!.validate()) {
                                        _validateForm(degreeId);
                                        print(endDateController.toString());
                                        val.addEducation(
                                            degreeId!,
                                            institutionData.toString(),
                                            startDateController.text,
                                            endDateController.text.toString(),
                                            isProgress.toString(),
                                            subjectsListData.toString(),
                                            context);

                                        Provider.of<GetQualificationController>(
                                                context,
                                                listen: false)
                                            .educationListData
                                            .clear();

                                        Timer(Duration(seconds: 2), () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            Provider.of<GetQualificationController>(
                                                    context,
                                                    listen: false)
                                                .getEducationList();
                                          });
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                    child: Container(
                                        height: s.height * 0.05,
                                        width: s.width * 0.36,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Center(
                                          child: val.loadingEducation == false
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
}
