import 'dart:async';

import 'package:firstapp/component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../App Services/api_services_provider.dart';
import '../../App Services/global_vars.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_certificationList_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_training_certification_controller.dart';
import '../../api/api.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';
import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';

class AddTraningCertification extends StatefulWidget {
  const AddTraningCertification({Key? key}) : super(key: key);

  @override
  State<AddTraningCertification> createState() =>
      _AddTraningCertificationState();
}

class _AddTraningCertificationState extends State<AddTraningCertification> {
  @override
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
  bool _autovalidate = false;
  late DateTime startDate;
  late DateTime endData;
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
      isDarkMode==true?Color(0xff343434):Colors.white,
      appBar: AddAppBar(
        appBarText: "Add Training & Certification",
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 1, left: 7, bottom: s.height * 0.04),
                  child: Text(
                    "Add Your Career relevent achievements add almost 5 achievements ",
                    style: TextStyle(
                        color: isDarkMode == false
                            ? ColorApp.colorblack.withOpacity(0.6)
                            : ColorApp.colorbackground.withOpacity(0.69),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Material(
                  color:isDarkMode == true
                      ? Color(0xff787777).withOpacity(0.2)
                      : ColorApp.colorwhite,
                  shape: RoundedRectangleBorder(
                      side: isDarkMode == false
                          ? BorderSide(color: Colors.black45.withOpacity(0.3))
                          : BorderSide(
                              color: ColorApp.colorblackgalf.withOpacity(0.1),
                            ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 8, top: 8, bottom: s.height * 0.04),
                    child: Column(
                      children: [
                        ProfileFormField(
                          image: ImangeAssests.certificateImg,
                          initialName: titleData,
                          mustText: "*",
                          hintText: "Please Add your certification name",
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Add your certification name';
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
                          textName: "Certification Name",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8,left: 0),
                          child: ProfileFormField(
                            image: ImangeAssests.companyImg,
                            initialName: companyData,
                            mustText: "*",
                            hintText:
                                "Please type your name of the institute here",
                            onValidate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please type your name of the institute here';
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
                            textName: "Institute",
                          ),
                        ),
                        Padding(
                          padding:
                           const EdgeInsets.only(top: 8, bottom: 8,left: 5),
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
                                  "Date",
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
                                            .withOpacity(0.6)
                                        : ColorApp.colorwhite.withOpacity(0.9),
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 9),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black.withOpacity(0.7)),
                                    readOnly: true,
                                    validator: (formattedDate) {
                                      if (formattedDate!.isEmpty ||
                                          formattedDate == null) {
                                        return 'Please enter the start data';
                                      }
                                    },
                                    controller: startDateController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      focusedBorder:
                                      OutlineInputBorder(
                                        borderSide:
                                        BorderSide(

                                            color:ColorApp.colorprimary
                                        ),

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
                                              color:  isDarkMode == true
                                                  ? Colors.white.withOpacity(0.3)
                                                  : Colors.black54.withOpacity(0.3))),
                                      suffixIconConstraints: BoxConstraints(),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(5, 12, 0, 11),
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

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black.withOpacity(0.7)),
                                    validator: (formattedDate) {
                                      if (formattedDate!.isEmpty ||
                                          formattedDate == null) {
                                        return 'Please enter the end data';
                                      }
                                      if(startDate.isAfter(endData)){
                                        return "End Date Not valid";

                                      }
                                    },
                                    controller: endDateController,
                                    readOnly: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      focusedBorder:
                                      OutlineInputBorder(
                                        borderSide:
                                        BorderSide(

                                            color:ColorApp.colorprimary
                                        ),

                                      ),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(5, 12, 0, 11),
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
                                                  ? Colors.white.withOpacity(0.3)
                                                  : Colors.black54.withOpacity(0.3))),
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
                                      isDense: true,
                                      // important line
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

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 0,left: 0),
                          child: ProfileFormField(
                            image: ImangeAssests.jobreviewImg,
                            line: 3,
                            initialName: descriptionData,
                            mustText: "*",
                            hintText:
                                "define your Goals and Achivements in details",
                            onChanged: (value) {
                              setState(() {
                                descriptionData = value;
                              });
                            },
                            icon: Icons.edit_calendar,
                            textName: "Description",
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
                      Consumer<PostTrainingCertification>(
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
                                        val.addTrainingCertification(
                                            titleData.toString(),
                                            companyData.toString(),
                                            descriptionData.toString(),
                                            startDateController.text.toString(),
                                            endDateController.text,
                                            context);
                                        Provider.of<GetCertificationController>(context,listen: false).certificationsListData.clear();

                                        Timer(Duration(seconds: 2), () {
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            Provider.of<GetCertificationController>(context,listen: false).jobSeekerCertifications();
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
                                          child: val.loadingAddCertificiton ==
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
}
