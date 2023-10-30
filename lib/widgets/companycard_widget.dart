import 'package:firstapp/constants/color_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CompanyCard extends StatelessWidget {
  dynamic? image;
  String ?companyName;
  String ?industaryName;
  String ?websiteName;

  CompanyCard({Key? key, required this.image,this.companyName,this.industaryName,this.websiteName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery.of(context).size;
    return Material(
      color: ColorApp.colorwhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: ColorApp.colorwhite, width: 1),
      ),
      elevation: 1,
      child: Column(
        children: [
          SizedBox(height: s.height*0.02,),
          Column(
            children: [
              Center(
                child:Material(
                  elevation: 1,
                  child: Container(
                    height: s.height*0.08,
                    width:s.width*0.19 ,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(4),
                        border: Border.all(
                            width: 1,
                            color:AppColors.colorprimary.withOpacity(0.7))),
                    child: CircleAvatar(

                        radius: 0,
                        backgroundColor:
                        AppColors.colorgray,
                        backgroundImage: image
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(companyName.toString(),style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode==true?AppColors.colorwhite:AppColors.colorblack
                        ),),
                      ),
                    ],
                  )),
                ],
              ),
              SizedBox(height: 4,),
              Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Text(

                        industaryName.toString(),style: TextStyle(
                          fontSize: 10,
                          color: isDarkMode==true?AppColors.colorwhite:AppColors.colorblack

                      ),),
                    ],
                  )),
                ],
              ),
              SizedBox(height: 4,),
              Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Text(

                        websiteName.toString(),style: TextStyle(
                          fontSize: 10,
                          color: isDarkMode==true?AppColors.colorwhite:AppColors.colorprimary

                      ),),
                    ],
                  )),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
