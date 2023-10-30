import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_certificationList_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_delete_AlertApi_profilebase_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_updata_certification_controller.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/update_appbar_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';

class EditTraningCertification extends StatefulWidget {
  final String? id;
  final String? certificateName;
  final String? institueUpdateData;
  final String? descriptionUpdateData;
  final String? startDate;
  final String? endDate;
  final String? degreeStatus;

  final String? degreeData;
  final String? navigationDeciderId;

  EditTraningCertification({
    Key? key,
    this.id,
    this.institueUpdateData,
    this.certificateName,
    this.degreeStatus,
    this.descriptionUpdateData,
    this.degreeData,
    this.navigationDeciderId,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  State<EditTraningCertification> createState() =>
      _EditTraningCertificationState();
}

class _EditTraningCertificationState extends State<EditTraningCertification> {
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
  String newCertificationName = '';
  String newInstitute = '';
  String newDescriptionData = '';
  String? certificationName;
  String? institute;
  String? descriptionData = '';
  String? startDateData;
  String? endDateData;
  bool _autovalidate = false;
  bool tempLoadDeleteCertificate = false;

  Widget build(BuildContext context) {
    certificationName = widget.certificateName.toString();
    institute = widget.institueUpdateData.toString();
    descriptionData = widget.descriptionUpdateData.toString();
    startDateData = widget.startDate;
    endDateData = widget.endDate;
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: UpdateAppBar(
          appBarText: "Edit Training & Certification",
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
                          image: ImangeAssests.certificateImg,
                          initialName: certificationName,
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
                              newCertificationName = value;
                            });
                          },
                          icon: Icons.account_balance,
                          textName: "Certification Name",
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, bottom: 8, left: 0),
                          child: ProfileFormField(
                            image: ImangeAssests.companyImg,
                            initialName: institute,
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
                                newInstitute = value;
                              });
                            },
                            icon: Icons.account_balance,
                            textName: "Institute",
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, bottom: 8, left: 5),
                          child: Row(
                            children: [
                              Icon(
                                size: 17,
                                Icons.watch_later_outlined,
                                color: isDarkMode == false
                                    ? ColorApp.colorblackgalf
                                    : ColorApp.colorwhite.withOpacity(0.9),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 9),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: isDarkMode == true
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.71),
                                    ),
                                    readOnly: true,
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
                                      contentPadding:
                                          EdgeInsets.fromLTRB(5, 12, 0, 11),
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 14),
                                        child: Icon(
                                            size: 14,
                                            Icons.calendar_month_sharp,
                                            color: isDarkMode == true
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      hintText: startDateData,
                                      isDense: true,
                                      // important line

                                      hintStyle: TextStyle(
                                          letterSpacing: 2,
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
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
                                          : Colors.black.withOpacity(0.71),
                                    ),
                                    controller: endDateController,
                                    readOnly: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorApp.colorprimary),
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
                                                  ? Colors.white
                                                      .withOpacity(0.3)
                                                  : Colors.black54
                                                      .withOpacity(0.3))),
                                      suffixIconConstraints: BoxConstraints(),

                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 14),
                                        child: Icon(
                                            size: 14,
                                            Icons.calendar_month_sharp,
                                            color: isDarkMode == true
                                                ? Colors.white
                                                : Colors.black54),
                                      ),
                                      hintText: endDateData,
                                      isDense: true,
                                      // important line
                                      hintStyle: TextStyle(
                                          letterSpacing: 2,
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : Colors.black,
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
                          padding:
                              const EdgeInsets.only(top: 8, bottom: 0, left: 0),
                          child: ProfileFormField(
                            image: ImangeAssests.jobreviewImg,
                            line: 3,
                            initialName: descriptionData ?? '',
                            mustText: "*",
                            hintText:
                                "define your Goals and Achivements in details",
                            onValidate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'add Description about your experiencs';
                              } else {
                                return null;
                              }
                            },
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
                      Consumer<UpdateTrainingCertification>(
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
                                        val.UpdataTrainingCertification(
                                            widget.id.toString(),
                                            newCertificationName == ''
                                                ? certificationName.toString()
                                                : newCertificationName
                                                    .toString(),
                                            newInstitute.toString() == ''
                                                ? institute.toString()
                                                : newInstitute.toString(),
                                            newDescriptionData.toString() == ''
                                                ? descriptionData.toString()
                                                : newDescriptionData.toString(),
                                            startDateController.text
                                                        .toString() ==
                                                    ''
                                                ? startDateData.toString()
                                                : startDateController.text
                                                    .toString(),
                                            endDateController.text.toString() ==
                                                    ''
                                                ? endDateData.toString()
                                                : endDateController.text
                                                    .toString(),
                                            context);
                                        Provider.of<GetCertificationController>(
                                                context,
                                                listen: false)
                                            .certificationsListData
                                            .clear();

                                        Timer(Duration(seconds: 2), () {
                                          // WidgetsBinding.instance
                                          //     .addPostFrameCallback((_) {
                                            Provider.of<GetCertificationController>(
                                                    context,
                                                    listen: false)
                                                .jobSeekerCertifications();
                                        //  });
                                        //  if (mounted) {
                                          //  MediaQuery.of(context).size;
                                            Navigator.of(context).pop();
                                         // }
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
                                          child:
                                              val.loadingUpdateCertificiton ==
                                                      false
                                                  ? Text(
                                                      "Save Changes",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              isDarkMode ==
                                                                      false
                                                                  ? AppColors
                                                                      .colorwhite
                                                                  : Colors
                                                                      .white),
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
                  //  Navigator.of(context, rootNavigator: true).pop(context);
                    Get.back();
                    Navigator.popUntil(context, (route) => route.isFirst);
                    // Get.back();
                    // Get.back();
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
                // Consumer<PostDeleteAlertProfileBase>(
                //   builder: (context, val, child) {
                //     return
                      ElevatedButton(
                      onPressed: () {

                        PostDeleteAlertProfileBase(). jobTraningDelete(id, context);
                        setState(() {
                          tempLoadDeleteCertificate=true;
                        });
                        // Get.back();
                        // Navigator.popUntil(context, (route) => route.isFirst);
                        Timer(Duration(seconds: 3), () {
                         WidgetsBinding.instance.addPostFrameCallback((_) {
                            Provider.of<GetCertificationController>(context,
                                    listen: false)
                                .certificationsListData
                                .clear();
                            Provider.of<GetCertificationController>(context,
                                    listen: false)
                                .jobSeekerCertifications();
                            Get.back();
                            Navigator.popUntil(context, (route) => route.isFirst);
                         });



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
                      child:
                      // val.loadingCertificationDelete == false
                      //     ?
                      Text(
                              "Delete",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: isDarkMode == false
                                      ? AppColors.colorwhite
                                      : Colors.white),
                            )
                       //   :
    // SizedBox(
    //                           child: CircularProgressIndicator(),
    //                           height: 25.0,
    //                           width: 25.0,
    //                         ),
                    )
    //;
                //   },
                // ),
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
