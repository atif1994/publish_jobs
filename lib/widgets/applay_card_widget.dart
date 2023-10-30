import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Network Controller/Applay Controller/post_applay_later_controller.dart';
import '../constants/color_app.dart';
import 'AlertDailog.dart';
import 'Custom Text/generaltext.dart';

class AppCardWidget extends StatefulWidget {

   AppCardWidget({Key? key}) : super(key: key);

  @override
  State<AppCardWidget> createState() => _AppCardWidgetState();
}

class _AppCardWidgetState extends State<AppCardWidget> {
  String? jobName;
  String? companyName;
  String? cityName;
  String? salaryShow;
  String? postedTime;
  String? imageUrl;
  String ?jobDescription;
  String ?JobId;

  getJobCardValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      jobName = prefs.getString('jobName').toString();
      JobId = prefs.getString('jobId').toString();
      companyName = prefs.getString('companyName').toString();
      cityName = prefs.getString('cityName').toString();
      salaryShow = prefs.getString('salaryShow').toString();
      postedTime = prefs.getString('postedTime').toString();
      imageUrl = prefs.getString('imageUrl').toString();
      jobDescription = prefs.getString('jobDescription').toString();
    });
  }
  @override
  void initState() {
    getJobCardValues();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding:  EdgeInsets.only(left: s.width*0.045,right: s.width*0.045 ),
        child: Material(
          color: isDarkMode == true
              ? ColorApp.colorblackgalf.withOpacity(0.5)
              : ColorApp.colorwhite,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Center(
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                elevation: 1,
                                child: Container(
                                  height: s.height*0.06,
                                  width: s.width*0.15,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius
                                          .circular(8.0),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors
                                              .white)),
                                  child:ClipRRect (
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(

                                        height: s.height*0.06,
                                        width: s.width*0.50,

                                        fit: BoxFit.fill,
                                        imageUrl.toString()),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: CustomText(
                                    color: isDarkMode == false
                                        ? ColorApp.colorblack
                                        : ColorApp.colorwhite,
                                    fontWeight: FontWeight.w600,
                                    text: jobName.toString(),
                                    size: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                CustomText(
                                  color: isDarkMode == false
                                      ? ColorApp.colorblackgalf
                                      : ColorApp.colorwhite,
                                  fontWeight: FontWeight.w500,
                                  text: "$companyName",
                                  size: 10,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 18,
                                      color: ColorApp.colorprimary,
                                    ),
                                    CustomText(
                                        color:
                                        ColorApp.colorprimary.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        size: 8,
                                        text: "$cityName"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only( top: 5),
                                      child: Material(
                                        color:  isDarkMode == true
                                            ? ColorApp.colorblackgalf.withOpacity(0.2)
                                            : ColorApp.colorwhite,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          elevation: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 05),
                                            child: Text(
                                              salaryShow??'',
                                              style: TextStyle(
                                                fontSize: 7,
                                                color:isDarkMode == true
                                                    ? Colors.white
                                                    : Colors.black87
                                              ),
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.fromLTRB(5, 5, 0,0 ),
                                      child: Material(
                                        color: isDarkMode == true
                                            ? ColorApp.colorblackgalf.withOpacity(0.2)
                                            : ColorApp.colorwhite,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          elevation: 1,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Icon(
                                                  Icons.access_time,
                                                  size: 10,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : Colors.black87,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(5, 5, 10, 05),
                                                child: Text(
                                                  jobDescription??'',
                                                  style: TextStyle(
                                                    fontSize: 7,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : Colors.black87
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),


                              ]),
                        ],
                      ),

                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 12,right: s.width*0.0,left: 10),
                                  child: Text(
                                    postedTime.toString(),
                                    style: TextStyle(
                                        color: ColorApp.colorprimary, fontSize: 12),
                                  ),
                                ),



                              ],
                            ),
                            Consumer<PostApplayLaterController>(
                              builder: (context, val, child) {
                                return   Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10, top: 0,right: s.width*0.025),
                                  child: Container(
                                    height: s.height * 0.035,
                                    width: s.width * 0.27,
                                    decoration: BoxDecoration(
                                        color: ColorApp.colorblackgalf.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Material(
                                      color: ColorApp.colorblackgalf.withOpacity(0.8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0)),
                                      elevation: 1,
                                      child: InkWell(
                                        onTap: (){
                                          val.ApplayLater(JobId.toString(), context);
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return MyDialog();
                                              });
                                        },
                                        child: Row(

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5,right: 5),
                                              child: Text(
                                                "Applay later",
                                                style: TextStyle(
                                                    color: ColorApp.colorwhite,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Icon(
                                              Icons.access_time,
                                              color: ColorApp.colorwhite,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
