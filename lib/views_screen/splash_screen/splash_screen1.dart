import 'dart:async';

import 'package:firstapp/views_screen/splash_screen/splash_screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/color_app.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          SplashScreen2()), (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
        backgroundColor:
        isDarkMode == true ? Colors.black : Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('images/abc.png', width: 150),
            ),
            Center(child: Text("Publish Jobs",style: TextStyle(
              color:  isDarkMode == true ? Colors.white : ColorApp.colorprimary,
                fontSize: 17, fontWeight:FontWeight.w600,
              fontFamily: "Montserrat",
            ),))
          ],
        ));
  }
}