import 'dart:async';
import 'package:firstapp/constants/color_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      insetPadding: EdgeInsets.only(
          left: s.width * 0.03,
          right: s.width * 0.03,
          top: s.height * 0.2,
          bottom: s.height * 0.483),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
        width: s.width,
        height: s.height * 0.19,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(50)),
              height:s.height*0.05,
              width: s.width*0.12,
              child: Center(
                  child: Icon(
                Icons.gpp_good_rounded,
                color: Colors.white,
              )),
            ),
            SizedBox(height: 5,),
            InkWell(
              onTap: () {},
              child: Text(
                "Jobs Saved",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 5, top: 6),
              child: Text(
                "This job is saved into your job history",
                style: TextStyle(fontSize: 14, color: ColorApp.colorblackgalf),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: s.width*0.099,top: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: ColorApp.colordltbtn
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          "Dismiss",
                          style: TextStyle(
                              color: ColorApp.colorprimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: s.width*0.06,),
                  InkWell(
                    onTap: (){
                      Timer(Duration(seconds: 2), () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Bar(id: 2,page: 0,)));
                      });

                    },
                    child: Container(

                      decoration: BoxDecoration(
                        color: ColorApp.colorprimary,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.white
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          "See saved jobs",
                          style: TextStyle(
                              color: ColorApp.colorwhite,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Row(
            //   children: [
            //
            //     Row(
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //
            //           ],
            //         ),
            //
            //       ],
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
