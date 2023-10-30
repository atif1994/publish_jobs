import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Network Controller/General Controllers/forgot_password_controller.dart';
import '../../constants/color_app.dart';
import '../../utils/app_color.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/login_formfield_widget.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController newPasswordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor:
        isDarkMode == true ? ColorApp.colorblack : Colors.white,
        body: Column(
          children: [
            Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDarkMode == true
                          ? Container(
                          height: s.height * 0.159,
                          width: s.width * 0.40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(100)),
                            color: ColorApp.colorblack,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16, 0, 5, 20),
                                  child: Container(
                                      color: Colors.white,
                                      child: Icon(Icons.arrow_back_ios)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 0, 5, 20),
                                    child: Text(
                                      "Back",
                                      style: TextStyle(
                                          color: isDarkMode == true
                                              ? AppColors.colorwhite
                                              : AppColors.colordark),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                          : Container(
                          height: s.height * 0.159,
                          width: s.width * 0.40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(100)),
                            color: ColorApp.colorgray,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(12, 0, 5, 20),
                                child: Container(
                                    color: Colors.white,
                                    child: Icon(Icons.arrow_back_ios)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 0, 5, 20),
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? AppColors.colorwhite
                                            : AppColors.colordark),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 45),
                          child: Container(
                            height: s.height * 0.1,
                            width: s.width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(130)),
                              color: ColorApp.colorprimary,
                            ),
                            child: Center(
                              child: Text(
                                "",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Container(
                              width: s.width * 0.30,
                              child: Image.asset("images/abc.png")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            "New Password Enter",
                            style: TextStyle(
                              color: isDarkMode == true
                                  ? ColorApp.colorprimary
                                  : ColorApp.colorprimary,
                              fontSize: 29,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Enter your password",
                            style: TextStyle(
                              fontSize: 15,
                              color: isDarkMode == true
                                  ? AppColors.colorwhite
                                  : AppColors.colorblack,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        LogInFormForm(
                          obsecure: true,
                          hintText: 'Please Enter new password',
                          prefixIcon: Icon(Icons.email_outlined),
                          controller: newPasswordController,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: s.width * 0.08,
                      ),
                      child: Text(
                        "Remember Password ?",
                        style: TextStyle(
                          fontSize: 13,
                          color: isDarkMode == true
                              ? AppColors.colorwhite
                              : AppColors.colorblack,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 9,
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 15,
                          color: isDarkMode == true
                              ? AppColors.colorprimary
                              : AppColors.colorprimary,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<ForgotPasswordController>(
                  builder: (BuildContext context, value, Widget? child) {
                    return SubmitButton(
                      loading: value.forgotLoading,
                      widthButton: s.width * 0.9,
                      borderRadius: BorderRadius.circular(12),
                      textColor: isDarkMode == true
                          ? AppColors.colorwhite
                          : AppColors.colorwhite,
                      backGroundColor: ColorApp.colorprimary,
                      heightButton: s.height * 0.065,
                      textButton: 'logIn Screen',
                      onPressed: () {

                      },
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
