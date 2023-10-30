import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../App Services/api_services_provider.dart';
import '../../App Services/global_vars.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_experience_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_experience_controller.dart';
import '../../api/api.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../profile_model/job_seeker_work_experience_model.dart';
import '../../utils/app_color.dart';

import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';
import 'package:get/get.dart';

import '../applay_screen/applay_experience_screen.dart';

class AddExperience extends StatefulWidget {
  final String? navDecider;

  AddExperience({Key? key, this.navDecider}) : super(key: key);

  @override
  State<AddExperience> createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
  TextEditingController dateInputStartController = TextEditingController();
  TextEditingController dateInputEndController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool valueProgress = false;
  bool isAppbar = true;
  TextEditingController titleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool isProgress = false;
  bool lastdata = true;
  String? titleData;
  String? companyData;
  String? descriptionData;
  String? startDateData;
  String? endDateData;
  Future<List<JobseekerWorkExperienceModel>>? experienceListFuture;

  @override
  void initState() {
    experienceListFuture = GetExperienceController().getWorkExperienceList();
    dateInputStartController.text = "";
    dateInputEndController.text = ""; //set the initial value of text field
    super.initState();
  }

  late DateTime startDate;
  late DateTime endData;
  bool showerro = false;

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AddAppBar(
        appBarText: "Add Experience",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(12),
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
                        "Add Your work experiencs give the best you are.",
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
                        left: 15, right: 8, top: 8, bottom: s.height * 0.04),
                    child: Column(
                      children: [
                        ProfileFormField(
                          image: ImangeAssests.companyImg,
                          initialName: titleData,
                          mustText: "*",
                          hintText: "Please select company",
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select company';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              titleData = value;
                            });
                          },
                          icon: Icons.account_balance,
                          textName: "Company Name",
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, bottom: 8, left: 0),
                          child: ProfileFormField(
                            image: ImangeAssests.postImg,
                            initialName: companyData,
                            mustText: "*",
                            hintText: "job Title",
                            onValidate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please job Title';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                companyData = value;
                              });
                            },
                            icon: Icons.account_balance,
                            textName: "Work Title",
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, bottom: 3, left: 5),
                          child: Row(
                            children: [
                              Icon(
                                size: 17,
                                Icons.watch_later_outlined,
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf
                                    : ColorApp.colorwhite.withOpacity(0.6),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Time Period",
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
                          padding: const EdgeInsets.only(left: 2, top: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black.withOpacity(0.7)),
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
                                      //
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
                                        startDate = DateTime.parse("$formattedDate");
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
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, bottom: 0, left: 0),
                          child: ProfileFormField(
                            image: ImangeAssests.jobreviewImg,
                            line: 4,
                            initialName: descriptionData,
                            mustText: "*",
                            hintText: "Please select company",
                            onChanged: (value) {
                              setState(() {
                                descriptionData = value;
                              });
                            },
                            icon: Icons.edit_calendar,
                            textName: "Add Description",
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
                      Consumer<PostExperienceController>(
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
                                      if (_formKey.currentState!.validate()) {
                                        val.addExperience(
                                            titleData.toString(),
                                            companyData.toString(),
                                            descriptionData.toString(),
                                            startDateController.text.toString(),
                                            endDateController.text.toString(),
                                            isProgress.toString(),
                                            context);
                                        print(endDateController.text +
                                            "show the last data");
                                        print(startDateController.text +
                                            "show the first data");
                                        Provider.of<GetExperienceController>(
                                                context,
                                                listen: false)
                                            .workexperienceListData
                                            .clear();
                                        Timer(Duration(seconds: 2), () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            Provider.of<GetExperienceController>(
                                                    context,
                                                    listen: false)
                                                .getWorkExperienceList();
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
                                          child: val.loadingAddExperience ==
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
                // Padding(
                //   padding:  EdgeInsets.only(top: 10,left: s.width*0.18),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SubmitButton(
                //           border: Border.all(color: Colors.black87),
                //           textColor: isDarkMode == true
                //               ? AppColors.colorwhite
                //               : AppColors.colorblack,
                //           backGroundColor: isDarkMode == true
                //               ? ColorApp.colornewblack
                //               : ColorApp.colorbackground,
                //           borderRadius: BorderRadius.circular(12),
                //           heightButton: s.height * 0.05,
                //           widthButton: s.width * 0.32,
                //           textButton: "Cancel",
                //           onPressed: () {
                //            Get.back();
                //           }),
                //
                //
                //       Padding(
                //         padding: const EdgeInsets.only(left: 8),
                //         child: Consumer<PostExperienceController>(
                //           builder: (context, val, child) {
                //             return Padding(
                //               padding: const EdgeInsets.only(right: 10),
                //               child: Container(
                //               width: s.width * 0.38,
                //                 height: s.height * 0.05,
                //                 decoration: BoxDecoration(
                //                   color: ColorApp.colorprimary,
                //                   borderRadius: BorderRadius.circular(22),
                //                 ),
                //                 child: GestureDetector(
                //                   onTap: (){
                //
                //                   child: val.loadingAddExperience == false
                //                       ? Center(
                //                         child: Text(
                //                     "Save Experience",
                //                     style: TextStyle(
                //                           color: isDarkMode == false
                //                               ? AppColors.colorwhite
                //                               : Colors.white),
                //                   ),
                //                       )
                //                       : CircularProgressIndicator(),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
