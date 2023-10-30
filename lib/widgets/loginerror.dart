import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_app.dart';

class LoginError extends StatelessWidget {
  bool isVisible = true;
   LoginError({Key? key,required this.isVisible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s=MediaQuery.of(context).size;
    return Container(
      child:   isVisible? Visibility(

          child: Container(
            child:  Column(
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(12)
                    ),

                    height: s.height * 0.13,
                    width: s.width * 0.99,
                    child: Column(
                      children: [
                        Icon(Icons.error_outline),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sorry we Couldn't find an account with",
                              style: TextStyle(
                                color: ColorApp.colorblackgalf,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                                fontSize: 14,),
                            ),
                            Text(
                              "that email address. Can we help you to",
                              style: TextStyle(  color: ColorApp.colorblackgalf,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                                fontSize: 14,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: Text(
                                "recover your email?",
                                style: TextStyle(   color: ColorApp.colorblackgalf,
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
            ),
          )):Text(""),
    );




  }
}
