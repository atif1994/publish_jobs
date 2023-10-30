import 'dart:convert';
import 'package:firstapp/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Home Post Apis/post_register_api_withsession_controller.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/profile_personal_info_model.dart';
import '../../utils/app_string.dart';

import '../../widgets/appbar_widget.dart';
import '../Login_screen/login_screen.dart';
import 'account_option.dart';

class DrawerScreen extends StatefulWidget {
  String? firstName;
  String? lastName;
  String? profileImage;
  String? profileCity;
  String? imageLink;
  String? email;
  String? mobile;

  DrawerScreen(
      {Key? key,
      this.firstName,
      this.lastName,
      this.profileImage,
      this.profileCity,
      this.email,
      this.mobile,
      this.imageLink})
      : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Future<ProfilePersonalInfoModel>? personalInfoFuture;

  String? mobile;
  List uesrCountryList = [];



  @override
  void initState() {

    checkIfLoggedin();
  }

  String? tokenHeader;


  checkIfLoggedin() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    tokenHeader = await pref.getString('tokenProvider').toString();
    setState(() {
      tokenHeader = tokenHeader;
    });
    if (tokenHeader.toString() == 'null') {}
  }

  @override
  Widget build(BuildContext context) {


    DataServices dataServices = DataServices();
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Container(
              color: isDarkMode == true ? Color(0xff343434) : Colors.white,
              width: s.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Container(
                        width: s.width * 0.07,
                        child: Image.asset('images/appLogo.png')),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: Container(
                              decoration: BoxDecoration(
                                color: isDarkMode == false
                                    ? Colors.white
                                    : ColorApp.colorblackgalf.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: s.width * 0.095,
                              height: s.height * 0.043,
                              child: Icon(
                                color: Colors.grey,
                                size: 18,
                                Icons.notification_add_outlined,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Container(
                              width: s.width * 0.095,
                              height: s.height * 0.048,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 1, color: Colors.white)),
                              child: CircleAvatar(
                                radius: 23,
                                backgroundImage: widget.profileImage
                                    .toString() !=
                                    'null'
                                    ? NetworkImage(
                                    'https://api.publish.jobs/pjcloud/userAccountImage/' +
                                        widget.profileImage!)
                                    : NetworkImage(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                                child: Text(""),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              decoration: new BoxDecoration(
                  color: isDarkMode == true ? Color(0xff343434) : Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0))),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, left: 12, right: 12, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder<ProfilePersonalInfoModel>(
                          future: personalInfoFuture,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundImage: widget.profileImage
                                                  .toString() !=
                                              'null'
                                          ? NetworkImage(
                                              'https://api.publish.jobs/pjcloud/userAccountImage/' +
                                                  widget.profileImage!)
                                          : NetworkImage(
                                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                                      child: Text(""),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (widget.firstName == 'null'
                                                ? ''
                                                : widget.firstName.toString() +
                                                    " ") +
                                            (widget.lastName == 'null'
                                                ? ''
                                                : widget.lastName.toString() +
                                                    " "),
                                        style: TextStyle(
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : AppColors.colordark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    widget.email ?? ''.toString(),
                                    style: TextStyle(
                                      color: isDarkMode == true
                                          ? Colors.white
                                          : AppColors.colordark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 1, color: Colors.white)),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: AppColors.colorgray,
                                      backgroundImage: widget.profileImage
                                                  .toString() !=
                                              'null'
                                          ? NetworkImage(
                                              'https://api.publish.jobs/pjcloud/userAccountImage/' +
                                                  widget.profileImage!)
                                          : NetworkImage(
                                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.firstName ??
                                            '' +
                                                " " +
                                                (widget.lastName ?? '')
                                                    .toString(),
                                        style: TextStyle(
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : AppColors.colordark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(snapshot.data!.email.toString())
                                ],
                              );
                            }
                          }),
                      SizedBox(
                        height: s.height * 0.025,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (tokenHeader == "null") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LogInScreen(checkNav: 'profile')));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountOption(mobile:widget.mobile,email: widget.email,firstName: widget.firstName,lastName: widget.lastName,profileImage: widget.profileImage,)));
                          }
                        },
                        child: Material(
                          color: isDarkMode == false
                              ? ColorApp.colorwhite.withOpacity(0.5)
                              : ColorApp.colorblackgalf.withOpacity(0.6),
                          elevation: 1,
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            width: s.width * 0.52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  AppString.manageYourAccount,
                                  style: TextStyle(
                                      color: isDarkMode == true
                                          ? Colors.white
                                          : AppColors.colordark),
                                  // style: TextStyle(color: AppColors.colorpurpal),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.045,
                      ),
                      Container(
                        height: 1,
                        width: s.width,
                        decoration: BoxDecoration(
                          color: isDarkMode == true
                              ? ColorApp.colorbackground.withOpacity(0.4)
                              : AppColors.colordark.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.dashboard_outlined,
                              color: isDarkMode == true
                                  ? Colors.white
                                  : AppColors.colordark,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                AppString.yourData,
                                style: TextStyle(
                                    color: isDarkMode == true
                                        ? Colors.white
                                        : AppColors.colordark),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings_applications_outlined,
                              color: isDarkMode == true
                                  ? Colors.white
                                  : AppColors.colordark,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                AppString.setting,
                                style: TextStyle(
                                    color: isDarkMode == true
                                        ? Colors.white
                                        : AppColors.colordark),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.feedback_outlined,
                              color: isDarkMode == true
                                  ? Colors.white
                                  : AppColors.colordark,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                AppString.helpAndFeedback,
                                style: TextStyle(
                                    color: isDarkMode == true
                                        ? Colors.white
                                        : AppColors.colordark),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      if (tokenHeader != 'null') ...[
                        Consumer<PostRegisterApiWithSessionController>(
                            builder: (context, val, child) {
                          return Padding(
                            padding: EdgeInsets.only(top: s.height * 0.3),
                            child: Column(
                              children: [
                                Container(
                                  height: 1,
                                  width: s.width,
                                  decoration: BoxDecoration(
                                    color: isDarkMode == true
                                        ? ColorApp.colorbackground
                                            .withOpacity(0.4)
                                        : AppColors.colordark.withOpacity(0.5),
                                  ),
                                ),
                                SizedBox(
                                  height: s.height * 0.03,
                                ),
                                Row(
                                  children: [
                                    Material(
                                      color: isDarkMode == false
                                          ? const Color(0xffF0F2F5)
                                          : const Color(0xff181818),
                                      child: InkWell(
                                        highlightColor: Colors.blue,
                                        onTap: () {
                                          // PostRegisterApiWithSessionController()
                                          //     .logoutAPI(context);
                                          Provider.of<PostRegisterApiWithSessionController>(
                                                  context,
                                                  listen: false)
                                              .logoutAPI(context);
                                        },
                                        child: Ink(
                                          color: isDarkMode == false
                                              ? const Color(0xffF0F2F5)
                                              : const Color(0xff181818),
                                          child: Icon(
                                            Icons.logout,
                                            color: isDarkMode == true
                                                ? Colors.white
                                                : AppColors.colordark,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: isDarkMode == false
                                          ? const Color(0xffF0F2F5)
                                          : const Color(0xff181818),
                                      child: InkWell(
                                        highlightColor: Colors.blue,
                                        onTap: () {
                                          // PostRegisterApiWithSessionController()
                                          //     .logoutAPI(context);
                                          Provider.of<PostRegisterApiWithSessionController>(
                                                  context,
                                                  listen: false)
                                              .logoutAPI(context);
                                        },
                                        child: Ink(
                                          color: isDarkMode == false
                                              ? const Color(0xffF0F2F5)
                                              : const Color(0xff181818),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: val.loading
                                                ? const CircularProgressIndicator()
                                                : Text(
                                                    AppString.signOut,
                                                    style: TextStyle(
                                                        color:
                                                            isDarkMode == true
                                                                ? Colors.white
                                                                : AppColors
                                                                    .colordark),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        })
                      ] else ...[
                        Padding(
                          padding: EdgeInsets.only(top: s.height * 0.3),
                          child: Column(
                            children: [
                              Container(
                                height: 1,
                                width: s.width,
                                decoration: BoxDecoration(
                                  color: isDarkMode == true
                                      ? ColorApp.colorbackground
                                          .withOpacity(0.4)
                                      : AppColors.colordark.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                height: s.height * 0.03,
                              ),
                              Row(
                                children: [
                                  Material(
                                    child: InkWell(
                                      highlightColor: Colors.blue,
                                      onTap: () {
                                        PostRegisterApiWithSessionController()
                                            .logoutAPI(context);
                                      },
                                      child: Ink(
                                        color: isDarkMode == false
                                            ? const Color(0xffF0F2F5)
                                            : const Color(0xff181818),
                                        child: Icon(
                                          Icons.login,
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : AppColors.colordark,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: isDarkMode == false
                                        ? const Color(0xffF0F2F5)
                                        : const Color(0xff181818),
                                    child: InkWell(
                                      highlightColor: Colors.blue,
                                      onTap: () {
                                        Get.to(LogInScreen(checkNav: 'drawer'));
                                      },
                                      child: Ink(
                                        color: isDarkMode == false
                                            ? const Color(0xffF0F2F5)
                                            : const Color(0xff181818),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Login ',
                                            style: TextStyle(
                                                color: isDarkMode == true
                                                    ? Colors.white
                                                    : AppColors.colordark),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
