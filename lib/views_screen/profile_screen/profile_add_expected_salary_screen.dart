import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../App Services/api_services_provider.dart';
import '../../App Services/global_vars.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobSeekercareer_apply_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_salary_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_salary_type_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post__jobseekerAddExpectedSalary.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/expacted_salary_model.dart';
import '../../model/job_seeker_career_level_model.dart';
import '../../utils/app_color.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/profilefoemfield_widget.dart';
import 'package:http/http.dart' as http;

class AddSalary extends StatefulWidget {
  String? id;
  String? currency;
  String? paymentFreguency;
  String? pay;

  AddSalary({Key? key, this.currency, this.paymentFreguency, this.pay, this.id})
      : super(key: key);

  @override
  State<AddSalary> createState() => _AddSalaryState();
}

class _AddSalaryState extends State<AddSalary> {
  String currencyCode = '';
  String currencyid = '';

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
          currencyCode =
              (data['country_option'][0]['currency'][0]['currency_code']);
          currencyid =
              (data['country_option'][0]['currency'][0]['id']).toString();
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
    print(requestHeaders.toString() + " " + "show header");
    var resBody = json.decode(res.body);
    setState(() {
      CareerLevelListData = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  String? salaryTypeId;
  List careerLevelList = ['Entry Level'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCountryList();
    getProfilePersonalInfo();
    //this.postCityList();
  }

  String? _dropdownError;

  validateForm(String? validationValue) {
    bool _isValid = formKey.currentState!.validate();

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

  String? currencyshow;

  bool isAppbar = true;
  String? careerLevelSelection;
  TextEditingController desiredPayController = TextEditingController();

  GetSalaryTypeController salleryConroller = GetSalaryTypeController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(currencyCode.toString()+"show data");
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AppBar(
        actions: [],
        elevation: 0,
        backgroundColor: isDarkMode == false
            ? ColorApp.colorblackgalf.withOpacity(0.7)
            : Color(0xff787777).withOpacity(0.7),
        automaticallyImplyLeading: false,
        title: Text(
          ' Add Salary',
          style: TextStyle(
              color: isDarkMode == false
                  ? ColorApp.colorblack.withOpacity(0.6)
                  : ColorApp.colorbackground.withOpacity(0.69)),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
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
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                    left: 8,
                                    right: 8,
                                    top: 8,
                                    bottom: s.height * 0.04),
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
                                              : ColorApp.colorblack,
                                          elevation: 1,
                                          isExpanded: true,
                                          underline: Container(
                                            color: AppColors.colorblue,
                                          ),
                                          hint: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Monthly",
                                              style: TextStyle(
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite
                                                          .withOpacity(0.69)
                                                      : Colors.grey),
                                            ),
                                          ),
                                          value: careerLevelSelection,
                                          onChanged: (v) {


                                            int? countryIndex;
                                            int index =
                                                CareerLevelListData.indexWhere(
                                                    (item) =>
                                                        item["title"] == v);
                                            setState(() {
                                              _dropdownError = null;
                                              careerLevelSelection =
                                                  v as String;
                                              countryIndex =
                                                  CareerLevelListData.indexOf(
                                                      v);
                                              //countryId = (index!+1).toString();
                                              for (var i = 0;
                                                  i < arrayLengh;
                                                  i++) {
                                                if (snapshot.data![i].title ==
                                                    v) {
                                                  salaryTypeId = snapshot
                                                      .data![i].id
                                                      .toString();
                                                  print(
                                                      salaryTypeId.toString() +
                                                          'Career Level ID');
                                                }
                                              }
                                            });
                                          },
                                          items: CareerLevelListData.map((v) {
                                            return DropdownMenuItem(
                                              value: v['title'],
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: s.width * 0.04,
                                                    top: 5,
                                                    bottom: 4),
                                                child: Text(
                                                  v['title'],
                                                  style: TextStyle(
                                                      color: isDarkMode == true
                                                          ? AppColors.colorwhite
                                                              .withOpacity(0.69)
                                                          : Colors.black87
                                                              .withOpacity(
                                                                  0.68)),
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
                                    _dropdownError == null
                                        ? SizedBox.shrink()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, top: 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _dropdownError ?? "",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ),
                                    TextFormField(
                                      controller: desiredPayController,
                                      // initialValue:
                                      //     widget.paymentFreguency.toString(),

                                      validator: (formattedDate) {
                                        if (formattedDate!.isEmpty ||
                                            formattedDate == null) {
                                          return 'Please enter Desired pay';
                                        }
                                      },
                                      style: TextStyle(
                                          color: isDarkMode == true
                                              ? AppColors.colorwhite
                                                  .withOpacity(0.69)
                                              : Colors.black87.withOpacity(0.7),
                                          fontSize: 16),

                                      //editing controller of this TextField
                                      // initialValue: startDateData,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorApp.colorprimary),
                                        ),
                                        filled: true,
                                        fillColor: isDarkMode == true
                                            ? Color(0xff343434)
                                            : Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: isDarkMode == true
                                                    ? Colors.white
                                                        .withOpacity(0.3)
                                                    : Colors.black54
                                                        .withOpacity(0.3))),
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
                                                    : Colors.black87
                                                        .withOpacity(0.7)),
                                          ),
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: isDarkMode == true
                                                ? AppColors.colorwhite
                                                    .withOpacity(0.69)
                                                : Colors.grey,
                                            fontWeight: FontWeight.w300),
                                        contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            top: 13.0,
                                            bottom: 13.0,
                                            right: 10),
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                      ),

                                      //set it true, so that user will not able to edit text
                                    ),
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
                                      splashColor: AppColors.colorindigo
                                          .withOpacity(0.8),
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          validateForm(salaryTypeId);
                                          val.jobAddSalary(
                                              '',
                                              currencyid.toString(),
                                              salaryTypeId.toString(),
                                              desiredPayController.text,
                                              context);
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
                                        }


                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Bar(id: 2,)));
                                      },
                                      child: Container(
                                          height: s.height * 0.05,
                                          width: s.width * 0.39,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Center(
                                            child: val.addSalaryLoading == false
                                                ? Text(
                                                    "Save Changes",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            isDarkMode == false
                                                                ? AppColors
                                                                    .colorwhite
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
      ),
    );
  }
}
