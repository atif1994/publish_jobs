import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/color_app.dart';
import '../../utils/app_color.dart';
import '../../widgets/Textformfield_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/login_formfield_widget.dart';
import 'new_password_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

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
                          ? InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: s.height * 0.159,
                                  width: s.width * 0.40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(100)),
                                    color: ColorApp.colorblack,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 5, 20),
                                        child: Container(
                                            color: Colors.white,
                                            child: Icon(Icons.arrow_back_ios)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 20),
                                        child: Text(
                                          "Back",
                                          style: TextStyle(
                                            color: isDarkMode == true
                                                ? AppColors.colorwhite
                                                : AppColors.colordark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
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
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 0, 5, 20),
                                        child: Container(
                                            color: Colors.white,
                                            child: Icon(Icons.arrow_back_ios)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 20),
                                        child: Text(
                                          "Back",
                                          style: TextStyle(
                                            color: isDarkMode == true
                                                ? AppColors.colorwhite
                                                : AppColors.colordark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
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
                            "OTP Verfication",
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
                            "Please check your email we have sent you",
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Text(
                            "an OTP Number",
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
                          height: s.height * 0.02,
                        ),
                        Form(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: s.width * 0.11,
                                height: s.height * 0.05,
                                alignment: Alignment.center,
                                child: new TextFormField(
                                  onEditingComplete:() => FocusScope.of(context).nextFocus() ,
                                  textAlign: TextAlign.center,

                                  onChanged: (val) {
                                    if (val == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  decoration: InputDecoration(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
                                    border: Border(
                                        bottom: BorderSide(
                                  width: 2.0,
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite
                                      : AppColors.colordark,
                                ))),
                              ),
                              SizedBox(
                                width: s.width * 0.12,
                              ),
                              Container(
                                width: s.width * 0.11,
                                height: s.height * 0.05,
                                alignment: Alignment.center,
                                child: new TextFormField(
                                  onEditingComplete:() => FocusScope.of(context).nextFocus() ,
                                  textAlign: TextAlign.center,

                                  onChanged: (val) {
                                    if (val == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  decoration: InputDecoration(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
                                    border: Border(
                                        bottom: BorderSide(
                                  width: 2.0,
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite
                                      : AppColors.colordark,
                                ))),
                              ),
                              SizedBox(
                                width: s.width * 0.12,
                              ),
                              Container(
                                width: s.width * 0.11,
                                height: s.height * 0.05,
                                alignment: Alignment.center,
                                child: new TextFormField(
                                  onEditingComplete:() => FocusScope.of(context).nextFocus() ,
                                  textAlign: TextAlign.center,

                                  onChanged: (val) {
                                    if (val == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  decoration: InputDecoration(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
                                    border: Border(
                                        bottom: BorderSide(
                                  width: 2.0,
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite
                                      : AppColors.colordark,
                                ))),
                              ),
                              SizedBox(
                                width: s.width * 0.12,
                              ),
                              Container(
                                width: s.width * 0.11,
                                height: s.height * 0.05,
                                alignment: Alignment.center,
                                child: new TextFormField(
                                  onEditingComplete:() => FocusScope.of(context).nextFocus() ,
                                  textAlign: TextAlign.center,

                                  onChanged: (val) {
                                    if (val == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  decoration: InputDecoration(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
                                    border: Border(
                                        bottom: BorderSide(
                                  width: 2.0,
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite
                                      : AppColors.colordark,
                                ))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: s.height * 0.02,
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
                      padding: EdgeInsets.only(left: s.width * 0.08),
                      child: Text(
                        "Didn't you receive any OTP ?",
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
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
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
                  height: 15,
                ),
                SubmitButton(
                  widthButton: s.width * 0.9,
                  borderRadius: BorderRadius.circular(14),
                  textColor: isDarkMode == true
                      ? AppColors.colorwhite
                      : AppColors.colorwhite,
                  backGroundColor: ColorApp.colorprimary,
                  heightButton: s.height * 0.065,
                  textButton: 'Verify Now',
                  onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPassword()));
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
