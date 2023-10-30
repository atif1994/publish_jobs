import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_gallery_Controller.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../utils/app_color.dart';
import '../../widgets/profile_data_add_screen_app_bar.dart';
import '../../widgets/buttonSubmit_widget.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class AddGalleryImage extends StatefulWidget {
  const AddGalleryImage({Key? key}) : super(key: key);

  @override
  State<AddGalleryImage> createState() => _AddGalleryImageState();
}

class _AddGalleryImageState extends State<AddGalleryImage> {
  File? _image;
  final imagePicker = ImagePicker();

  Future getimagegallery() async {
    final pickFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickFile != null) {
        _image = File(pickFile.path);
      } else {
        print("'not upload image");
      }
    });
  }

  Future<void> uploadImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader,
      "Content-Type": "multipart/form-data",
      "Accept": "multipart/form-data"
    };
    var stream = new http.ByteStream(_image!.openRead());
    stream.cast();
    var length = await _image!.length();
    var response;
    try {
      var uri = Uri.parse('https://api.publish.jobs/api/jobseekerAddGallery');
      var request = new http.MultipartRequest('POST', uri);
      //request.fields['title'] = "Static title" ;
      var multiport = new http.MultipartFile(
        'file',
        stream,
        length,
        // contentType: new MediaType('png', 'jpeg')
      );
      request.headers.addAll(requestHeaders);
      request.files.add(multiport);
      response = await request.send();
      print(response.stream.toString());
      if (response.statusCode == 200) {
        setState(() {
          //showSpinner = false ;
        });
        print('image uploaded');
      } else if (response.statusCode == 302) {
        print('failed with 302');
      } else {
        print('failed');
        print(response.statusCode.toString());
      }
    } catch (e) {
      print(response.statusCode.toString());
      print('failed');
      setState(() {
        // showSpinner = false ;
      });
    }
  }

  Upload() async {

    var stream = new http.ByteStream(_image!.openRead());
    stream.cast();
    var length = await _image!.length();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader,
      "Content-Type": "multipart/form-data",
      "Accept": "multipart/form-data"
    };
    // you have to use Token while parsing Bearer token
    var uri = Uri.parse('https://api.publish.jobs/api/jobseekerAddGallery');
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(requestHeaders);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(_image!.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    request.headers.addAll(requestHeaders);
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {

      setState(() {
        //showSpinner = false ;
      });
      print('image uploaded');
    } else {

      print('failed');
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
        appBarText: "Profile Gallery",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: s.width * 0.04, top: s.height * 0.03),
              child: Text(
                "Add your proffessional Images here",
                style: TextStyle(
                    color: isDarkMode == true
                        ? AppColors.colorwhite.withOpacity(0.69)
                        : Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: s.width * 0.02, top: s.height * 0.04),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10)),
                      width: Get.width * 0.8,
                      height: Get.height * 0.3,
                      child: _image != null
                          ? Image.file(
                              width: Get.width * 0.8,
                              height: Get.height * 0.3,
                              _image!.absolute)
                          :isDarkMode==true? Image.asset(

                              fit: BoxFit.fill,
                              width: Get.width * 0.4,
                              height: Get.height * 0.3,
                              ImangeAssests.addDarkResumeImage):Image.asset(
                          fit: BoxFit.fill,

                          width: Get.width * 0.4,
                          height: Get.height * 0.3,
                          ImangeAssests.addResumeImage)),
                  SizedBox(
                    height: 20,
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
                                      : Colors.black54.withOpacity(0.3))),
                          filled: true,
                          fillColor: isDarkMode == true
                              ? Color(0xff343434)
                              : Colors.white,
                          contentPadding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorApp.colorprimary),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintText: "Selete a file a Drag/Drop here",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: isDarkMode == true
                                  ? AppColors.colorwhite.withOpacity(0.69)
                                  : Colors.grey),
                          suffixIcon: InkWell(
                            onTap: () {
                              getimagegallery();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, right: 15, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.colorprimary,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Browser",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                        Padding(
                          padding:  EdgeInsets.only(right: s.width*0.03),
                          child: Consumer<GetGalleryController>(
                            builder: (context, val, child) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Center(
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    color: ColorApp.colorprimary,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(6),
                                        splashColor:
                                        AppColors.colorindigo.withOpacity(0.8),
                                        onTap: () {
                                          Upload();
                                          Timer(Duration(seconds: 2), () {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Provider.of<GetGalleryController>(
                                                  context,
                                                  listen: false)
                                                  .galleryListData
                                                  .clear();
                                              Provider.of<GetGalleryController>(
                                                  context,
                                                  listen: false)
                                                  .getGallery();
                                            });
                                           Navigator.pop(context);
                                          });

                                        },
                                        child: Container(
                                            height: s.height * 0.05,
                                            width: s.width * 0.36,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                            child: Center(
                                                child:
                                                val.isGetGalleryLoading == false
                                                    ?   Text(
                                                  "Upload now",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                      isDarkMode ==
                                                          false
                                                          ? AppColors
                                                          .colorwhite
                                                          : Colors
                                                          .white),
                                                ):CircularProgressIndicator()

                                            ))),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),



                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
