import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/update_appbar_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';
import '../applay_screen/applay_experience_screen.dart';

class EditExperience extends StatefulWidget {
  final String? id;
  final String? titleData;
  final String? companyData;
  final String? descriptionData;
  final String? dataUpdateStart;
  final String? dataUpdateEnd;
  final String? inprogressData;
  final String? navigationDeciderId;
   EditExperience({Key? key, this.id,
    this.titleData,
    this.companyData,
    this.descriptionData,
    this.dataUpdateStart,
    this.inprogressData,
    this.dataUpdateEnd,this.navigationDeciderId}) : super(key: key);

  @override
  State<EditExperience> createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  Future<List<JobseekerWorkExperienceModel>>? experienceListFuture;

  bool valueProgress = false;
  bool isAppbar = true;
  bool progress = true;
  String sDate = '';
  String eDate = '';
  bool isProgress = false;
  @override
  void initState() {
    //set the initial value of text field
    super.initState();
    experienceListFuture = GetExperienceController().getWorkExperienceList();
    progress = widget.inprogressData == 'false'?false:true;
    valueProgress = widget.inprogressData == 'false'?true:false;
    isProgress = widget.dataUpdateEnd == 'null' ? true : false;
    lastdata = widget.dataUpdateEnd == 'null' ? false : true;
    sDate = widget.dataUpdateStart.toString();
    eDate = widget.dataUpdateEnd.toString();

  }

