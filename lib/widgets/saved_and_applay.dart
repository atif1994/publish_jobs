import 'package:firstapp/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_app.dart';
import 'Custom Text/generaltext.dart';

class SavedAndApplay extends StatelessWidget {
  dynamic? image;
  String? JobName;
  Color? jobStatusColor;
  String? companyName;
  String? cityName;
  String? dateShow;
  String? buttonText;
  String? textJobsStatus;
  String? hoursShow;
  String? salaryShow;
  String? fullTime;
  Color? buttonbgColor;

  final dynamic? Ontap;
  IconData? iconPerson;

  SavedAndApplay(
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
      this.buttonText,
      this.buttonbgColor,this.jobStatusColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var s = MediaQuery.of(context).size;
    return Material(
      color: isDarkMode == true
          ? ColorApp.colorblackgalf.withOpacity(0.5)
          : ColorApp.colorwhite,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorApp.colorblackgalf.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                              child: Center(
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  elevation: 1,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 1, color: Colors.white)),
                                    child: CircleAvatar(
                                        radius: 40,
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
                                  Row(
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
                                    ],
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
                                    size: 11,
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
                                          color: ColorApp.colorprimary
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                          size: 9,
                                          text: "$cityName"),
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: s.height * 0.03, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.bookmark_border_outlined,
                              color: ColorApp.colorprimary,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "$dateShow",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: ColorApp.colorprimary,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
                                EdgeInsets.only(left: 12, bottom: 10, top: 5),
                            child: Text(
                              hoursShow.toString(),
                              style: TextStyle(
                                  color: jobStatusColor, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 5, right: 10),
                        child: Container(
                          height: s.height * 0.035,
                          width: s.width * 0.20,
                          decoration: BoxDecoration(
                              color: buttonbgColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Material(
                            color: buttonbgColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 6,
                            child: InkWell(
                              onTap: Ontap,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  iconPerson == null
                                      ? Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Center(
                                            child: Text(
                                              "$buttonText",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                  color: ColorApp.colorwhite,
                                                  fontSize: 13),
                                            ),
                                          ),
                                      )
                                      : Row(
                                        children: [
                                          Text(
                                              "$buttonText",
                                              style: TextStyle(
                                                  color: ColorApp.colorwhite,
                                                  fontSize: 13),
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4),
                                            child: Icon(
                                              iconPerson,
                                              color: ColorApp.colorwhite,
                                              size: 14,
                                            ),
                                          )
                                        ],
                                      ),

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
