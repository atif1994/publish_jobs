import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'dart:convert';

import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

import '../../../App Services/api_services_provider.dart';

import '../../../utils/app_color.dart';
import '../../../utils/constants.dart';
import '../../Network Controller/Home Post Apis/post_register_api_withsession_controller.dart';
import '../../constants/color_app.dart';

import '../../widgets/Textformfield_widget.dart';
import '../../widgets/login_formfield_widget.dart';
import '../../widgets/loginerror.dart';
import 'forgotpassword_screen.dart';

class LogInScreen extends StatefulWidget {
  final String checkNav;

  const LogInScreen({Key? key, required this.checkNav}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailControllerlog = TextEditingController();
  TextEditingController passwordControllerlog = TextEditingController();
  bool _obscureText = true;
  bool emailc = true;
  bool passwordc = false;
  String Id = '';
  var emailCheckData;
  String password = '';
  String? email = '';
  final _formGlobalKey = GlobalKey<FormState>();
  bool isAppbar = true;
  bool createaccount = true;
  bool login = true;
  bool isShowCheckEmail = false;
  bool isShowCheckPassword = false;
  late String textEmail;
  bool emailCheckLoading = false;
  bool showPasswordErrorMessage = false;
  var confirmPass;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Now the context is available.
    //   Provider.of<PostRegisterApiWithSessionController>(context, listen: false);
    //
    //
    // });

  }
  @override
  Widget build(BuildContext context) {
    Provider.of<PostRegisterApiWithSessionController>(context, listen: false);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar:    Row(
            children: [
              Container(
                height: s.height * 0.1,
                width: s.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(130)),
                  color: ColorApp.colorprimary,
                ),
                child: const Center(
                  child: const Text(
                    "",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                  color:isDarkMode==true?ColorApp.colorblack: Colors.white,
                  width: s.width*0.04,

                  child: const Text("")),
            ],
          ),
      backgroundColor: isDarkMode == true ? ColorApp.colorblack : Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formGlobalKey,
          child: Column(
            children: [
              Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isDarkMode == true
                            ? Container(
                                height: s.height * 0.120,
                                width: s.width * 0.49,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: const Radius.circular(100)),
                                  color: ColorApp.colorblack,
                                ),
                                child: const Text(""))
                            : Container(
                                height: s.height * 0.150,
                                width: s.width * 0.49,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: const Radius.circular(100)),
                                  color: ColorApp.colorwhite,
                                ),
                                child: const Text("")),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (Context) => const LogInScreen(
                                          checkNav: 'login',
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 39),
                            child: Container(
                              height: s.height * 0.1,
                              width: s.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(130)),
                                color: ColorApp.colorprimary,
                              ),
                              child: const Center(
                                child: const Text(
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                        width: s.width * 0.40,
                        child: Image.asset("images/abc.png")),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Welcome to",
                                  style: TextStyle(
                                    color: isDarkMode == true
                                        ? ColorApp.colorwhite
                                        : ColorApp.colorblackgalf,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                                Text(
                                  " Publish Jobs!",
                                  style: TextStyle(
                                    color: isDarkMode == true
                                        ? ColorApp.colorprimary
                                        : ColorApp.colorprimary,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                  ),
                                ),

                              ],
                            ),
                          ),
                          if ((createaccount == true)) ...[
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    "Sign in to continue to Publish Jobs ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Montserrat",
                                        fontSize: 14,
                                        color: isDarkMode == true
                                            ? ColorApp.colorwhite
                                            : ColorApp.colorblackgalf),
                                  ),
                                ),

                                const SizedBox(height: 12,)
                              ],
                            )
                          ]else...[
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    "Create Your Publish Jobs account to continue",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Montserrat",
                                        fontSize: 14,
                                        color: isDarkMode == true
                                            ? ColorApp.colorwhite
                                            : ColorApp.colorblackgalf),
                                  ),
                                ),

                                const SizedBox(height: 12,)
                              ],
                            )
                          ]
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                      visible: emailc,
                      child: Column(
                        children: [
                          LogInFormForm(
                            hintText: "Please Enter your Email",
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: isDarkMode == true
                                  ? FocusScope.of(context).isFirstFocus
                                      ? ColorApp.colorwhite
                                      : AppColors.colorprimary
                                  : FocusScope.of(context).isFirstFocus
                                      ? AppColors.colorblack
                                      : AppColors.colorprimary,
                            ),
                            onChange: (val) {
                              email = val;
                            },
                            onValidate: emailCheckData == 'false'
                                ? (val) {
                                    return 'Please enter valid email';
                                  }
                                : Constants.emailValidator,
                            controller: emailControllerlog,
                          ),
                          SizedBox(
                            height: s.height * 0.029,
                          ),
                          Visibility(
                              visible: isShowCheckEmail,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red[50],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                     // height: s.height * 0.13,
                                      width: s.width * 0.99,
                                      child: Column(
                                        children: [
                                          const Icon(Icons.error_outline),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Sorry we Couldn't find an account with",
                                                style: TextStyle(
                                                  color:
                                                      ColorApp.colorblackgalf,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                "that email address. Can we help you to",
                                                style: TextStyle(
                                                  color:
                                                      ColorApp.colorblackgalf,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 1),
                                                child: Text(
                                                  "recover your email?",
                                                  style: TextStyle(
                                                    color:
                                                        ColorApp.colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 12,
                          ),
                          Consumer<DataServices>(
                            builder: (context, val, child) {
                              return SizedBox(
                                height: s.height * 0.056,
                                width: s.width * 0.89,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (_formGlobalKey.currentState!
                                        .validate()) {
                                      // val.checkEmail(emailControllerlog.text);
                                      setState(() {
                                        emailCheckLoading = true;
                                      });
                                      // SharedPreferences pref = await SharedPreferences.getInstance();
                                      // String tokenHeader = await pref.getString('tokenProvider').toString();
                                      var data;

                                      try {
                                        String url =
                                            "https://api.publish.jobs/api/checkEmail?email=$emailControllerlog";
                                        Response response = await post(
                                          Uri.parse(url),
                                          body: {
                                            'email': emailControllerlog.text,
                                          },
                                          //headers: requestHeaders
                                        );
                                        data = jsonDecode(
                                            response.body.toString());
                                        setState(() {
                                          if (data['emailCheck'] == true) {
                                            emailCheckData = 'true';
                                            print(emailCheckData.toString());
                                          } else if (data['emailCheck'] ==
                                              false) {
                                            emailCheckData = 'flase';
                                            print(emailCheckData.toString());
                                          }
                                          emailCheckLoading = false;
                                        });
                                      } catch (e) {
                                        setState(() {
                                          emailCheckLoading = false;
                                        });
                                        print(e.toString());
                                      }
                                      setState(() {
                                        if (emailc == true) {
                                          setState(() {
                                            if (createaccount == true) {
                                              if (emailCheckData == 'flase') {
                                                // emailc = false;
                                                // passwordc = true;
                                                isShowCheckEmail = true;
                                              } else if (emailCheckData ==
                                                  'true') {
                                                emailc = false;
                                                passwordc = true;
                                                isShowCheckEmail = false;
                                              }
                                            } else if (createaccount == false) {
                                              emailc = false;
                                              passwordc = true;
                                              isShowCheckEmail = false;
                                            }
                                          });
                                        }

                                      });
                                    }
                                  },
                                  child: Container(
                                      height: s.height * 0.056,
                                      width: s.width * 0.89,
                                      decoration: BoxDecoration(
                                          color: isDarkMode == true
                                              ? AppColors.colorprimary
                                              : AppColors.colorprimary,
                                          // border: Border.all(width: 1, color: AppColors.colorprimary),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: const EdgeInsets.all(6),
                                      child: Center(
                                          child: emailCheckLoading == false
                                              ? Text(
                                                  textAlign: TextAlign.center,
                                                  "Next",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: isDarkMode == true
                                                          ? AppColors.colorwhite
                                                          : AppColors
                                                              .colorwhite),
                                                )
                                              : const CircularProgressIndicator())),
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                  Visibility(
                      visible: passwordc,
                      child: Column(
                        children: [
                          if ((createaccount == false)) ...[
                            Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: ColorApp.colorprimary
                                            .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: s.height * 0.05,
                                    width: s.width * 0.7,
                                    child: Center(
                                        child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorApp.colorprimary
                                                .withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        contentPadding: const EdgeInsets.only(top: 6),
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: isDarkMode == true
                                              ? FocusScope.of(context)
                                                      .isFirstFocus
                                                  ? ColorApp.colorwhite
                                                  : AppColors.colorprimary
                                              : FocusScope.of(context)
                                                      .isFirstFocus
                                                  ? AppColors.colorblack
                                                  : AppColors.colorprimary,
                                        ),
                                      ),
                                      style: TextStyle(
                                          color: ColorApp.colorprimary),
                                      initialValue: emailControllerlog.text,
                                    ))),
                                const SizedBox(
                                  height: 10,
                                ),
                                LogInFormForm(
                                  onValidate: (value) {
                                    confirmPass = value;
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Password';
                                    }
                                  },
                                  obsecure: _obscureText,
                                  hintText: "Please Enter your Pasword",
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: isDarkMode == true
                                        ? FocusScope.of(context).isFirstFocus
                                            ? ColorApp.colorwhite
                                            : AppColors.colorprimary
                                        : FocusScope.of(context).isFirstFocus
                                            ? AppColors.colorblack
                                            : AppColors.colorprimary,
                                  ),
                                  controller: passwordControllerlog,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: isDarkMode == true
                                          ? AppColors.colorwhite
                                          : AppColors.colorpurpal,
                                    ),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                LogInFormForm(
                                  onValidate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Confirm your Password';
                                    } else if (value != confirmPass) {
                                      return "Password must be same as above";
                                    }
                                  },
                                  obsecure: _obscureText,
                                  hintText: "Please Confirm your Password",
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: isDarkMode == true
                                        ? FocusScope.of(context).isFirstFocus
                                            ? ColorApp.colorwhite
                                            : AppColors.colorprimary
                                        : FocusScope.of(context).isFirstFocus
                                            ? AppColors.colorblack
                                            : AppColors.colorprimary,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                if (showPasswordErrorMessage == true) ...[
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: s.width * 0.076,
                                            top: 12,
                                            right: s.width * 0.076),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: ColorApp.colorerror
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                BorderRadius.circular(12)),
                                            width: s.width,
                                          //  height: s.height * 0.12,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(top: 3),
                                                  child: Icon(
                                                    Icons.error_outline,
                                                    size: 29,
                                                    color: ColorApp.colorblackgalf,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: s.height * 0.01, right: 5),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Sorry we could not found an account with that',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      const Text(
                                                        'email address.we can help you to recover ',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      const Text(
                                                        'Your email?',
                                                        style: const TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(
                                  height: 2,
                                ),
                                Consumer<PostRegisterApiWithSessionController>(
                                  builder: (context, val, child) {
                                    return emailCheckData == 'true'
                                        ? SizedBox(
                                      height: s.height * 0.056,
                                      width: s.width * 0.89,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (_formGlobalKey.currentState!
                                              .validate()) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Provider.of<
                                                  PostRegisterApiWithSessionController>(
                                                  context,
                                                  listen: false);
                                            });
                                            var deviceIdd = const Uuid();
                                            setState(() {
                                              // isShowCheckPassword=true;
                                              // idData = deviceIdd.v5(Uuid.NAMESPACE_URL, emailController.toString());
                                              Id = deviceIdd.v5(
                                                  Uuid.NAMESPACE_URL,
                                                  emailControllerlog.text);
                                            });
                                            val.logInApiWithSession(
                                                emailControllerlog.text,
                                                passwordControllerlog.text,
                                                Id,
                                                context,
                                                widget.checkNav);
                                            if (Provider.of<PostRegisterApiWithSessionController>(
                                                context,
                                                listen: false)
                                                .incurrectPassword ==
                                                'The provided credentials are incorrect.') {
                                              setState(() {
                                                showPasswordErrorMessage = true;
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              showPasswordErrorMessage = false;
                                            });
                                          }
                                        },
                                        child: Container(
                                            height: s.height * 0.056,
                                            width: s.width * 0.89,
                                            decoration: BoxDecoration(
                                                color: isDarkMode == true
                                                    ? ColorApp.colorprimary
                                                    : ColorApp.colorprimary,
                                                // border: Border.all(width: 1, color: AppColors.colorprimary),
                                                borderRadius:
                                                BorderRadius.circular(12)),
                                            padding: const EdgeInsets.all(6),
                                            child: Center(
                                                child: val.loading == false
                                                    ? Text(
                                                  textAlign:
                                                  TextAlign.center,
                                                  "Create Account",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: isDarkMode ==
                                                          true
                                                          ? AppColors
                                                          .colorwhite
                                                          : AppColors
                                                          .colorwhite),
                                                )
                                                    : const CircularProgressIndicator(
                                                    strokeWidth: 2))),
                                      ),
                                    )
                                        : SizedBox(
                                      height: s.height * 0.056,
                                      width: s.width * 0.89,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (_formGlobalKey.currentState!
                                              .validate()) {
                                            var deviceIdd = const Uuid();
                                            setState(() {
                                              // idData = deviceIdd.v5(Uuid.NAMESPACE_URL, emailController.toString());
                                              Id = deviceIdd.v5(
                                                  Uuid.NAMESPACE_URL,
                                                  emailControllerlog.text);
                                            });
                                            val.registerApiWithSession(
                                                emailControllerlog.text,
                                                passwordControllerlog.text,
                                                Id,
                                                context,
                                                widget.checkNav);
                                          }
                                        },
                                        child: Container(
                                            height: s.height * 0.056,
                                            width: s.width * 0.89,
                                            decoration: BoxDecoration(
                                                color: isDarkMode == true
                                                    ? ColorApp.colorprimary
                                                    : ColorApp.colorprimary,
                                                // border: Border.all(width: 1, color: AppColors.colorprimary),
                                                borderRadius:
                                                BorderRadius.circular(8)),
                                            padding: const EdgeInsets.all(6),
                                            child: Center(
                                                child: val.loading == false
                                                    ? Text(
                                                  textAlign:
                                                  TextAlign.center,
                                                  "Signup Now",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: isDarkMode ==
                                                          true
                                                          ? AppColors
                                                          .colorwhite
                                                          : AppColors
                                                          .colorwhite),
                                                )
                                                    : const Padding(
                                                  padding:
                                                  EdgeInsets
                                                      .all(8.0),
                                                  child:
                                                  const CircularProgressIndicator(),
                                                ))),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                          ] else ...[

                            Padding(
                              padding: EdgeInsets.only(right: s.width * 0.08),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgotPasswordScreen()));
                                    },
                                    child: Text(
                                      'Forgot Password ?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: isDarkMode == true
                                            ? ColorApp.colorprimary
                                            : ColorApp.colorprimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            LogInFormForm(
                              onValidate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Password';
                                }
                              },
                              obsecure: _obscureText,
                              hintText: "Please Enter your Pasword",
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: isDarkMode == true
                                    ? FocusScope.of(context).isFirstFocus
                                        ? ColorApp.colorwhite
                                        : AppColors.colorprimary
                                    : FocusScope.of(context).isFirstFocus
                                        ? AppColors.colorblack
                                        : AppColors.colorprimary,
                              ),
                              controller: passwordControllerlog,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: isDarkMode == true
                                      ? AppColors.colorwhite
                                      : AppColors.colorpurpal,
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),

                            if (showPasswordErrorMessage == true) ...[
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: s.width * 0.076,
                                        top: 12,
                                        right: s.width * 0.076),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorApp.colorerror
                                                .withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(12)),
                                        width: s.width,
                                       // height: s.height * 0.12,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(top: 3),
                                              child: Icon(
                                                Icons.error_outline,
                                                size: 29,
                                                color: ColorApp.colorblackgalf,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: s.height * 0.01, right: 5),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'Sorry we could not found an account with that',
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  const Text(
                                                    'email address.we can help you to recover ',
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  const Text(
                                                    'Your email?',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(
                              height: 25,
                            ),
                            Consumer<PostRegisterApiWithSessionController>(
                              builder: (context, val, child) {
                                return emailCheckData == 'true'
                                    ? SizedBox(
                                  height: s.height * 0.056,
                                  width: s.width * 0.89,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_formGlobalKey.currentState!
                                          .validate()) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          Provider.of<
                                              PostRegisterApiWithSessionController>(
                                              context,
                                              listen: false);
                                        });
                                        var deviceIdd = const Uuid();
                                        setState(() {
                                          // isShowCheckPassword=true;
                                          // idData = deviceIdd.v5(Uuid.NAMESPACE_URL, emailController.toString());
                                          Id = deviceIdd.v5(
                                              Uuid.NAMESPACE_URL,
                                              emailControllerlog.text);
                                        });
                                        val.logInApiWithSession(
                                            emailControllerlog.text,
                                            passwordControllerlog.text,
                                            Id,
                                            context,
                                            widget.checkNav);
                                  Timer.periodic(Duration(seconds: 1), (timer) {
                                    if (
                                    val.incurrectPassword ==
                                        'The provided credentials are incorrect.') {
                                      setState(() {
                                        print('incurrect password message');
                                        showPasswordErrorMessage = true;
                                      });
                                    }
                                  });
                                      } else {
                                        setState(() {
                                          print('currect password message');
                                          showPasswordErrorMessage = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                        height: s.height * 0.056,
                                        width: s.width * 0.89,
                                        decoration: BoxDecoration(
                                            color: isDarkMode == true
                                                ? ColorApp.colorprimary
                                                : ColorApp.colorprimary,
                                            // border: Border.all(width: 1, color: AppColors.colorprimary),
                                            borderRadius:
                                            BorderRadius.circular(12)),
                                        padding: const EdgeInsets.all(6),
                                        child: Center(
                                            child: val.loading == false
                                                ? Text(
                                              textAlign:
                                              TextAlign.center,
                                              "Sign in",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: isDarkMode ==
                                                      true
                                                      ? AppColors
                                                      .colorwhite
                                                      : AppColors
                                                      .colorwhite),
                                            )
                                                : const CircularProgressIndicator(
                                                strokeWidth: 2))),
                                  ),
                                )
                                    : SizedBox(
                                  height: s.height * 0.056,
                                  width: s.width * 0.89,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_formGlobalKey.currentState!
                                          .validate()) {
                                        var deviceIdd = const Uuid();
                                        setState(() {
                                          // idData = deviceIdd.v5(Uuid.NAMESPACE_URL, emailController.toString());
                                          Id = deviceIdd.v5(
                                              Uuid.NAMESPACE_URL,
                                              emailControllerlog.text);
                                        });
                                        val.registerApiWithSession(
                                            emailControllerlog.text,
                                            passwordControllerlog.text,
                                            Id,
                                            context,
                                            widget.checkNav);
                                      }
                                    },
                                    child: Container(
                                        height: s.height * 0.056,
                                        width: s.width * 0.89,
                                        decoration: BoxDecoration(
                                            color: isDarkMode == true
                                                ? ColorApp.colorprimary
                                                : ColorApp.colorprimary,
                                            // border: Border.all(width: 1, color: AppColors.colorprimary),
                                            borderRadius:
                                            BorderRadius.circular(8)),
                                        padding: const EdgeInsets.all(6),
                                        child: Center(
                                            child: val.loading == false
                                                ? Text(
                                              textAlign:
                                              TextAlign.center,
                                              "SignUp Now",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: isDarkMode ==
                                                      true
                                                      ? AppColors
                                                      .colorwhite
                                                      : AppColors
                                                      .colorwhite),
                                            )
                                                : const Padding(
                                              padding:
                                              EdgeInsets
                                                  .all(8.0),
                                              child:
                                              const CircularProgressIndicator(),
                                            ))),
                                  ),
                                );
                              },
                            ),
                          ],


                        ],
                      )),

                  Padding(
                    padding: EdgeInsets.only(right: s.width * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  emailc = true;
                                  passwordc = false;
                                });
                              },
                              child: Container(
                                child: createaccount == false
                                    ? Text(
                                        "Already have an account?",
                                        style: TextStyle(
                                            color: isDarkMode == true
                                                ? AppColors.colorwhite
                                                : AppColors.colorhalfgray,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      )
                                    : Text(
                                        "New on our Platform?",
                                        style: TextStyle(
                                            color: isDarkMode == true
                                                ? AppColors.colorwhite
                                                : AppColors.colorhalfgray,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      //login = false;
                                      createaccount = !createaccount;
                                      emailc = true;
                                      passwordc = false;
                                      isShowCheckEmail = false;
                                      // passwordc = false;
                                      //emailc = true;
                                    });
                                  },
                                  child: createaccount == false
                                      ? Text(
                                          "Sign in",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode == true
                                                  ? ColorApp.colorprimary
                                                  : ColorApp.colorprimary),
                                        )
                                      : Text(
                                          "Create account",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode == true
                                                  ? ColorApp.colorprimary
                                                  : ColorApp.colorprimary),
                                        )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: EdgeInsets.only(top: s.height * 0.19),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Container(
              //               height: s.height * 0.14,
              //               width: s.width * 0.15,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.only(
              //                     topRight: Radius.circular(120),
              //                     bottomRight: Radius.circular(120)),
              //                 color: ColorApp.colorprimary,
              //               ),
              //               child: Center(
              //                 child: Text(""),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    ));
  }

}
