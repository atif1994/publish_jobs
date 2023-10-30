import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import '../../App Services/global_vars.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../widgets/buttonSubmit_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../App Services/api_services_provider.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_country_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_add_personal_info_controller.dart';
import '../../model/country_list_model.dart';
import '../../utils/app_color.dart';
import '../../widgets/profilefoemfield_widget.dart';

class PersonalInfo extends StatefulWidget {
  String? firstName;
  String? countryCode;
  String? lastName;
  String? imageProfile;
  String? countryName;
  String? countryId;
  String? navDeciderr;
  String? emailAddress;
  String? Number;

  PersonalInfo({
    Key? key,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.Number,
    this.countryName,
    this.imageProfile,
    this.countryId,
    this.navDeciderr,
    this.countryCode,
  }) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final String urlCountry = "https://api.publish.jobs/api/userAvailableCountry";
  String? countrySelection;
  String? countrySelectionAll;
  String? countryId;
  String? citySelection;
  bool isAppbar = true;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? mobile_code;
  String? profileImage;
  List uesrCountryList = [];
  List countryListData = [];
  List countryListDataall = [];

  List countryList = ['lahore'];
  File? image;
  String? imageLocation;

  getProfilePersonalInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    try {
      final response = await http.get(
          Uri.parse('https://api.publish.jobs/api/user-general-get'),
          headers: requestHeaders);
      // .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        print(data);
        if (data['user_info'].toString() != 'null') {
          print((data['user_info']['first_name'] ?? 'null name'));
          print((data['user_info']['last_name'] ?? 'null last name'));
        }
        setState(() {
          email = (data['email'] ?? '');
          if (data['user_info'].toString() != 'null') {
            firstName = (data['user_info']['first_name'] ?? '');
            lastName = (data['user_info']['last_name'] ?? '');
          }
          if (data['user_image'].toString() != 'null') {
            profileImage = (data['user_image']['image'] ?? '');
          }
          uesrCountryList = data['country_option'];
          if (uesrCountryList.isNotEmpty) {
            uesrCountryList.add(data['country_option'][0]['title']);
          }
          if (data['user_mobile'].toString() != 'null') {
            mobile = (data['user_mobile']['mobile'] ?? 'null');
          }

          // profileImage = (data['user_image']['image'] ?? '');
          // mobile = (data['user_mobile']['mobile'] ?? 'null');
        });
      } else {
        print('failed persnal info error status code: ' +
            response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString() + ' personalInfo exception');
    }
  }

  Future<String> getCountryList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse(urlCountry),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      countryListData = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  Future<String> getCountryListData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse("https://api.publish.jobs/api/countries"),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body) as List;
    setState(() {
      countryListDataall = resBody;
    });
    print(resBody.toString() + "gggggggggggg");
    return "Sucess";
  }

  Future imagePickerFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTempary = File(image.path);
      final imageLocation = Path.basename(image.name);
      var tempVal = image.name.replaceFirst("image_picker", "");

      setState(() {
        print(tempVal);
        this.imageLocation = imageLocation;
        this.image = imageTempary;
        print(tempVal + "its image nam show the name");
      });
      Upload();
    } on PlatformException catch (e) {
      print("Failed to  pick image $e");
    }
  }

  Future imagePickerFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return print('Image is null');
      }
      ;
      final imageTempary = File(image.path);
      final imageLocation = Path.basename(image.name);
      var tempVal = image.name.replaceFirst("image_picker", "");

      setState(() {
        this.imageLocation = imageLocation;
        this.image = imageTempary;
        print(tempVal + "its image name show the name");
      });
      Upload();
    } on PlatformException catch (e) {
      print("Failed to  pick image $e");
    }
  }

  Upload() async {
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    print(length.toString() + 'length of imageeeeeeeeeeee');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader,
      "Content-Type": "multipart/form-data",
      "Accept": "multipart/form-data"
    };
    // you have to use Token while parsing Bearer token
    var uri = Uri.parse('https://api.publish.jobs/api/account-image-upload');
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(requestHeaders);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: Path.basename(image!.path));
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
      setState(() {});
    } else {
      print('failed image uploading');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCountryListData();
    this.getCountryList();

    //countriesListFuture=DataServices().getCountriesList;
    //this.postCityList();
  }

  String? shotName;
  String? countryCode;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonNumberController = TextEditingController();
  String newFirstName = '';
  String newLastName = '';
  String newPhonNumber = '';
  final _formKey = GlobalKey<FormState>();
  String? _dropdownError;
  String? _selectedItem;
  bool _containerColor = true;

  _validateForm() {
    bool _isValid = _formKey.currentState!.validate();
    if (_selectedItem == null) {
      setState(() => _dropdownError = "Please select an option!");
      _isValid = false;
    }
    if (_isValid) {
      //form is valid
    }
  }
  String? firstNameinit;
  String? lastNameinit;
  String? phonNumberinit;
  String? countryinit;
  String? countrycodeinit;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    firstNameinit = widget.firstName == 'null' ? '' : widget.firstName.toString();
    DataServices dataServices = DataServices();
    firstNameController.text = firstNameinit!;
    firstNameController.selection =
        TextSelection.collapsed(offset: firstNameController.text.length);
    lastNameinit = widget.lastName == 'null' ? '' : widget.lastName.toString();
    lastNameController.text = lastNameinit!;
    lastNameController.selection =
        TextSelection.collapsed(offset: lastNameController.text.length);

    emailController.text = widget.emailAddress!;
    emailController.selection =
        TextSelection.collapsed(offset: emailController.text.length);
    phonNumberinit = widget.Number == 'null' ? '' : widget.Number.toString();
    phonNumberController.text = phonNumberinit!;
    phonNumberController.selection =
        TextSelection.collapsed(offset: phonNumberController.text.length);
    countryinit = widget.countryName == 'null' ? 'Please Select Country' : widget.countryName;
    countrycodeinit = widget.countryCode == 'null' ? 'country code' : widget.countryCode;
    final s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: isDarkMode == true ? Color(0xff343434) : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode == false
            ? ColorApp.colorblackgalf.withOpacity(0.7)
            : Color(0xff787777).withOpacity(0.7),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text("Edit Profile",
              style: TextStyle(
                  color: isDarkMode == false
                      ? ColorApp.colorblack.withOpacity(0.6)
                      : ColorApp.colorbackground.withOpacity(0.69))),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 11,
              right: 11,
              top: 8,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: s.height * 0.012, top: s.height * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 0, bottom: 10),
                        child: Text(
                          "Edit your profile to show client you have to skills and experienced they looking for",
                          style: TextStyle(
                              color: isDarkMode == true
                                  ? AppColors.colorwhite.withOpacity(0.69)
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      )),
                    ],
                  ),
                ),
                Material(
                  color: isDarkMode == true
                      ? Color(0xff787777).withOpacity(0.2)
                      : ColorApp.colorwhite,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: isDarkMode == true
                            ? Color(0xff787777).withOpacity(0.2)
                            : Colors.black54.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: s.width * 0.03, bottom: 15, right: 0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showModalBottomSheet(
                                  backgroundColor: isDarkMode == false
                                      ? Colors.white
                                      : const Color(0xff38373c),
                                  context: context,
                                  builder: (Context) {
                                    return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 15, 0, 5),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 8,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                              // Text("Please choose an option", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: isDarkMode == false ? AppColors.colordark : Colors.white)),
                                              GestureDetector(
                                                onTap: () {
                                                  //_gitFromCamera();
                                                  imagePickerFromCamera();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              9.0),
                                                      child: Icon(
                                                          Icons.camera_alt,
                                                          color: isDarkMode ==
                                                                  false
                                                              ? AppColors
                                                                  .colordark
                                                              : Colors.white),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              9.0),
                                                      child: Text(
                                                        "  Edit Photo With Camera",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: isDarkMode ==
                                                                    false
                                                                ? AppColors
                                                                    .colordark
                                                                : Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  imagePickerFromGallery();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              9.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color:
                                                            isDarkMode == false
                                                                ? AppColors
                                                                    .colordark
                                                                : Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              9.0),
                                                      child: Text(
                                                        "  Edit Photo With Gallery",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: isDarkMode ==
                                                                    false
                                                                ? AppColors
                                                                    .colordark
                                                                : Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                                  });
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              radius: 23,
                              backgroundImage: widget.imageProfile.toString() !=
                                      'null'
                                  ? NetworkImage(widget.imageProfile.toString())
                                  : NetworkImage(
                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.white70,
                                    child: Icon(CupertinoIcons.camera,
                                        color: ColorApp.colorprimary, size: 12),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ProfileFormField(
                            hintText: "Please Enter First Name",
                            image: ImangeAssests.personImg,
                            mustText: '',
                            onValidate: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter first Name';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                newFirstName = val;
                              });
                            },
                            initialName: firstNameinit,
                            icon: Icons.person_outline,
                            textName: "first Name",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ProfileFormField(
                            image: ImangeAssests.personImg,
                            mustText: '',
                            onValidate: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter last Name';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                newLastName = val;
                                print('object');
                                print(widget.firstName! + 'firstname');
                              });
                            },
                            hintText: "Please Enter Last Name",
                            initialName: lastNameinit,
                            icon: Icons.person_outline,
                            textName: "Last Name",
                          ),
                        ),
                        FutureBuilder<List<CountriesListModel>>(
                            future:
                                GetCountryListController().getCountriesList(),
                            builder: (context, snapshot) {
                              var arrayLengh = snapshot.data?.length ?? 0;
                              for (var i = 0; i < arrayLengh; i++) {
                                countryList.add(snapshot.data![i].title);
                              }

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: isDarkMode == false
                                                ? ColorApp.colorblackgalf
                                                : ColorApp.colorwhite
                                                    .withOpacity(0.7),
                                            size: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3, right: 2),
                                            child: Text(
                                              'Country',
                                              style: TextStyle(
                                                  color: isDarkMode == false
                                                      ? ColorApp.colorblackgalf
                                                      : ColorApp.colorwhite
                                                          .withOpacity(0.5),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 13),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: isDarkMode == true
                                              ? Color(0xff343434)
                                              : Colors.white,
                                          border: Border.all(
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                      .withOpacity(0.3)
                                                  : Colors.black54
                                                      .withOpacity(0.3))),
                                      height: s.height * 0.0579,
                                      child: DropdownButton(
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 30,
                                          ),
                                        ),
                                        dropdownColor: isDarkMode == false
                                            ? ColorApp.colorblackgalf
                                            : ColorApp.colorblackgalf,
                                        elevation: 1,
                                        isExpanded: true,
                                        underline: Container(
                                          color: AppColors.colorblue,
                                        ),
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:


                                          Text(
                                            countryinit.toString(),
                                            style: TextStyle(
                                                color: isDarkMode == true
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                        value: countrySelection,
                                        onChanged: (v) {
                                          int? countryIndex;
                                          int se = countryListData.indexWhere(
                                              (item) => item["title"] == v);
                                          setState(() {
                                            _selectedItem = v as String?;
                                            _dropdownError = null;
                                            citySelection = null;
                                            countrySelection = v as String;
                                            countryIndex =
                                                countryListData.indexOf(v);
                                            //countryId = (index!+1).toString();
                                            for (var i = 0;
                                                i < arrayLengh;
                                                i++) {
                                              if (snapshot.data![i].title ==
                                                  v) {
                                                print('id country');
                                                countryId = snapshot.data![i].id
                                                    .toString();

                                                print(countryId.toString() +
                                                    'country idd');
                                              }
                                            }
                                          });
                                        },
                                        items: countryListData.map((v) {
                                          return DropdownMenuItem(
                                            value: v['title'],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                v['title'],
                                                style: TextStyle(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colornewblack
                                                        : ColorApp.colorwhite),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 6, bottom: 5),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, top: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.email_outlined,
                                      color: isDarkMode == false
                                          ? ColorApp.colorblackgalf
                                          : ColorApp.colorwhite
                                              .withOpacity(0.7),
                                      size: 17,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Text(
                                        "Email Address",
                                        style: TextStyle(
                                            color: isDarkMode == false
                                                ? ColorApp.colorblackgalf
                                                : ColorApp.colorwhite
                                                    .withOpacity(0.5),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(
                                          color: isDarkMode == false
                                              ? ColorApp.colorblackgalf
                                              : ColorApp.colorwhite
                                                  .withOpacity(0.9),
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 13, top: 7, bottom: 4),
                                child: TextFormField(
                                    enabled: false,
                                    initialValue: widget.emailAddress,
                                    style: TextStyle(
                                        color: isDarkMode == true
                                            ? ColorApp.colorprimary
                                                .withOpacity(0.8)
                                            : ColorApp.colorprimary
                                                .withOpacity(0.8)),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: isDarkMode == true
                                                  ? ColorApp.colorprimary
                                                      .withOpacity(0.8)
                                                  : ColorApp.colorprimary
                                                      .withOpacity(0.8))),
                                      filled: true,
                                      fillColor: isDarkMode == true
                                          ? Color(0xff343434)
                                          : Colors.white,
                                      hintText: widget.emailAddress,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: isDarkMode == true
                                                  ? ColorApp.colorprimary
                                                      .withOpacity(0.8)
                                                  : ColorApp.colorprimary
                                                      .withOpacity(0.8))),
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: isDarkMode == true
                                              ? ColorApp.colorprimary
                                              : ColorApp.colorprimary,
                                          fontWeight: FontWeight.w300),
                                      contentPadding: EdgeInsets.only(
                                          left: 10.0,
                                          top: 13.0,
                                          bottom: 13.0,
                                          right: 10),
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: isDarkMode == true
                                                ? ColorApp.colorprimary
                                                    .withOpacity(0.8)
                                                : ColorApp.colorprimary
                                                    .withOpacity(0.8)),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: s.width * 0.31,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: s.height * 0.03, right: 13),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: isDarkMode == true
                                          ? Color(0xff343434)
                                          : Colors.white,
                                      border: Border.all(
                                          color: isDarkMode == true
                                              ? Colors.white.withOpacity(0.3)
                                              : Colors.black54
                                                  .withOpacity(0.3))),
                                  height: s.height * 0.0579,
                                  child: DropdownButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 15,
                                      ),
                                    ),
                                    dropdownColor: isDarkMode == false
                                        ? ColorApp.colorblackgalf
                                        : ColorApp.colorblackgalf,
                                    elevation: 1,
                                    isExpanded: true,
                                    underline: Container(
                                      color: AppColors.colorblue,
                                    ),
                                    onChanged: (v) {
                                      print(v.toString() + "show id of data");
                                      setState(() {
                                        countrySelectionAll = v as String?;
                                        mobile_code = v;
                                      });
                                    },
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.countryCode == null ? ' select code' : widget.countryCode.toString(),
                                        style: TextStyle(
                                          fontSize: 10,
                                            color: isDarkMode == true
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    value: countrySelectionAll,
                                    items: countryListDataall.map((v) {
                                      return DropdownMenuItem(
                                        value: v['id'].toString(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                v['code'],
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: isDarkMode == false
                                                        ? ColorApp.colornewblack
                                                        : ColorApp.colorwhite),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:  EdgeInsets.only(top: s.height*0.03,right: 10),
                                child: TextFormField(
                                  maxLength: 10,
                                    style: TextStyle(
                                      color: isDarkMode == true
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.71),
                                    ),

                                    autovalidateMode: AutovalidateMode.onUserInteraction,

                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Please enter first number';
                                      }
                                      if (val.length<10) {
                                        return 'Please enter valid number';
                                      }
                                      return null;
                                    },
                                    keyboardType:  TextInputType.number,
                                    onChanged: (val) {
                                      setState(() {
                                        newPhonNumber = val;
                                        print('object');
                                        print(widget.firstName! + 'firstname');
                                      });
                                    },

                                    initialValue: phonNumberinit,
                                    decoration: InputDecoration(

                                      focusedBorder:
                                      OutlineInputBorder(
                                        borderSide:
                                        BorderSide(

                                            color:ColorApp.colorprimary
                                        ),

                                      ),
                                      filled: true,
                                      fillColor:
                                      isDarkMode == true ? Color(0xff343434) : Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: isDarkMode == true
                                                  ? Colors.white.withOpacity(0.3)
                                                  : Colors.black54.withOpacity(0.3))),
                                      hintText: "Please Enter Number",
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: isDarkMode == true
                                              ? AppColors.colorwhite.withOpacity(0.69)
                                              : Colors.grey,
                                          fontWeight: FontWeight.w300),
                                      contentPadding: EdgeInsets.only(
                                          left: 10.0, top: 13.0, bottom: 13.0, right: 10),
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                    )),
                              )





                              // ProfileFormField(
                              //
                              //   mustText: '',
                              //   hintText: '',
                              //   onValidate: (val) {
                              //     if (val == null || val.isEmpty) {
                              //       return 'Please enter first number';
                              //     }
                              //     return null;
                              //   },
                              //   keyBordType: TextInputType.number,
                              //   onChanged: (val) {
                              //     setState(() {
                              //       newPhonNumber = val;
                              //       print('object');
                              //       print(widget.firstName! + 'firstname');
                              //     });
                              //   },
                              //   initialName: ,
                              //
                              //
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: s.height * 0.037,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0, right: 10),
                        child: SubmitButton(
                            border: Border.all(
                                color: isDarkMode == false
                                    ? AppColors.colorblack
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
                      Consumer<PostAddPersonalInfoController>(
                        builder: (context, val, child) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Center(
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                color: ColorApp.colorprimary.withOpacity(0.8),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    splashColor:
                                        AppColors.colorindigo.withOpacity(0.8),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        val.jobSeekerAddPersonalInfo(
                                            newFirstName == ''
                                                ? firstNameinit.toString()
                                                : newFirstName,
                                            newLastName == ''
                                                ? lastNameinit.toString()
                                                : newLastName,
                                            countryId.toString() == 'null'
                                                ? ''
                                                : countryId.toString(),
                                            newPhonNumber == ''
                                                ? phonNumberinit.toString()
                                                : newPhonNumber,
                                            mobile_code.toString() == ''
                                                ? widget.countryCode.toString()
                                                : mobile_code.toString(),
                                            context);
                                        setState(() {
                                          GlobalVarData.personalInfoDataUpdated =
                                          'not null';
                                        });
                                        Future.delayed(Duration(seconds: 5), () {
                                          Navigator.pop(context);
                                        });
                                      }

                                    },
                                    child: Container(
                                        height: s.height * 0.05,
                                        width: s.width * 0.28,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Center(
                                          child: val.loadingInfo == false
                                              ? Text(
                                                  "Update",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: isDarkMode == false
                                                          ? AppColors.colorwhite
                                                          : Colors.white),
                                                )
                                              : SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 3,
                                                  ),
                                                ),
                                        ))),
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
        ),
      ),
    );
  }
}
