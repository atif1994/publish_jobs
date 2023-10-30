import 'dart:async';

import 'package:firstapp/views_screen/profile_screen/profile_add_skill_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_skill_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_delete_AlertApi_profilebase_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_job_skill_controller.dart';
import '../../api/api.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../profile_model/job_seeker_skill_model.dart';
import '../../utils/app_color.dart';


class SkillListShow extends StatefulWidget {
  const SkillListShow({Key? key}) : super(key: key);

  @override
  State<SkillListShow> createState() => _SkillListShowState();
}

class _SkillListShowState extends State<SkillListShow> {
  bool deleteData = false;

  @override
  Widget build(BuildContext context) {
    ABD abd = ABD();
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode == true ? ColorApp.colorblack : ColorApp.colorbackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            isDarkMode == true ? ColorApp.colorblack : ColorApp.colorbackground,
        elevation: 0,
        actions: [
          Container(
            width: s.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.asset(
                    fit: BoxFit.contain,
                    "images/abc.png",
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Container(
                            decoration: BoxDecoration(
                              color: ColorApp.colorwhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: s.width * 0.099,
                            height: s.height * 0.044,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: Icon(
                                color: Colors.grey,
                                size: 18,
                                Icons.notification_add_outlined,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 7),
                      child: Container(
                        child: Image.asset(
                          fit: BoxFit.contain,
                          height: 80,
                          ImangeAssests.personImage,
                          width: s.width * 0.099,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<JobseekerSkillModel>>(
              future: GetJobSkillController().jobSeekerSkill(),
              builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                width: s.width,
                height: s.height * 0.16,
                color: isDarkMode == false
                    ? Colors.white
                    : const Color(0xff38373c),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white30,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 10, 5, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 40.0,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 5, 5, 5),
                                child: Container(
                                  width: s.width * 0.94,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 5, 5, 5),
                                child: Container(
                                  width: s.width * 0.94,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 5, 5, 5),
                                child: Container(
                                  width: s.width * 0.94,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 5, 5, 10),
                                child: Container(
                                  width: s.width * 0.94,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                    color:  isDarkMode == true ? ColorApp.colorblack : ColorApp.colorbackground),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: s.height * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: s.width * 0.07),
                            child: Text(
                              "Skills",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: isDarkMode == true
                                    ? Colors.white
                                    : ColorApp.colornewblack,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: s.width * 0.03, top: 9),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    child: Card(
                                      elevation: 2,
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : const Color(0xff38373c),
                                      child: Container(
                                        height: s.height * 0.03,
                                        width: s.width * 0.06,
                                        child: Center(
                                          child: Icon(
                                            Icons.delete,
                                            size: 16,
                                            color: isDarkMode == false
                                                ? AppColors.colordark
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        deleteData =
                                            deleteData ? false : true;
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    child: Card(
                                      elevation: 2,
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : const Color(0xff38373c),
                                      child: Container(
                                        height: s.height * 0.03,
                                        width: s.width * 0.06,
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 16,
                                            color: isDarkMode == false
                                                ? AppColors.colordark
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddSkill()));
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                // padding: const EdgeInsets.all(10),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 0,
                                maxCrossAxisExtent: 180.0,

                                childAspectRatio: 3,
                              ),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 10,
                                              left: s.width * 0.059),
                                          child: Container(
                                            width: s.width * 0.09,
                                            height: s.height * 0.04,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorApp.colorprimary),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        ColorApp.colorprimary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                width: s.width * 0.10,
                                                height: 32,
                                                child: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data?[index].title
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                  : ColorApp.colornewblack,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showAlertDialog(
                                                context,
                                                snapshot.data![index].id
                                                    .toString());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 25),
                                            child: Visibility(
                                                visible: deleteData,
                                                child: Icon(
                                                  Icons.dangerous,
                                                  color: AppColors.colorred,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
              },
            ),
          ],
        ),
      ),
    );
  }


  showAlertDialog(BuildContext context, id) {
    ABD abd = ABD();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // set up the buttons

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
            backgroundColor: isDarkMode == true ? Colors.grey : Colors.white,

            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  color: isDarkMode == true ? Colors.grey : Colors.white,
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(

                              color: isDarkMode == true
                                  ? Colors.black87
                                  : Colors.grey),
                          width: Get.width,
                          height: Get.height * 0.06,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, top: 12),
                            child: Text(
                              "Delete From Profile",
                              style: TextStyle(
                                  color: isDarkMode == true
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          )),



                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.27),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.red),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurple[50]),
                              ),
                              child: Text(
                                'No,Thanks',
                                style: TextStyle(
                                    fontSize: 18, color: ColorApp.colorprimary),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Consumer<PostDeleteAlertProfileBase>(
                              builder: (context, val, child) {
                                return ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      val.jobSkillDelete(id, context);
                                      Timer(Duration(seconds: 2), () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SkillListShow()));
                                      });
                                    });
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    )),
                                    shadowColor:
                                        MaterialStateProperty.all(Colors.red),
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorApp.colorprimary),
                                  ),
                                  child: val.loadingSkillDelete == false
                                      ? Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isDarkMode == false
                                                  ? AppColors.colorwhite
                                                  : Colors.white),
                                        )
                                      : CircularProgressIndicator(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )

            );
      },
    );
  }
}