  TextEditingController titleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? title;
  String? company;
  String? description;
  String? newTitle;
  String? newCompany;
  String? newDescription;
  final _formKey = GlobalKey<FormState>();
  String? startDateData='';
  String? endDateData;
  bool lastdata = false;
  @override
  Widget build(BuildContext context) {
    ABD abd = ABD();


    startDateData = widget.dataUpdateStart;
    endDateData = widget.dataUpdateEnd;

    title = widget.titleData;
    company = widget.companyData;
    description=widget.descriptionData;
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor:
      isDarkMode==true?Color(0xff343434):Colors.white,
      appBar: UpdateAppBar(appBarText: "Edit Experience",image: ImangeAssests.dltImage,onPressed: (){
        SkillDeleteAlert(
            context,
            widget.id.toString(),
            "delete from Profile",
            "this wil delete from all section of you",
            "profile",
            "profileGalleryDelete",'');
      }),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                          initialName: title,
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
                              newTitle = value;
                            });
                          },
                          icon: Icons.account_balance,
                          textName: "Company Name",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8,left: 0),
                          child: ProfileFormField(
                            image: ImangeAssests.postImg,
                            initialName: company,
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
                                newCompany =value;
                              });
                            },
                            icon: Icons.account_balance,
                            textName: "Work Title",
                          ),
                        ),
                    Padding(

                      padding: const EdgeInsets.only(top: 8, bottom: 3,left: 5),
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
                          padding: const EdgeInsets.only(left: 2,top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0,right: 9),
                                    child: TextFormField(
                                      style: TextStyle(
                                          color:  isDarkMode==true?Colors.white:Colors.black
                                      ),
                                      readOnly: true,


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
                                        fillColor:isDarkMode == true
                                            ? Color(0xff343434)
                                            : Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                  color: isDarkMode == true
                                            ? Colors.white.withOpacity(0.3)
                                                : Colors.black54.withOpacity(0.3))),

                                        suffixIconConstraints: BoxConstraints(


                                        ),
                                        suffixIcon: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              right: 14),
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
                                            color:  isDarkMode==true?Colors.white:Colors.black),
                                        isDense: true, // important line
                                        contentPadding: EdgeInsets.fromLTRB(5, 12, 0, 12),// control your hints text size


                                      ),
                                      onTap: ()async{
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
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                  )

                              ),

                              Visibility(
                                visible: lastdata,
                                child: Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 13),
                                    child: TextFormField(
                                      style: TextStyle(
                                          color:  isDarkMode==true?Colors.white:Colors.black
                                      ),
                                      readOnly: true,


                                      controller: endDateController,
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
                                        fillColor:isDarkMode == true
                                            ? Color(0xff343434)
                                            : Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                            color: isDarkMode == true
                                            ? Colors.white
                                                .withOpacity(0.6)
                                                : Colors.black54
                                            .withOpacity(0.3))),

                                        suffixIconConstraints: BoxConstraints(


                                        ),
                                        suffixIcon: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              right: 14),
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
                                            color:  isDarkMode==true?Colors.white:Colors.black),
                                        isDense: true, // important line
                                        contentPadding:
                                        EdgeInsets.fromLTRB(5, 12, 0, 12),// control your hints text size


                                      ),
                                      onTap: ()async{
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
                      padding: const EdgeInsets.only(top: 10),
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
                                      ? ColorApp.colorblackgalf
                                      .withOpacity(0.7)
                                      : ColorApp.colorwhite
                                      .withOpacity(0.68),

                                ),
                              ))
                        ],
                      ),
                    ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 0,left: 0),
                          child: ProfileFormField(
                            image: ImangeAssests.jobreviewImg,
                            line: 4,
                            initialName: description,
                            mustText: "*",
                            hintText: "Please select company",
                            onValidate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'add Description about your experiencs';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                newDescription=value;
                              });
                            },
                            icon:Icons.edit_calendar,
                            textName: "Add Description",
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top:s.height*0.04),
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
                                        val.jobSeekerUpdateWorkExperience(
                                            widget.id.toString(),
                                            newTitle?? title.toString(),
                                            newCompany?? company.toString(),
                                            newDescription?? description.toString(),
                                            startDateController.text==''? startDateData.toString():startDateController.text,
                                            progress==true? '': endDateController.text,
                                            progress.toString(),
                                            context);
                                        Provider.of<GetExperienceController>(context,listen: false).workexperienceListData.clear();
                                        Timer(Duration(seconds: 2), () {
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            Provider.of<GetExperienceController>(context,listen: false).getWorkExperienceList();
                                          });
                                          Get.back();
                                        });


                                        // GlobalVarData.isExperienceAdd = 'done';
                                        // Navigator.of(context).popUntil((route) => route.isFirst);
                                        // Timer.periodic(Duration(seconds: 2),
                                        //         (timer) {
                                        //       if (!mounted) {
                                        //         return;
                                        //       }
                                        //       GlobalVarData.isExperienceAdd='done';
                                        //       //Navigator.of(context).popUntil((route) => route.isFirst);
                                        //
                                        //     });
                                        // Timer(Duration(seconds: 1), () {
                                        //   if(widget.navigationDeciderId=='2'){
                                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplayExperienced()));
                                        //
                                        //   }
                                        // });
                                      }
                                    },
                                    child: Container(
                                        height: s.height * 0.05,
                                        width: s.width * 0.36,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(3)),
                                        child: Center(
                                          child: val.loadingUpdateWorkExperience == false
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
                //             Get.back();
                //
                //           }),
                //
                //
                //       Padding(
                //         padding: const EdgeInsets.only(left: 8),
                //         child:  Consumer<PostExperienceController>(builder: (context,val,child){
                //           return   ElevatedButton(
                //             onPressed: () {
                //
                //
                //
                //
                //
                //             },
                //             style: ButtonStyle(
                //               // shadowColor: MaterialStateProperty.all(Colors.red),
                //
                //               backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                //
                //             ),
                //             child:val. loadingUpdateWorkExperience==false?  Text(
                //               "Save changes",
                //               style: TextStyle(
                //                   color: isDarkMode == false
                //                       ? AppColors.colorwhite
                //                       : Colors.white),
                //             ):CircularProgressIndicator(),
                //           );
                //         }),
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
  // SkillDeleteAlert(
  //     BuildContext context, id, deleteText, subtitle, subtitle2, uniqueId) {
  //   var brightness = MediaQuery.of(context).platformBrightness;
  //   bool isDarkMode = brightness == Brightness.dark;
  //
  //   AlertDialog alert = AlertDialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     backgroundColor: isDarkMode == true ? Colors.grey : Colors.white,
  //     insetPadding: EdgeInsets.only(
  //       bottom: Get.height * 0.42,
  //       top: Get.height * 0.3,
  //       left: Get.width * 0.04,
  //       right: Get.width * 0.04,
  //     ),
  //     contentPadding: EdgeInsets.zero,
  //     actions: [
  //       Column(
  //         children: [
  //           Container(
  //               decoration: BoxDecoration(
  //                   color: isDarkMode == true ? Colors.black87 : Colors.grey),
  //               width: MediaQuery.of(context).size.width,
  //               height: Get.height * 0.06,
  //               child: Padding(
  //                 padding: EdgeInsets.only(left: Get.width * 0.05, top: 12),
  //                 child: Text(
  //                   deleteText,
  //                   style: TextStyle(
  //                       color:
  //                       isDarkMode == true ? Colors.white : Colors.black),
  //                 ),
  //               )),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 10),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       subtitle,
  //                       style: TextStyle(
  //                           color: isDarkMode == true
  //                               ? Colors.black26
  //                               : Colors.grey),
  //                     ),
  //                     Text(
  //                       subtitle2,
  //                       style: TextStyle(
  //                           color: isDarkMode == true
  //                               ? Colors.black26
  //                               : Colors.grey),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               SizedBox(
  //                 width: Get.width * 0.3,
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   height: Get.height * 0.05,
  //                   width: Get.width * 0.3,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(18.0),
  //                     color: Colors.blueAccent.withOpacity(0.3),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       'No Thanks',
  //                       style: TextStyle(
  //                           fontSize: 15, color: ColorApp.colorprimary),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: Get.width * 0.03,
  //               ),
  //               Consumer<PostExperienceController>(
  //                 builder: (context, val, child) {
  //                   return ElevatedButton(
  //                     onPressed: () {
  //                       val.jobExperienceDelete(widget.id.toString(), context);
  //                       Provider.of<GetExperienceController>(context,listen: false).workexperienceListData.clear();
  //                       Timer(Duration(seconds: 2), () {
  //                         WidgetsBinding.instance.addPostFrameCallback((_) {
  //                           Provider.of<GetExperienceController>(context,listen: false).getWorkExperienceList();
  //                         });
  //                         Get.back();
  //                         Get.back();
  //                       });
  //                     },
  //                     style: ButtonStyle(
  //                       shape:
  //                       MaterialStateProperty.all<RoundedRectangleBorder>(
  //                           RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(18.0),
  //                           )),
  //                       shadowColor: MaterialStateProperty.all(Colors.red),
  //                       backgroundColor:
  //                       MaterialStateProperty.all(ColorApp.colorprimary),
  //                     ),
  //                     child: val.loadingExperienceDelete == false
  //                         ? Text(
  //                       "Delete",
  //                       style: TextStyle(
  //                           fontSize: 16,
  //                           color: isDarkMode == false
  //                               ? AppColors.colorwhite
  //                               : Colors.white),
  //                     )
  //                         : SizedBox(
  //                       child: CircularProgressIndicator(),
  //                       height: 20.0,
  //                       width: 20.0,
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
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
                Consumer<PostExperienceController>(
                  builder: (context, val, child) {
                    return ElevatedButton(
                      onPressed: () {
                        val.jobExperienceDelete(widget.id.toString(), context);
                        Provider.of<GetExperienceController>(context,listen: false).workexperienceListData.clear();
                        Timer(Duration(seconds: 2), () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Provider.of<GetExperienceController>(context,listen: false).getWorkExperienceList();
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
                      child: val.loadingExperienceDelete == false
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
