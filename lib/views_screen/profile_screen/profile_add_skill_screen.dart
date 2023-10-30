import 'dart:async';
import 'dart:convert';

import 'package:firstapp/model/job_skill_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_skill_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_delete_AlertApi_profilebase_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_job_skill_controller.dart';
import '../../api/api.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';

import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../applay_screen/applay_skill_screen.dart';

class Animal {
  final int? id;
  final String? name;
  final String? name1;
  final String? name2;

  Animal({this.id, this.name, this.name1, this.name2});
}

class AddSkill extends StatefulWidget {
  final String? navDecider;

  AddSkill({Key? key, this.navDecider}) : super(key: key);

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  String? skillSelected;
  String? idSelected;
  List skillList = [];
  List dataTest = [];
  List subjectData = [];
  List<GetSkillModel> skillListData = [];



  Future<List<dynamic>> getSkillList() async {
    List<dynamic> matches = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse("https://api.publish.jobs/api/skillsJobseeker"),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    var data = json.decode(res.body.toString());
    print(data);
    for (Map<String, dynamic> i in data) {
      setState(() {
        skillListData.add(GetSkillModel.fromJson(i));
      });
    }
    setState(() {
      matches = resBody;
    });
    return matches;
  }

  final TextEditingController SkillController = TextEditingController();

  GetSkillModel skillModel = GetSkillModel();
  bool isAppbar = true;

  //List<Animal> _selectedAnimals = [];
  List<GetSkillModel?> _selectedAnimals3 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    //_selectedAnimals5 = _animals;
    getSkillList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _items = skillListData
        .map((Skill) =>
        MultiSelectItem<GetSkillModel?>(Skill, Skill.title.toString()))
        .toList();

    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
        backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
        appBar: AddAppBar(
          appBarText: "Add Skills",
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10, top: 10, left: 10, right: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Your career relevent skills Add almost 10-15 skills",
                              style: TextStyle(
                                  color: isDarkMode == false
                                      ? ColorApp.colorblackgalf
                                      : ColorApp.colorwhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: s.width * 0.010, right: s.width * 0.020, top: 10),
                child: Material(
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
                        left: s.width * 0.03,
                        right: s.width * 0.03,
                        top: s.width * 0.07,
                        bottom: s.width * 0.08),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 5, left: 5, bottom: 10),
                                child: Icon(
                                  Icons.access_time,
                                  color: isDarkMode == false
                                      ? ColorApp.colorblackgalf
                                      : ColorApp.colorwhite,
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 5, left: 5, bottom: 10),
                                child: Text(
                                  "Select Skills",
                                  style: TextStyle(
                                    color: isDarkMode == false
                                        ? ColorApp.colorblackgalf
                                        : ColorApp.colorbackground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _items.isEmpty?
                        Padding(

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
                        )
                        :MultiSelectBottomSheetField<GetSkillModel?>(


                          confirmText: Text("Ok",style: TextStyle(
                            color: ColorApp.colorprimary,fontSize: 19
                          ),),
                          cancelText: Text("Cancel",style: TextStyle(
                          fontSize: 19,

                            color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf
                          ),),
                          searchIcon: Icon(Icons.search,color: isDarkMode==true?ColorApp.colorwhite:ColorApp.colorblackgalf,),
                          backgroundColor:  isDarkMode == false
                              ? ColorApp.colorwhite
                              : Color(0xff787777),
                          buttonIcon: Icon(
                            Icons.arrow_downward_outlined,
                            color: isDarkMode == true
                                ? AppColors.colorwhite.withOpacity(0.69)
                                : Colors.grey,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isDarkMode == true
                                    ? Colors.white
                                    .withOpacity(0.3)
                                    : Colors.black54
                                    .withOpacity(0.3)
                            ),
                            color: isDarkMode == true
                                ? Color(0xff343434)
                                : Colors.white,
                          ),
                          key: _multiSelectKey,
                          initialChildSize: 0.7,
                          maxChildSize: 0.95,
                          title: Padding(
                            padding: EdgeInsets.only(left: s.width*0.06,
                                ),
                            child: Text("Search Skills",style: TextStyle(
                              color: isDarkMode == false
                                  ? ColorApp.colorblackgalf
                                  : ColorApp.colorbackground.withOpacity(0.7)
                            ),),
                          ),
                          buttonText: Text(
                            "Please Add Career releavent Skills",
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? AppColors.colorwhite.withOpacity(0.69)
                                    : Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                          items: _items,
                          searchable: true,
                          validator: (values) {
                            if (values == null || values.isEmpty) {
                              return "Required";
                            }
                            List names = values.map((e) => e!.title).toList();
                            if (names.contains("Frog")) {
                              return "Frogs are weird!";
                            }
                            return null;
                          },
                          onConfirm: (values) {
                            setState(() {
                              Map<String, dynamic> mapDataTest = {
                                // 'id': values['id'].toString(),
                                // 'title': values['title'].toString()
                              };
                              // subjectData.add(suggestion['id']);
                              dataTest.add(mapDataTest);
                              print(dataTest.toString() + "data test 123");
                              _selectedAnimals3 =
                              values as List<GetSkillModel?>;
                              print(_selectedAnimals3.toString() +
                                  'selecteddddddddddddddddddddddd');
                            });
                            _multiSelectKey.currentState!.validate();
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            onTap: (item) {
                              setState(() {
                                _selectedAnimals3.remove(item);
                              });
                              _multiSelectKey.currentState!.validate();
                            },
                          ),
                        ),
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
                      padding: EdgeInsets.only(left: 8, right: 10),
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
                    Consumer<PostJobSkill>(
                      builder: (context, val, child) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8, top: 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorApp.colorprimary,
                                borderRadius: BorderRadius.circular(6)),
                            height: s.height * 0.054,
                            width: s.width * 0.30,
                            child: GestureDetector(
                              onTap: () {
                                // if (skillSelected == null) {
                                //   openAlertBox(context);
                                // } else {
                                // Navigator.pop(context);
                                val.addJobSeekerSkills(
                                    _selectedAnimals3, context);
                                Timer(Duration(seconds: 2), () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Provider.of<GetJobSkillController>(context,
                                        listen: false)
                                        .skillListData
                                        .clear();
                                    Provider.of<GetJobSkillController>(context,
                                        listen: false)
                                        .jobSeekerSkill();
                                  });
                                  Get.back();
                                });
                                // showAlertDialog(context);
                              },
                              // },
                              child:  Center(
                                child:val.loadingAddSkill == false
                                    ? Text(
                                  "Add Skills",
                                  style: TextStyle(
                                      color: isDarkMode == false
                                          ? AppColors.colorwhite
                                          : Colors.white),
                                ): CircularProgressIndicator(),
                              )

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
        ));

  }


}
