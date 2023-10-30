import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_add_resume_controller.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';
import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';
import 'package:path/path.dart';

class AddResume extends StatefulWidget {
  const AddResume({Key? key}) : super(key: key);

  @override
  State<AddResume> createState() => _AddResumeState();
}

class _AddResumeState extends State<AddResume> {
  File? filePick;


  String? fileName;
  String? path;

  void upLoadFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    if (result != null) {
       path = result.files.single.path!;
      fileName = result.files.single.name;
      setState(() {
        filePick = File(path!);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    DataServices dataServices = DataServices();
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AddAppBar(
        appBarText: "Upload Resume",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: s.width * 0.04, top: s.height * 0.03),
            child: Text(
              "Add your proffessional resume here",
              style: TextStyle(
                  color: isDarkMode == true
                      ? AppColors.colorwhite.withOpacity(0.69)
                      : Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: s.width * 0.02, top: s.height * 0.03),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: isDarkMode == true
                        ? Color(0xff787777).withOpacity(0.2)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: isDarkMode == true
                                ? Colors.white.withOpacity(0.3)
                                : Colors.black54.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: s.width * 0.05),
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text(
                                  "Resume",
                                  style: TextStyle(
                                      color: isDarkMode == true
                                          ? ColorApp.colorgrayfully
                                          : ColorApp.colorblackgalf),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: s.width * 0.06,
                                  right: s.width * 0.06,
                                  top: 8,
                                  bottom: 8),
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: isDarkMode == true
                                              ? Colors.white.withOpacity(0.3)
                                              : Colors.black54
                                                  .withOpacity(0.3))),
                                  filled: true,
                                  fillColor: isDarkMode == true
                                      ? Color(0xff343434)
                                      : Colors.white,
                                  contentPadding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorApp.colorprimary),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  hintText: fileName == null
                                      ? "Choose a file or Drag/drop here"
                                      : fileName,
                                  hintStyle: TextStyle(
                                      fontSize: 11,
                                      color: isDarkMode == true
                                          ? AppColors.colorwhite
                                              .withOpacity(0.69)
                                          : Colors.grey),
                                  suffixIcon: InkWell(
                                    onTap: () async {
                                      upLoadFile();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, top: 0, right: 0, bottom: 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: isDarkMode == true
                                                    ? Colors.white
                                                        .withOpacity(0.3)
                                                    : Colors.black54
                                                        .withOpacity(0.3)),
                                            color: isDarkMode == true
                                                ? Color(0xff343434)
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: s.width * 0.045,
                                              right: 20,
                                              left: 10),
                                          child: Text(
                                            "Browser",
                                            style: TextStyle(
                                                color: isDarkMode == true
                                                    ? ColorApp.colorgrayfully
                                                    : ColorApp.colorblackgalf,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: s.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 0),
                        child: SubmitButton(
                            border: Border.all(
                                color: isDarkMode == false
                                    ? AppColors.colorblack.withOpacity(0.3)
                                    : Colors.white.withOpacity(0.2)),
                            textColor: isDarkMode == true
                                ? AppColors.colorwhite
                                : AppColors.colorblack,
                            backGroundColor: isDarkMode == true
                                ? Color(0xff343434)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            heightButton: s.height * 0.05,
                            widthButton: s.width * 0.30,
                            textButton: "Cancel",
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                      Consumer<PostAddResumeController>(
                        builder: (context, val, child) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Center(
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                color: ColorApp.colorprimary,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    splashColor:
                                        AppColors.colorindigo.withOpacity(0.8),
                                    onTap: ()async {

                                      var bytes = await File("$filePick").readAsBytes();
                                      val.jobSeekerAddResume(
                                          bytes, "", context);
                                    },
                                    child: Container(
                                        height: s.height * 0.05,
                                        width: s.width * 0.30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Center(
                                            child:val.loadingAddResume==false? Text(
                                          "Upload now",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isDarkMode == false
                                                  ? AppColors.colorwhite
                                                  : Colors.white),
                                        ):CircularProgressIndicator()))),
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
          ),
        ],
      ),
    );
  }
}
