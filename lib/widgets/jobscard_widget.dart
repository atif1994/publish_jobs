import 'package:firstapp/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_app.dart';
import 'Custom Text/generaltext.dart';

class JobsCard extends StatelessWidget {
  dynamic? image;
  String? JobName;
  String? companyName;
  String? cityName;
  String? dateShow;
  String? buttonText;
  String? textJobsStatus;
  String? hoursShow;
  String? salaryShow;
  String? fullTime;
  Color? heartColor;
  Color? shareColor;
  Color? buttonColor;

  final dynamic? Ontap;
  final dynamic? ontapshare;
  final dynamic? ontapsave;
  Icon? iconPerson;
  IconData? iconButton;
  IconData? iconHeart;
  IconData? iconShare;

  JobsCard(
      {Key? key,
      this.image,
      this.JobName,
      this.cityName,
      this.companyName,
      this.dateShow,
      this.textJobsStatus,
      this.iconPerson,
      this.Ontap,
      this.salaryShow,
      this.hoursShow,
      this.fullTime,
      this.heartColor,
      this.shareColor,
      this.buttonText,
      this.iconHeart,
      this.iconShare,
      this.ontapshare,
      this.ontapsave,this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery.of(context).size;
    return Material(
      color: isDarkMode == true
          ? ColorApp.colorblackgalf.withOpacity(0.2)
          : ColorApp.colorwhite,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: isDarkMode == true
              ?ColorApp.colorblackgalf.withOpacity(0.1)
              : ColorApp.colorblackgalf),
          borderRadius: BorderRadius.circular(12.0)),
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
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Center(
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            elevation: 1,
                            child: Container(
                              height: s.height * 0.046,
                              width: s.width * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                      width: 1, color: Colors.white)),
                              child: CircleAvatar(
                                  backgroundColor: AppColors.colorgray,
                                  backgroundImage: image),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
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
                                text: "$JobName",
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
                          ]),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: s.height * 0.03, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: ontapsave,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              iconHeart,
                              color: heartColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: ontapshare,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                              iconShare,
                              color: shareColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 4, bottom: 10, top: 5),
                            child: Text(
                              hoursShow.toString(),
                              style: TextStyle(
                                  color: ColorApp.colorprimary, fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 5),
                            child: Material(
                                color: isDarkMode == true
                                    ? ColorApp.colorblackgalf.withOpacity(0.2)
                                    : ColorApp.colorwhite,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 05),
                                  child: Text(
                                    salaryShow ?? '',
                                    style: TextStyle(
                                        fontSize: 7,
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black87),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 08,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
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
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Icon(
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : Colors.black87,
                                        Icons.access_time,
                                        size: 7,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 05),
                                      child: Text(
                                        fullTime ?? '',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: isDarkMode == true
                                                ? Colors.white
                                                : Colors.black87),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            width: 08,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 5, right: 10),
                        child: Container(
                          height: s.height * 0.035,
                          width: s.width * 0.23,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20)),
                          child: Material(
                            color: buttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 6,
                            child: InkWell(
                              onTap: Ontap,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$buttonText",
                                    style: TextStyle(
                                        color: ColorApp.colorwhite,
                                        fontSize: 11),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(

                                    Icons.launch_rounded,
                                    color: ColorApp.colorwhite,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
