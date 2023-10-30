import 'package:firstapp/views_screen/profile_screen/profile_add_career_level_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_certification_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_education_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_expected_salary_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_experience.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_gallery_image_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_gender_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_job_type_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_language_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_marital_status_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_prefer_job_location_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_prefer_job_position_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_resume_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_skill_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_add_work_authorization_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_edit_education_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_edit_expected_salary.dart';
import 'package:firstapp/views_screen/profile_screen/profile_edit_experience.dart';
import 'package:firstapp/views_screen/profile_screen/profile_edit_personal_info_screen.dart';
import 'package:firstapp/views_screen/profile_screen/profile_edit_traning_certification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firstapp/AppWidgets/Effect_button.dart';
import 'package:firstapp/model/job_seeker_w_auth_model.dart';
import 'package:firstapp/utils/app_color.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:html/parser.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import '../../App Services/api_services_provider.dart';
import '../../App Services/global_vars.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobSeekercareer_apply_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_certificationList_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_experience_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_gallery_Controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_seeker_achievement_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_seeker_association_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_job_skill_list_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobseeker_career_level_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobseeker_gender_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_jobseeker_martialstatus_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_language_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_personal_Info_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_personal_objective_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_preferred_job_location_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_preferred_job_type_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_preferred_position_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_qualification_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_ready_to_work_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_relocation_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_resume_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_salary_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_summary_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Get Apis/get_work_authorization_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_delete_AlertApi_profilebase_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_job_skill_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_obj_summ_achm_assoc_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_readyto_work_controller.dart';
import '../../Network Controller/Profile Controllers/Profile Post Apis/post_relocation_controller.dart';
import '../../model/GetjobSeekerCareerLevelModel.dart';
import '../../model/get_resume_model.dart';
import '../../model/job_seeker_certification_model.dart';
import '../../model/job_seeker_language_model.dart';
import '../../model/job_seeker_martial_status_model.dart';

import '../../api/api.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../constants/color_app.dart';
import '../../constants/image_assets.dart';
import '../../model/get_salary_model.dart';
import '../../model/job_seeker_career_level_model.dart';
import '../../model/job_seeker_gallary_model.dart';
import '../../model/job_seeker_gender_model.dart';
import '../../model/job_seeker_job_location_model.dart';
import '../../model/job_seeker_objective_model.dart';
import '../../model/job_seeker_preferred_position_model.dart';
import '../../model/job_seeker_preferred_type_model.dart';
import '../../model/job_seeker_ready_to_work_model.dart';
import '../../model/job_seeker_relocation_model.dart';
import '../../model/job_seeker_summary_model.dart';
import '../../profile_model/job_seeker_association_model.dart';
import '../../profile_model/job_seeker_education_model.dart';
import '../../profile_model/job_seeker_skill_model.dart';
import '../../profile_model/job_seeker_work_experience_model.dart';
import '../../utils/app_string.dart';
import '../../utils/constants.dart';

import '../../widgets/Loading_data.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../Login_screen/login_screen.dart';

class ProfileBasicScreen extends StatefulWidget {
  final String? tokenCuperTino;

  const ProfileBasicScreen({Key? key, this.tokenCuperTino}) : super(key: key);

  @override
  State<ProfileBasicScreen> createState() => _ProfileBasicScreenState();
}

class _ProfileBasicScreenState extends State<ProfileBasicScreen> {
  File? image;
  String? imageLocation;
  var open = true;
  bool workshow = true;
  bool workauthoclosed = false;
  bool positionJob = true;
  bool positionJobClosed = false;
  bool positionlocation = true;
  bool positionlocationClosed = false;
  bool jobtype = true;
  bool jobstypeclosed = false;
  bool careerlevel = true;
  bool careerlevelclosed = false;
  final double coverHeight = 100;
  final double profileheight = 100;
  bool editprofileopen = false;
  bool editprofileclosed = true;
  bool _rememberMe = false;
  bool isAppbar = true;
  String? imageLink;
  bool careerLevelDelete = true;

  Future imagePickerFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      final imageTempary = File(image.path);
      final imageLocation = Path.basename(image.name);
      var tempVal = image.name.replaceFirst("image_picker", "");

      setState(() {
        this.imageLocation = imageLocation;
        this.image = imageTempary;
      });
      uploadProfileImage();
    } on PlatformException catch (e) {
      print("Failed to  pick image $e");
    }
  }

  Future imagePickerFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera, maxWidth: 200.0, maxHeight: 300.0);
      if (image == null) {
        return print('Image is null');
      }
      ;
      dynamic imageTempary = File(image.path);
      final imageLocation = Path.basename(image.name);
      imageTempary = await _cropImage(imageTempary);
      var tempVal = image.name.replaceFirst("image_picker", "");

      setState(() {
        this.imageLocation = imageLocation;
        this.image = imageTempary;
        print(tempVal + "its image name show the name");
      });
      uploadProfileImage();
    } on PlatformException catch (e) {
      print("Failed to  pick image $e");
    }
  }

  uploadProfileImage() async {
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
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
    if (response.statusCode == 200) {
      print('image uploaded');
      setState(() {
        GlobalVarData.personalInfoFuture = getProfilePersonalInfo();
        GlobalVarData.personalInfoDataUpdated = 'null';
      });

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Bar(
      //               id: 3,
      //             )));
    } else {
      print('failed image uploading');
    }
  }

  Future<bool> _onWillPop() async {
    return await Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(
            builder: (context) => Bar(
                  id: 0,
                )));
  }

  Future<File?> _cropImage(File imageFile) async {
    CroppedFile? cropImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (cropImage == null) return null;
    return File(cropImage.path);
  }

  var sessionData;
  int a = 0;

  checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenCheck = await prefs.getString('tokenProvider').toString();
    setState(() {
      sessionData = tokenCheck;
      print(sessionData.toString() + "session");
    });
  }

  //personal info data
  String? email;
  String? firstName;

  String? lastName;
  String? mobileCode;
  String? mobile;
  List uesrCountryList = [];
  List uesrCountryCode = [];

  String? profileImage;
  String? authroizationImage;
  String? profileCity;
  bool isProgress = false;
  bool lastdata = true;
  String? imagenextpage;

  getProfilePersonalInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    dynamic data;
    //   try {
    final response = await http.get(
        Uri.parse('https://api.publish.jobs/api/user-general-get'),
        headers: requestHeaders);
    // .timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
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
        uesrCountryCode = data['country_option'];
        if (uesrCountryCode.isNotEmpty) {
          uesrCountryCode.add(data['country_option'][0]['code']);
        }
        if (data['user_mobile'].toString() != 'null') {
          mobile = (data['user_mobile']['mobile'] ?? 'null');
        }

        mobileCode = data['user_mobile']["country_mob_code"]['code'];
      });
    } else {
      print('failed persnal info error status code: ' +
          response.statusCode.toString());
    }
    // }
    //  catch (e)
    //   {
    //     print(e.toString() + ' personalInfo exception profilebase');
    //   }
  }

  TextEditingController name = TextEditingController();

  // late Future<List<JobseekerEducationModel>> _future;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  bool _hasReachedPoint = false;
  bool isExp = false;
  bool isSkill = false;
  bool isGallery = false;
  bool isSummery = false;
  bool isAchievement = false;
  bool isAssociation = false;
  bool isWorkAuth = false;
  bool isJobPosition = false;
  bool isJobLocation = false;
  bool isJobType = false;
  bool isCareerLvel = false;
  bool isReadyToWork = false;
  dynamic personalInfoData;

  void _onScroll() {
    final s = MediaQuery.of(context).size;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !_hasReachedPoint) {
      _hasReachedPoint = true;
    }
  }

  static Future<List<JobSeekerGalleryModel>>? pereferredJobGallery;
  getPersonalTemp() async {
    await GetPersonalInfoController().jobSeekerPersonalInfo();
  }


  @override
  void initState() {
    getPersonalTemp();
    print(profileImage.toString() + "profile image");
    _scrollController.addListener(_onScroll);
    // _onScroll();
    GlobalVarData.personalInfoFuture = getProfilePersonalInfo();
    Timer(Duration(milliseconds: 3200), () {
      GlobalVarData.pereferredJobTypeListFuture =
          GetPreferredJobTypeController().getJobSeekerPreferredJobType();
    });


    GlobalVarData.pereferredJobSeekerRelocationlist =
        GetRelocationController().getJobRelocation();
    Timer(Duration(milliseconds: 600), () {
      GlobalVarData.objectiveFuture =
          GetObjectController().jobSeekerObjectives();
    });

    GlobalVarData.salaryList = GetSalaryController().jobGetSalary();
    GlobalVarData.resumeList = GetResumeController().GetResume();
    GlobalVarData.MartialListFuture =
        GetJobSeekerMartialStatusController().getJobSeekerMartialStatus();

    Timer(Duration(milliseconds: 900), () {
      GlobalVarData.educationListFuture =
          GetQualificationController().getEducationList();
    });

    Timer(Duration(milliseconds: 1100), () {
      GlobalVarData.experienceListFuture =
          GetExperienceController().getWorkExperienceList();
    });

    Timer(Duration(milliseconds: 1500), () {
      GlobalVarData.skillListFuture = GetJobSkillController().jobSeekerSkill();
    });

    Timer(Duration(milliseconds: 1800), () {
      GlobalVarData.pereferredJobGallery = GetGalleryController().getGallery();
    });

    Timer(Duration(milliseconds: 2100), () {
      GlobalVarData.summeryFuture = GetSummaryController().jobSeekerSummary();
    });

    Timer(Duration(milliseconds: 2400), () {
      GlobalVarData.associationFuture =
          GetJobSeekerAssociationController().jobSeekerAssociation();
    });

    Timer(Duration(milliseconds: 3200), () {
      GlobalVarData.pereferredJobTypeListFuture =
          GetPreferredJobTypeController().getJobSeekerPreferredJobType();
    });

    Timer(Duration(milliseconds: 2600), () {
      GlobalVarData.workAuthListFuture =
          GetWorkAuthorizationController().getJobSeekerWorkAuthorization();
    });

    Timer(Duration(milliseconds: 2600), () {
      GlobalVarData.languageListFuture =
          GetLanguageController().getJobSeekerLanguage();
    });

    Timer(Duration(milliseconds: 2800), () {
      GlobalVarData.pereferredPositionListFuture =
          GetPreferredPositionController().getJobSeekerPreferredPosition();
    });

    Timer(Duration(milliseconds: 3000), () {
      GlobalVarData.preferedJoblocationListFuture =
          GetPreferredJobSeekerLocation().getJobSeekerPreferredJobLocation();
    });

    Timer(Duration(milliseconds: 3200), () {
      GlobalVarData.pereferredJobTypeListFuture =
          GetPreferredJobTypeController().getJobSeekerPreferredJobType();
    });

    Timer(Duration(milliseconds: 900), () {
      GlobalVarData.pereferredJobCareerLevel =
          GetJobSeekerCareerLevelController().getJobSeekerCareerLevel();
    });

    Timer(Duration(milliseconds: 3600), () {
      GlobalVarData.pereferredReadyToWorklist =
          GetReadyToWorkController().getJobReadyToWork();
    });

    Timer(Duration(milliseconds: 600), () {
      GlobalVarData.certificationsListFuture =
          GetCertificationController().jobSeekerCertifications();
    });

    GlobalVarData.genderListFuture =
        GetJobSeekerGenderController().getJobSeekerGender();
    Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        GlobalVarData.objectiveFuture1 =
            GetObjectController().jobSeekerObjectives();
      });

    });
    Timer(Duration(milliseconds: 10500), () {
      setState(() {});
    });
    super.initState();
    this.getDegreesList();
    checkSession();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetQualificationController>(context, listen: false)
          .educationListData
          .clear();

      Provider.of<GetQualificationController>(context, listen: false)
          .getEducationList();

      Provider.of<GetExperienceController>(context, listen: false)
          .workexperienceListData
          .clear();

      Provider.of<GetExperienceController>(context, listen: false)
          .getWorkExperienceList();

      Provider.of<GetJobSkillController>(context, listen: false)
          .skillListData
          .clear();

      Provider.of<GetJobSkillController>(context, listen: false)
          .jobSeekerSkill();

      Provider.of<GetCertificationController>(context, listen: false)
          .certificationsListData
          .clear();

      Provider.of<GetCertificationController>(context, listen: false)
          .jobSeekerCertifications();

      Provider.of<GetJobSeekerCareerLevelController>(context, listen: false)
          .getJobSeekerCareerLevel();

      Provider.of<GetJobSeekerCareerLevelController>(context, listen: false)
          .getJobSeekerCareerLevel();

      Provider.of<GetPreferredJobSeekerLocation>(context, listen: false)
          .preferredJobLocationListData
          .clear();

      Provider.of<GetPreferredJobSeekerLocation>(context, listen: false)
          .getJobSeekerPreferredJobLocation();

      Provider.of<GetWorkAuthorizationController>(context, listen: false)
          .workAuthListData
          .clear();

      Provider.of<GetWorkAuthorizationController>(context, listen: false)
          .getJobSeekerWorkAuthorization();

      Provider.of<GetPreferredPositionController>(context, listen: false)
          .preferredPositionListData
          .clear();

      Provider.of<GetPreferredPositionController>(context, listen: false)
          .getJobSeekerPreferredPosition();

      Provider.of<GetPreferredJobTypeController>(context, listen: false)
          .preferredJobTypeListData
          .clear();

      Provider.of<GetPreferredJobTypeController>(context, listen: false)
          .getJobSeekerPreferredJobType();

      Provider.of<GetLanguageController>(context, listen: false)
          .languageListData
          .clear();

      Provider.of<GetLanguageController>(context, listen: false)
          .getJobSeekerLanguage();

      Provider.of<GetGalleryController>(context, listen: false)
          .galleryListData
          .clear();
      Provider.of<GetGalleryController>(context, listen: false).getGallery();
      Provider.of<GetSalaryController>(context, listen: false).jobGetSalary();
      Provider.of<GetSalaryController>(context, listen: false).jobGetSalary();
      Provider.of<GetObjectController>(context, listen: false)
          .jobSeekerObjectives();
      Provider.of<GetObjectController>(context, listen: false)
          .jobSeekerObjectives();
    });
  }

  bool jobPreferedLocation = false;
  bool jobGallery = false;
  bool workAuthDelete = false;
  bool preferJobPosDlt = false;
  bool preferJobTypeDlt = false;
  bool languageDlt = false;
  bool jobCareerLevel = false;
  bool onclick = false;
  bool deleteCareelLevel = true;
  bool deleteSkillLevel = true;
  bool deleteWorkAuthLevel = true;
  bool deletePositionLevel = true;
  bool deleteJobTypeLevel = true;
  bool deleteJobLocation = true;
  bool deleteJobLanguage = true;
  bool deleteGallery = true;
  TextEditingController aboutController = TextEditingController();
  String? selectedValue = null;
  bool isDark = false;
  String? degreeEducation;
  String? degreeId;
  bool value = false;
  List educationList = [];

  bool isEduUpdate = true;
  bool isExpUpdate = true;
  bool isEduAdd = true;
  bool isExpAdd = true;
  bool skillAdd = true;

  bool isEduDelete = true;

  List educationListData = [];

  Future<String> getDegreesList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String tokenHeader = await pref.getString('tokenProvider').toString();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer ' + tokenHeader
    };
    var res = await http.get(
      Uri.parse('https://api.publish.jobs/api/degrees'),
      headers: requestHeaders,
    );
    var resBody = json.decode(res.body);
    setState(() {
      educationListData = resBody;
    });
    //print(resBody);
    return "Sucess";
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  String? descriptionData;
  String? institutionData;
  String? startDateData;
  String? endDateData;
  String? subjectsListData;
  String? workAuthImage;
  bool tapped = false;

  //reserved
  String? instituteNew;
  String? descriptionNew;
  String? subjectListNew;
  bool deleteDataSkill = false;

  // end
  // DataServices dataServices = DataServices();

  callPersonalInfoAfterUpdation() {
    if (GlobalVarData.personalInfoDataUpdated == 'not null') {
      setState(() {
        GlobalVarData.personalInfoFuture = getProfilePersonalInfo();
        GlobalVarData.personalInfoDataUpdated = 'null';
      });
    }
  }

  final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    callPersonalInfoAfterUpdation();
    if (GlobalVarData.maritalStatus == 'not null') {
      GlobalVarData.MartialListFuture =
          GetJobSeekerMartialStatusController().getJobSeekerMartialStatus();

      GlobalVarData.maritalStatus = 'null';
    }
    if (GlobalVarData.genderStatus == 'not null') {
      GlobalVarData.genderListFuture =
          GetJobSeekerGenderController().getJobSeekerGender();

      GlobalVarData.genderStatus = 'null';
    }
    if (GlobalVarData.careelLevel == 'not null') {
      GlobalVarData.pereferredJobCareerLevel =
          GetJobSeekerCareerLevelController().getJobSeekerCareerLevel();

      GlobalVarData.careelLevel = 'null';
    }
    if (GlobalVarData.addEducation == ' null') {
      GlobalVarData.educationListFuture =
          GetQualificationController().getEducationList();
      GlobalVarData.addEducation = 'null';
    }
    if (GlobalVarData.certificationadd == 'not null') {

      GlobalVarData.certificationsListFuture =
          GetCertificationController().jobSeekerCertifications();

      GlobalVarData.certificationadd = 'null';
    }

    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GlobalVarData.cupertinoSession != 'null'
          ? Scaffold(
              backgroundColor:
                  isDarkMode == true ? Color(0xff343434) : Colors.white,
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: isDarkMode == true
                      ? ColorApp.colornewblack
                      : ColorApp.colorbackground,
                  elevation: 0,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Container(
                        color: isDarkMode == true
                            ? Color(0xff343434)
                            : Colors.white,
                        width: s.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Container(
                                  width: s.width * 0.07,
                                  child: Image.asset('images/appLogo.png')),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : ColorApp.colorblackgalf
                                            .withOpacity(0.2),
                                    elevation: 1,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: isDarkMode == false
                                              ? Colors.white
                                              : ColorApp.colorblackgalf
                                                  .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        width: s.width * 0.095,
                                        height: s.height * 0.043,
                                        child: Icon(
                                          color: Colors.grey,
                                          size: 18,
                                          Icons.notification_add_outlined,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      Scaffold.of(context).openEndDrawer();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Container(
                                        width: s.width * 0.095,
                                        height: s.height * 0.048,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                width: 1, color: Colors.white)),
                                        child: CircleAvatar(
                                          radius: 23,
                                          backgroundImage: profileImage
                                                      .toString() !=
                                                  'null'
                                              ? NetworkImage(
                                                  'https://api.publish.jobs/pjcloud/userAccountImage/' +
                                                      profileImage.toString())
                                              : NetworkImage(
                                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                                          child: Text(""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: s.width * 0.03,
                      right: s.width * 0.03,
                      top: s.height * 0.02),
                  child: Column(
                    children: [
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        color: isDarkMode == false
                            ? Colors.white
                            : ColorApp.colorblackgalf.withOpacity(0.2),
                        elevation: 1,
                        child: Container(
                          width: s.width,
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: GlobalVarData.personalInfoFuture,
                                  builder: (context, snapshot) {
                                    imageLink = '';

                                    // snapshot.data?.userImage!.image
                                    //     .toString() ??
                                    // 'null';

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: s.width,
                                        color: isDarkMode == false
                                            ? Colors.white
                                            : const Color(0xff38373c),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey,
                                          highlightColor: Colors.white30,
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          15, 8, 8, 0),
                                                      child: Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .white)),
                                                        child: CircleAvatar(
                                                          radius: 40,
                                                          backgroundColor:
                                                              AppColors
                                                                  .colorgray,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 25),
                                                              child: Container(
                                                                width: 60.0,
                                                                height: 8.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 3, 0, 1),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 80.0,
                                                                height: 8.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    8, 6, 3, 1),
                                                            child: Container(
                                                              width: 80.0,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    8, 3, 0, 1),
                                                            child: Container(
                                                              width: 80.0,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    8, 3, 0, 1),
                                                            child: Container(
                                                              width: 80.0,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(8, 3,
                                                                    0, 10),
                                                            child: Container(
                                                              width: 80.0,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.none) {
                                      return Center(
                                        child: Text(
                                            'No Internet access on device'),
                                      );
                                    } else {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          showModalBottomSheet(
                                                              backgroundColor:
                                                                  isDarkMode ==
                                                                          false
                                                                      ? Colors
                                                                          .white
                                                                      : const Color(
                                                                          0xff38373c),
                                                              context: context,
                                                              builder:
                                                                  (Context) {
                                                                return Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.2,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              25,
                                                                              15,
                                                                              0,
                                                                              5),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                8,
                                                                            width:
                                                                                45,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                                                                          ),
                                                                          // Text("Please choose an option", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: isDarkMode == false ? AppColors.colordark : Colors.white)),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              //_gitFromCamera();
                                                                              imagePickerFromCamera();
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(9.0),
                                                                                  child: Icon(Icons.camera_alt, color: isDarkMode == false ? AppColors.colordark : Colors.white),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(9.0),
                                                                                  child: Text(
                                                                                    "  Edit Photo With Camera",
                                                                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: isDarkMode == false ? AppColors.colordark : Colors.white),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              imagePickerFromGallery();
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(9.0),
                                                                                  child: Icon(
                                                                                    Icons.image,
                                                                                    color: isDarkMode == false ? AppColors.colordark : Colors.white,
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(9.0),
                                                                                  child: Text(
                                                                                    "  Edit Photo With Gallery",
                                                                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: isDarkMode == false ? AppColors.colordark : Colors.white),
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
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage: profileImage
                                                                      .toString() !=
                                                                  'null'
                                                              ? NetworkImage(
                                                                  'https://api.publish.jobs/pjcloud/userAccountImage/' +
                                                                      profileImage!)
                                                              : NetworkImage(
                                                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                                                          child:
                                                              Stack(children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 8,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white70,
                                                                child: Icon(
                                                                    CupertinoIcons
                                                                        .camera,
                                                                    color: ColorApp
                                                                        .colorprimary,
                                                                    size: 12),
                                                              ),
                                                            ),
                                                          ]),
                                                        ),
                                                      )),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: s.width * 0.02,
                                                        top: s.height * 0.016),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: s.width * 0.56,
                                                          child: Text(
                                                            (firstName.toString() ==
                                                                        'null'
                                                                    ? ''
                                                                    : firstName
                                                                            .toString() +
                                                                        " ") +
                                                                (lastName.toString() ==
                                                                        'null'
                                                                    ? ''
                                                                    : lastName
                                                                            .toString() +
                                                                        " "),
                                                            style: TextStyle(
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : AppColors
                                                                      .colordark,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 1,
                                                                      top: 4),
                                                              child: Text(
                                                                  uesrCountryList
                                                                          .isEmpty
                                                                      ? ''
                                                                      : uesrCountryList[0]
                                                                              [
                                                                              'title']
                                                                          .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: isDarkMode ==
                                                                            true
                                                                        ? Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.9)
                                                                        : AppColors
                                                                            .colordark,
                                                                    fontSize:
                                                                        12,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .email_outlined,
                                                              size: 14,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                      .withOpacity(
                                                                          0.6)
                                                                  : AppColors
                                                                      .colordark,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 6),
                                                              child: Text(
                                                                  email
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: isDarkMode ==
                                                                            true
                                                                        ? Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.6)
                                                                        : AppColors
                                                                            .colordark,
                                                                    fontSize:
                                                                        12,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            if (mobile
                                                                    .toString() ==
                                                                'null') ...[
                                                              Text(""),
                                                            ] else ...[
                                                              Icon(
                                                                Icons
                                                                    .phone_rounded,
                                                                size: 14,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.6)
                                                                    : AppColors
                                                                        .colordark,
                                                              ),
                                                            ],
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 3),
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            3),
                                                                    child: Text(
                                                                        mobileCode.toString() ==
                                                                                'null'
                                                                            ? ""
                                                                            : mobileCode
                                                                                .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          color: isDarkMode == true
                                                                              ? Colors.white.withOpacity(0.6)
                                                                              : AppColors.colordark,
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                  ),
                                                                  Text(
                                                                      mobile.toString() ==
                                                                              'null'
                                                                          ? ''
                                                                          : mobile
                                                                              .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: isDarkMode ==
                                                                                true
                                                                            ? Colors.white.withOpacity(0.6)
                                                                            : AppColors.colordark,
                                                                        fontSize:
                                                                            12,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PersonalInfo(
                                                                            countryCode: mobileCode == ""
                                                                                ? ""
                                                                                : mobileCode,
                                                                            firstName:
                                                                                firstName.toString(),
                                                                            lastName:
                                                                                lastName.toString(),
                                                                            emailAddress:
                                                                                email.toString(),
                                                                            Number:
                                                                                mobile.toString(),
                                                                            countryName: uesrCountryList.isNotEmpty
                                                                                ? uesrCountryList[0]['title'].toString()
                                                                                : 'null',
                                                                            countryId: uesrCountryList.isNotEmpty
                                                                                ? uesrCountryList[0]['id'].toString()
                                                                                : 'null',
                                                                            imageProfile:
                                                                                'https://api.publish.jobs/pjcloud/userAccountImage/' + profileImage.toString(),
                                                                            navDeciderr:
                                                                                '1',
                                                                          )));
                                                        },
                                                        child: Material(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            height: 25,
                                                            width: 33,
                                                            child: Center(
                                                              child: Image.asset(
                                                                  width: 17,
                                                                  height: 16,
                                                                  ImangeAssests
                                                                      .eImage,
                                                                  color: isDarkMode ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : ColorApp
                                                                          .colorblack,
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: s.width * 0.348,
                                                    bottom: 10),
                                                child: FutureBuilder<
                                                        JobSeekerReadyToWorkModel>(
                                                    future: GlobalVarData
                                                        .pereferredReadyToWorklist,
                                                    builder:
                                                        (BuildContext context,
                                                            snapshot) {
                                                      bool readywork = (snapshot
                                                                      .data
                                                                      ?.checked ??
                                                                  'false') ==
                                                              'false'
                                                          ? false
                                                          : true;
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? Colors.white
                                                                : const Color(
                                                                    0xff38373c)),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: Row(
                                                                children: [
                                                                  Consumer<
                                                                      PostReadyToWorkController>(
                                                                    builder:
                                                                        (context,
                                                                            val,
                                                                            child) {
                                                                      return Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 5, bottom: 0),
                                                                            child: readywork == false
                                                                                ? Text(
                                                                                    "I'm not ready to work",
                                                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, color: isDarkMode == true ? ColorApp.colorwhite : ColorApp.colorblack.withOpacity(0.5)),
                                                                                  )
                                                                                : Padding(
                                                                                    padding: const EdgeInsets.only(left: 11),
                                                                                    child: Text(
                                                                                      "I'm  Ready to work",
                                                                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, color: isDarkMode == true ? ColorApp.colorwhite : ColorApp.colorblack.withOpacity(0.5)),
                                                                                    ),
                                                                                  ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 0, left: s.width * 0.020),
                                                                            child: val.loadingWork == false
                                                                                ? FlutterSwitch(
                                                                                    height: s.height * 0.032,
                                                                                    width: s.width * 0.165,
                                                                                    inactiveColor: ColorApp.colorblackgalf,
                                                                                    activeColor: ColorApp.colorprimary,
                                                                                    value: readywork,
                                                                                    onToggle: (value) {
                                                                                      setState(() {
                                                                                        val.jobSeekerReadyToWorkAdd(value.toString(), context);
                                                                                      });
                                                                                      Timer(
                                                                                          Duration(seconds: 1),
                                                                                          () => setState(() {
                                                                                                GlobalVarData.pereferredReadyToWorklist = GetReadyToWorkController().getJobReadyToWork();
                                                                                              }));
                                                                                    },
                                                                                  )
                                                                                : SizedBox(
                                                                                    height: 25,
                                                                                    width: 25,
                                                                                    child: CircularProgressIndicator(),
                                                                                  ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              )
                                            ])
                                          ]));
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: FutureBuilder<JobSeekerObjectiveModel>(
                              future: GlobalVarData.objectiveFuture,
                              builder: (context, snapshot) {
                                String? htmlData =
                                    snapshot.data?.objective.toString() ?? "";
                                final document = parse(htmlData);
                                String objectiveString =
                                    parse(document.body!.text)
                                        .documentElement!
                                        .text
                                        .toString();

                                if (!snapshot.hasData) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.16,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.16,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.data?.objective
                                        .toString() ==
                                    'null') {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : const Color(0xff38373c),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 5, 5, 5),
                                                child: Text(
                                                  AppString.objective,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : ColorApp
                                                              .colorblackgalf,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    //  Get.to(QuillTest());
                                                  },
                                                  child: InkWell(
                                                    onTap: () {
                                                      objective(
                                                          namedata: "Objective",
                                                          aboutId: snapshot
                                                              .data!.id
                                                              .toString(),
                                                          aboutDate:
                                                              objectiveString,
                                                          headerText: AppString
                                                              .editAbout,
                                                          subtitle: AppString
                                                              .editExecutiveSubtitle,
                                                          uniqueData:
                                                              'snapshot.data.objective');
                                                    },
                                                    child: Material(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: 25,
                                                        width: 33,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 5, 5, 5),
                                              child: Text(
                                                AppString.objective,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              child: InkWell(
                                                onTap: () {
                                                  objective(
                                                      namedata: "Objective",
                                                      aboutId: snapshot.data!.id
                                                          .toString(),
                                                      aboutDate:
                                                          objectiveString,
                                                      headerText:
                                                          AppString.editAbout,
                                                      subtitle: AppString
                                                          .editExecutiveSubtitle,
                                                      uniqueData:
                                                          'snapshot.data.objective');
                                                },
                                                child: Material(
                                                  color: isDarkMode == false
                                                      ? ColorApp.colorgray
                                                      : ColorApp.colorblackgalf
                                                          .withOpacity(0.2),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    height: 25,
                                                    width: 33,
                                                    child: Center(
                                                      child: Image.asset(
                                                          width: 17,
                                                          height: 16,
                                                          ImangeAssests.eImage,
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : ColorApp
                                                                  .colorblack,
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 5, 5, 5),
                                                child: ReadMoreText(
                                                  objectiveString,
                                                  trimCollapsedText:
                                                      'Learn more',
                                                  trimExpandedText: 'show'
                                                      ' less',
                                                  moreStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorApp.colorprimary,
                                                  ),
                                                  lessStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorApp.colorprimary,
                                                  ),

                                                  trimLines: 3,
                                                  // preDataText: "AMANDA",
                                                  preDataTextStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  style: TextStyle(
                                                      color: isDarkMode == false
                                                          ? ColorApp
                                                              .colorblackgalf
                                                          : Colors.white70,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  colorClickableText:
                                                      AppColors.colordark,
                                                  trimMode: TrimMode.Line,

                                                  // trimExpandedText: ' show less',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: Consumer<GetQualificationController>(
                              builder: (context, val, child) {
                            if (val.isLoading) {
                              return Container(
                                width: s.width,
                                height: s.height * 0.16,
                                color: isDarkMode == false
                                    ? Colors.white
                                    : const Color(0xff38373c),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white30,
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 10, 5, 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 40.0,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 5, 5, 5),
                                                child: Container(
                                                  width: s.width * 0.94,
                                                  height: 8.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 5, 5, 5),
                                                child: Container(
                                                  width: s.width * 0.94,
                                                  height: 8.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 5, 5, 5),
                                                child: Container(
                                                  width: s.width * 0.94,
                                                  height: 8.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 5, 5, 10),
                                                child: Container(
                                                  width: s.width * 0.94,
                                                  height: 8.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              if (val.educationListData.isEmpty) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppString.education,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : ColorApp.colorblackgalf,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddEducation()));
                                          },
                                          child: Material(
                                            color: isDarkMode == false
                                                ? ColorApp.colorgray
                                                : ColorApp.colorblackgalf
                                                    .withOpacity(0.2),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: isDarkMode == false
                                                    ? ColorApp.colorgray
                                                    : ColorApp.colorblackgalf
                                                        .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              height: 25,
                                              width: 33,
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : ColorApp.colorblack,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppString.education,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                  : ColorApp.colorblackgalf,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 7),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddEducation()));
                                              },
                                              child: Material(
                                                color: isDarkMode == false
                                                    ? ColorApp.colorgray
                                                    : ColorApp.colorblackgalf
                                                        .withOpacity(0.2),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 25,
                                                  width: 33,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : ColorApp.colorblack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: s.width,
                                        child: ListView.builder(
                                            physics: ScrollPhysics(),
                                            itemCount:
                                                val.educationListData.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: ColorApp
                                                                  .colorprimary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            child: Container(
                                                              width: s.width *
                                                                  0.10,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: ColorApp
                                                                        .colorprimary),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(2),
                                                                child: Material(
                                                                  color: ColorApp
                                                                      .colorprimary,
                                                                  elevation: 1,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2)),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .school_outlined,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 10, 8, 0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          val.educationListData[index].degree?.title.toString() ??
                                                                              'no data is shown',
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                14,
                                                                            color: isDarkMode == true
                                                                                ? Colors.white
                                                                                : ColorApp.colornewblack,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          val.educationListData[index]
                                                                              .institute
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: isDarkMode == false ? ColorApp.colorblackgalf : Colors.white70,
                                                                              fontSize: 13),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              '${val.educationListData[index].startYear.toString()} -'
                                                                              ' ${val.educationListData[index].endYear.toString() == "null" ? ' In Progress' : val.educationListData[index].endYear.toString()}',
                                                                              style: TextStyle(color: isDarkMode == false ? ColorApp.colorblackgalf : Colors.white70, fontSize: 13),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        isEduUpdate =
                                                                            true;
                                                                        GlobalVarData.isEducationUpdate ==
                                                                            'done';
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return EditEducation(
                                                                                id: val.educationListData[index].id.toString(),
                                                                                institueUpdateData: val.educationListData[index].institute.toString(),
                                                                                subjectUpdateData: val.educationListData[index].fieldStudy.toString(),
                                                                                descriptionUpdateData: val.educationListData[index].description.toString(),
                                                                                //  educationList: eduList,
                                                                                degreeId: val.educationListData[index].degreeId.toString(),
                                                                                startDate: val.educationListData[index].startYear.toString(),
                                                                                endDate: val.educationListData[index].endYear.toString(),
                                                                                degreeStatus: val.educationListData[index].inProgress,
                                                                                degreeData: val.educationListData[index].degree!.title,
                                                                                navigationDeciderId: '1',
                                                                                // navigationDeciderId: widget.navigationDeciderId,
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                          Material(
                                                                        color: isDarkMode ==
                                                                                false
                                                                            ? ColorApp.colorgray
                                                                            : ColorApp.colorblackgalf.withOpacity(0.2),
                                                                        elevation:
                                                                            0,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5)),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color: isDarkMode == false
                                                                                ? ColorApp.colorgray
                                                                                : ColorApp.colorblackgalf.withOpacity(0.2),
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              33,
                                                                          child:
                                                                              Center(
                                                                            child: Image.asset(
                                                                                width: 17,
                                                                                height: 16,
                                                                                ImangeAssests.eImage,
                                                                                color: isDarkMode == true ? Colors.white : ColorApp.colorblack,
                                                                                fit: BoxFit.fill),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              // Expanded(child: Text("Rawalpidi ,Punjab,Pakistan")),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: Consumer<GetExperienceController>(
                              builder: (context, val, child) {
                            if (val.isLoading) {
                              return Container(
                                width: s.width,
                                height: s.height * 0.20,
                                color: isDarkMode == false
                                    ? Colors.white
                                    : const Color(0xff38373c),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white30,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 5, 5, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 60.0,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 3,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              if (val.workexperienceListData.isEmpty) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppString.experience,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: isDarkMode == true
                                              ? Colors.white
                                              : ColorApp.colorblackgalf,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: InkWell(
                                          onTap: () {
                                            isExpAdd = true;
                                            GlobalVarData.isExperienceAdd ==
                                                'done';

                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AddExperience(
                                                    navDecider: '1',
                                                  );
                                                });
                                          },
                                          child: Material(
                                            color: isDarkMode == false
                                                ? ColorApp.colorgray
                                                : ColorApp.colorblackgalf
                                                    .withOpacity(0.2),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: isDarkMode == false
                                                    ? ColorApp.colorgray
                                                    : ColorApp.colorblackgalf
                                                        .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              height: 25,
                                              width: 33,
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : ColorApp.colorblack,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppString.experience,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                  : ColorApp.colorblackgalf,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 7),
                                            child: InkWell(
                                              onTap: () {
                                                isExpAdd = true;
                                                GlobalVarData.isExperienceAdd ==
                                                    'done';

                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AddExperience(
                                                        navDecider: '1',
                                                      );
                                                    });
                                              },
                                              child: Material(
                                                color: isDarkMode == false
                                                    ? ColorApp.colorgray
                                                    : ColorApp.colorblackgalf
                                                        .withOpacity(0.2),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 25,
                                                  width: 33,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : ColorApp.colorblack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: s.width,
                                        child: ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: val
                                                .workexperienceListData.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: ColorApp
                                                                  .colorprimary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            child: Container(
                                                              width: s.width *
                                                                  0.10,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: ColorApp
                                                                        .colorprimary),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Material(
                                                                  color: ColorApp
                                                                      .colorprimary,
                                                                  elevation: 0,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2)),
                                                                  child:
                                                                      Container(
                                                                    height: 18,
                                                                    width: 28,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            15,
                                                                        height:
                                                                            15,
                                                                        child: Image.asset(
                                                                            ImangeAssests
                                                                                .expIcon,
                                                                            color:
                                                                                ColorApp.colorwhite,
                                                                            fit: BoxFit.fill),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  4, 10, 8, 0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          val.workexperienceListData[index]
                                                                              .title
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                14,
                                                                            color: isDarkMode == true
                                                                                ? Colors.white
                                                                                : ColorApp.colornewblack,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          val.workexperienceListData[index]
                                                                              .company
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: isDarkMode == false ? ColorApp.colorblackgalf : Colors.white70,
                                                                              fontSize: 13),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 0),
                                                                          child:
                                                                              Text(
                                                                            '${val.workexperienceListData[index].startDate.toString() ?? ''} -'
                                                                            ' ${val.workexperienceListData[index].endDate.toString() == "null" ? 'In Progress' : val.workexperienceListData[index].endDate.toString()}',
                                                                            style:
                                                                                TextStyle(color: isDarkMode == false ? ColorApp.colorblackgalf : Colors.white70, fontSize: 13),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        isExpUpdate =
                                                                            true;
                                                                        GlobalVarData.isExperienceUpdate ==
                                                                            'done';
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return EditExperience(
                                                                                id: val.workexperienceListData[index].id.toString(),
                                                                                titleData: val.workexperienceListData[index].title.toString(),
                                                                                companyData: val.workexperienceListData[index].company.toString(),
                                                                                descriptionData: val.workexperienceListData[index].description.toString(),
                                                                                dataUpdateStart: val.workexperienceListData[index].startDate.toString(),
                                                                                dataUpdateEnd: val.workexperienceListData[index].endDate.toString(),
                                                                                inprogressData: val.workexperienceListData[index].currentlyWork.toString(),
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                          Material(
                                                                        color: isDarkMode ==
                                                                                false
                                                                            ? ColorApp.colorgray
                                                                            : ColorApp.colorblackgalf.withOpacity(0.2),
                                                                        elevation:
                                                                            0,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5)),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color: isDarkMode == false
                                                                                ? ColorApp.colorgray
                                                                                : ColorApp.colorblackgalf.withOpacity(0.2),
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              33,
                                                                          child:
                                                                              Center(
                                                                            child: Image.asset(
                                                                                width: 17,
                                                                                height: 16,
                                                                                ImangeAssests.eImage,
                                                                                color: isDarkMode == true ? Colors.white : ColorApp.colorblack,
                                                                                fit: BoxFit.fill),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: Consumer<GetJobSkillController>(
                              builder: (context, val, child) {
                            if (val.isLoading) {
                              return Container(
                                width: s.width,
                                height: s.height * 0.20,
                                color: isDarkMode == false
                                    ? Colors.white
                                    : const Color(0xff38373c),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white30,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 5, 5, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 60.0,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 3,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              if (val.skillListData.isEmpty) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 1),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppString.skill,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 7),
                                                      child: InkWell(
                                                        onTap: () {
                                                          skillAdd = true;
                                                          GlobalVarData
                                                                  .isSkillAdd ==
                                                              'done';
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AddSkill();
                                                              });
                                                        },
                                                        child: Material(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            height: 25,
                                                            width: 33,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colorblack,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 15, 19, 15),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppString.skill,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: isDarkMode == true
                                                    ? Colors.white
                                                    : ColorApp.colorblackgalf,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        deleteDataSkill =
                                                            deleteDataSkill
                                                                ? false
                                                                : true;
                                                      });
                                                    },
                                                    child: Material(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: 25,
                                                        width: 33,
                                                        child: Center(
                                                          child: Image.asset(
                                                              width: 17,
                                                              height: 16,
                                                              ImangeAssests
                                                                  .dltImage,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colorblack,
                                                              fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: InkWell(
                                                    onTap: () {
                                                      skillAdd = true;
                                                      GlobalVarData
                                                              .isSkillAdd ==
                                                          'done';
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AddSkill();
                                                          });
                                                    },
                                                    child: Material(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: 25,
                                                        width: 33,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: deleteSkillLevel == true
                                                ? GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    gridDelegate:
                                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                                      // padding: const EdgeInsets.all(10),
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 0,
                                                      maxCrossAxisExtent: 180.0,

                                                      childAspectRatio: 3,
                                                    ),
                                                    itemCount: val
                                                        .skillListData.length,
                                                    itemBuilder:
                                                        (BuildContext ctx,
                                                            index) {
                                                      return Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: ColorApp
                                                                          .colorprimary,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(2),
                                                                    child:
                                                                        Container(
                                                                      width: s.width *
                                                                          0.10,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(3),
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                ColorApp.colorprimary),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(2),
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              ColorApp.colorprimary,
                                                                          elevation:
                                                                              1,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                18,
                                                                            width:
                                                                                28,
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                width: 15,
                                                                                height: 15,
                                                                                child: Image.asset(ImangeAssests.skillImage, color: ColorApp.colorwhite, fit: BoxFit.fill),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  val
                                                                      .skillListData[
                                                                          index]
                                                                      .title
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    color: isDarkMode ==
                                                                            true
                                                                        ? Colors
                                                                            .white
                                                                        : ColorApp
                                                                            .colornewblack,
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  SkillDeleteAlert(
                                                                      context,
                                                                      val
                                                                          .skillListData[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      "Delete Skills ?",
                                                                      "this wil delete from all section of you",
                                                                      "profile",
                                                                      "profileSkillDelete",
                                                                      val
                                                                          .skillListData[
                                                                              index]
                                                                          .title
                                                                          .toString());
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 0),
                                                                  child:
                                                                      Visibility(
                                                                          visible:
                                                                              deleteDataSkill,
                                                                          child:
                                                                              Container(
                                                                            color: tapped
                                                                                ? Colors.red.withOpacity(0.5)
                                                                                : Colors.white,
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              color: AppColors.colorred,
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    })
                                                : ProgressLoading(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Material(
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 15, 5, 5),
                                    child: Text(
                                      AppString.downloaded,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : ColorApp.colorblackgalf,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, top: 5),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddResume()));
                                      },
                                      child: Material(
                                        color: isDarkMode == false
                                            ? ColorApp.colorgray
                                            : ColorApp.colorblackgalf
                                                .withOpacity(0.2),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: isDarkMode == false
                                                ? ColorApp.colorgray
                                                : ColorApp.colorblackgalf
                                                    .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          height: 25,
                                          width: 33,
                                          child: Center(
                                            child: Icon(
                                              Icons.print_outlined,
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                  : ColorApp.colorblack,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 8, bottom: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorApp.colorprimary,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: s.width * 0.10,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: ColorApp.colorprimary),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Material(
                                                color: ColorApp.colorprimary,
                                                elevation: 1,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2)),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.arrow_circle_down,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Download pdf",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: isDarkMode == true
                                            ? Colors.white
                                            : ColorApp.colornewblack,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Column(
                          children: [
                            Material(
                              elevation: 1,
                              color: isDarkMode == false
                                  ? Colors.white
                                  : ColorApp.colorblackgalf.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: FutureBuilder<JobSeekerCareerLevelModel>(
                                  future:
                                      GlobalVarData.pereferredJobCareerLevel,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container(
                                        width: s.width,
                                        height: s.height * 0.16,
                                        color: isDarkMode == false
                                            ? Colors.white
                                            : const Color(0xff38373c),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey,
                                          highlightColor: Colors.white30,
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 10, 5, 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 40.0,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 5, 5, 5),
                                                        child: Container(
                                                          width: s.width * 0.94,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 5, 5, 5),
                                                        child: Container(
                                                          width: s.width * 0.94,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 5, 5, 5),
                                                        child: Container(
                                                          width: s.width * 0.94,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 5, 5, 10),
                                                        child: Container(
                                                          width: s.width * 0.94,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: s.width,
                                        height: s.height * 0.16,
                                        color: isDarkMode == false
                                            ? Colors.white
                                            : const Color(0xff38373c),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey,
                                          highlightColor: Colors.white30,
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 10, 5, 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 40.0,
                                                              height: 8.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 5, 5, 5),
                                                        child: Container(
                                                          width: s.width * 0.94,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 5, 5, 5),
                                                        child: Container(
                                                          width: s.width * 0.94,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 5, 5, 5),
                                                        child: Container(
                                                          width: s.width * 0.94,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 5, 5, 10),
                                                        child: Container(
                                                          width: s.width * 0.94,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.data?.title
                                            .toString() ==
                                        'null') {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppString.careerLevel,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 4,
                                                              bottom: 5),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      100), () {
                                                            setState(() {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          AddCareerLevel(
                                                                            navigationDeciderId:
                                                                                '1',
                                                                          )));
                                                            });
                                                          });
                                                        },
                                                        child: Material(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            height: 25,
                                                            width: 33,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colorblack,
                                                              ),
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
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 15, 15),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3),
                                                child: Text(
                                                  AppString.careerLevel,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          setState(() {
                                                            jobCareerLevel =
                                                                jobCareerLevel
                                                                    ? false
                                                                    : true;
                                                          });
                                                        });
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Image.asset(
                                                                width: 17,
                                                                height: 16,
                                                                ImangeAssests
                                                                    .dltImage,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colorblack,
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // GestureDetector(
                                                  //   onTap: () {
                                                  //     Future.delayed(
                                                  //         Duration(
                                                  //             milliseconds:
                                                  //                 100), () {
                                                  //       setState(() {
                                                  //         jobCareerLevel =
                                                  //             jobCareerLevel
                                                  //                 ? false
                                                  //                 : true;
                                                  //       });
                                                  //     });
                                                  //   },
                                                  //   child: Padding(
                                                  //     padding:
                                                  //         const EdgeInsets.only(
                                                  //             right: 10),
                                                  //     child: Material(
                                                  //       color: isDarkMode ==
                                                  //               false
                                                  //           ? ColorApp.colorgray
                                                  //           : const Color(
                                                  //               0xff38373c),
                                                  //       elevation: 1,
                                                  //       shape:
                                                  //           RoundedRectangleBorder(
                                                  //               borderRadius:
                                                  //                   BorderRadius
                                                  //                       .circular(
                                                  //                           5)),
                                                  //       child: Container(
                                                  //         height: 18,
                                                  //         width: 28,
                                                  //         child: Center(
                                                  //           child: Container(
                                                  //             width: 15,
                                                  //             height: 15,
                                                  //             child: Image.asset(
                                                  //                 ImangeAssests
                                                  //                     .dltImage,
                                                  //                 color: isDarkMode ==
                                                  //                         true
                                                  //                     ? ColorApp
                                                  //                         .colorwhite
                                                  //                     : Colors
                                                  //                         .black,
                                                  //                 fit: BoxFit
                                                  //                     .fill),
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            bottom: 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          setState(() {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AddCareerLevel(
                                                                              navigationDeciderId: '1',
                                                                            )));
                                                          });
                                                        });
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colorblack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 1),
                                            child: deleteCareelLevel == true
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 5,
                                                                    left: 3,
                                                                    bottom: 5),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: ColorApp
                                                                      .colorprimary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(2),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      s.width *
                                                                          0.10,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: ColorApp
                                                                            .colorprimary),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(2),
                                                                    child:
                                                                        Material(
                                                                      color: ColorApp
                                                                          .colorprimary,
                                                                      elevation:
                                                                          1,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(2)),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .timeline_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: Text(
                                                              snapshot
                                                                  .data!.title
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colornewblack,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              SkillDeleteAlert(
                                                                  context,
                                                                  snapshot
                                                                      .data!.id
                                                                      .toString(),
                                                                  "Delete Careel Level",
                                                                  "this wil delete from all section of you",
                                                                  "profile",
                                                                  "profileCareerLavelDelete",
                                                                  snapshot.data!
                                                                      .title
                                                                      .toString());
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          20),
                                                              child: Visibility(
                                                                  visible:
                                                                      jobCareerLevel,
                                                                  child:
                                                                      Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                              .red[
                                                                          100],
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        size:
                                                                            18,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : ProgressLoading(),
                                          )
                                        ]),
                                      );
                                    }
                                  }),
                              //     Consumer<GetJobSeekerCareerLevelController>(
                              //         builder: (context, val, child) {
                              //   if (val.isLoadingCareer) {
                              //     return Container(
                              //       width: s.width,
                              //       height: s.height * 0.20,
                              //       color: isDarkMode == false
                              //           ? Colors.white
                              //           : const Color(0xff38373c),
                              //       child: Shimmer.fromColors(
                              //         baseColor: Colors.grey,
                              //         highlightColor: Colors.white30,
                              //         child: Container(
                              //           child: Column(
                              //             children: [
                              //               Padding(
                              //                 padding:
                              //                     const EdgeInsets.fromLTRB(
                              //                         8, 5, 5, 5),
                              //                 child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceBetween,
                              //                   children: [
                              //                     Container(
                              //                       width: 60.0,
                              //                       height: 8.0,
                              //                       color: Colors.white,
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               Row(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             left: 8),
                              //                     child: Container(
                              //                       width: 48.0,
                              //                       height: 48.0,
                              //                       decoration: BoxDecoration(
                              //                           color: Colors.white,
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(4)),
                              //                     ),
                              //                   ),
                              //                   const Padding(
                              //                     padding: EdgeInsets.symmetric(
                              //                         horizontal: 8.0),
                              //                   ),
                              //                   Expanded(
                              //                     child: Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       children: <Widget>[
                              //                         Container(
                              //                           width: s.width * 0.4,
                              //                           height: 8.0,
                              //                           color: Colors.white,
                              //                         ),
                              //                         const Padding(
                              //                           padding: EdgeInsets
                              //                               .symmetric(
                              //                                   vertical: 2.0),
                              //                         ),
                              //                         Container(
                              //                           width: s.width * 0.6,
                              //                           height: 8.0,
                              //                           color: Colors.white,
                              //                         ),
                              //                         const Padding(
                              //                           padding: EdgeInsets
                              //                               .symmetric(
                              //                                   vertical: 2.0),
                              //                         ),
                              //                         Container(
                              //                           width: s.width * 0.7,
                              //                           height: 8.0,
                              //                           color: Colors.white,
                              //                         ),
                              //                         const Padding(
                              //                           padding: EdgeInsets
                              //                               .symmetric(
                              //                                   vertical: 2.0),
                              //                         ),
                              //                         Container(
                              //                           width: s.width * 0.4,
                              //                           height: 15.0,
                              //                           color: Colors.white,
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //               Divider(
                              //                 height: 3,
                              //               ),
                              //               Row(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             left: 8),
                              //                     child: Container(
                              //                       width: 48.0,
                              //                       height: 48.0,
                              //                       decoration: BoxDecoration(
                              //                           color: Colors.white,
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(4)),
                              //                     ),
                              //                   ),
                              //                   const Padding(
                              //                     padding: EdgeInsets.symmetric(
                              //                         horizontal: 8.0),
                              //                   ),
                              //                   Expanded(
                              //                     child: Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       children: <Widget>[
                              //                         Container(
                              //                           width: s.width * 0.4,
                              //                           height: 8.0,
                              //                         ),
                              //                         const Padding(
                              //                           padding: EdgeInsets
                              //                               .symmetric(
                              //                                   vertical: 2.0),
                              //                         ),
                              //                         Container(
                              //                           width: s.width * 0.6,
                              //                           height: 8.0,
                              //                           color: Colors.white,
                              //                         ),
                              //                         const Padding(
                              //                           padding: EdgeInsets
                              //                               .symmetric(
                              //                                   vertical: 2.0),
                              //                         ),
                              //                         Container(
                              //                           width: s.width * 0.7,
                              //                           height: 8.0,
                              //                           color: Colors.white,
                              //                         ),
                              //                         const Padding(
                              //                           padding: EdgeInsets
                              //                               .symmetric(
                              //                                   vertical: 2.0),
                              //                         ),
                              //                         Container(
                              //                           width: s.width * 0.4,
                              //                           height: 8.0,
                              //                           color: Colors.white,
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   } else {
                              //     if (val.careerLevelListData.isEmpty) {
                              //       return Padding(
                              //         padding: const EdgeInsets.fromLTRB(
                              //             10, 10, 10, 10),
                              //         child: Column(
                              //           children: [
                              //             Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text(
                              //                   AppString.careerLevel,
                              //                   style: TextStyle(
                              //                     fontSize: 17,
                              //                     color: isDarkMode == true
                              //                         ? Colors.white
                              //                         : ColorApp.colorblackgalf,
                              //                     fontWeight: FontWeight.w500,
                              //                   ),
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               right: 4,
                              //                               bottom: 5),
                              //                       child: InkWell(
                              //                         onTap: () {
                              //                           Future.delayed(
                              //                               Duration(
                              //                                   milliseconds:
                              //                                       100), () {
                              //                             setState(() {
                              //                               Navigator.push(
                              //                                   context,
                              //                                   MaterialPageRoute(
                              //                                       builder:
                              //                                           (context) =>
                              //                                               AddCareerLevel(
                              //                                                 navigationDeciderId: '1',
                              //                                               )));
                              //                             });
                              //                           });
                              //                         },
                              //                         child: Material(
                              //                           color: isDarkMode ==
                              //                                   false
                              //                               ? ColorApp.colorgray
                              //                               : ColorApp
                              //                                   .colorblackgalf
                              //                                   .withOpacity(
                              //                                       0.2),
                              //                           elevation: 0,
                              //                           shape:
                              //                               RoundedRectangleBorder(
                              //                                   borderRadius:
                              //                                       BorderRadius
                              //                                           .circular(
                              //                                               5)),
                              //                           child: Container(
                              //                             decoration:
                              //                                 BoxDecoration(
                              //                               color: isDarkMode ==
                              //                                       false
                              //                                   ? ColorApp
                              //                                       .colorgray
                              //                                   : ColorApp
                              //                                       .colorblackgalf
                              //                                       .withOpacity(
                              //                                           0.2),
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           5),
                              //                             ),
                              //                             height: 25,
                              //                             width: 33,
                              //                             child: Center(
                              //                               child: Icon(
                              //                                 Icons.add,
                              //                                 color: isDarkMode ==
                              //                                         true
                              //                                     ? Colors.white
                              //                                     : ColorApp
                              //                                         .colorblack,
                              //                               ),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     } else {
                              //       return Padding(
                              //         padding: const EdgeInsets.fromLTRB(
                              //             10, 10, 15, 15),
                              //         child: Column(
                              //           children: [
                              //             Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(
                              //                       bottom: 3),
                              //                   child: Text(
                              //                     AppString.careerLevel,
                              //                     style: TextStyle(
                              //                       fontSize: 17,
                              //                       color: isDarkMode == true
                              //                           ? Colors.white
                              //                           : ColorApp
                              //                               .colorblackgalf,
                              //                       fontWeight: FontWeight.w500,
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               right: 8),
                              //                       child: InkWell(
                              //                         onTap: () {
                              //                           Future.delayed(
                              //                               Duration(
                              //                                   milliseconds:
                              //                                       100), () {
                              //                             setState(() {
                              //                               jobCareerLevel =
                              //                                   jobCareerLevel
                              //                                       ? false
                              //                                       : true;
                              //                             });
                              //                           });
                              //                         },
                              //                         child: Material(
                              //                           color: isDarkMode ==
                              //                                   false
                              //                               ? ColorApp.colorgray
                              //                               : ColorApp
                              //                                   .colorblackgalf
                              //                                   .withOpacity(
                              //                                       0.2),
                              //                           elevation: 0,
                              //                           shape:
                              //                               RoundedRectangleBorder(
                              //                                   borderRadius:
                              //                                       BorderRadius
                              //                                           .circular(
                              //                                               5)),
                              //                           child: Container(
                              //                             decoration:
                              //                                 BoxDecoration(
                              //                               color: isDarkMode ==
                              //                                       false
                              //                                   ? ColorApp
                              //                                       .colorgray
                              //                                   : ColorApp
                              //                                       .colorblackgalf
                              //                                       .withOpacity(
                              //                                           0.2),
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           5),
                              //                             ),
                              //                             height: 25,
                              //                             width: 33,
                              //                             child: Center(
                              //                               child: Image.asset(
                              //                                   width: 17,
                              //                                   height: 16,
                              //                                   ImangeAssests
                              //                                       .dltImage,
                              //                                   color: isDarkMode ==
                              //                                           true
                              //                                       ? Colors
                              //                                           .white
                              //                                       : ColorApp
                              //                                           .colorblack,
                              //                                   fit: BoxFit
                              //                                       .fill),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                     // GestureDetector(
                              //                     //   onTap: () {
                              //                     //     Future.delayed(
                              //                     //         Duration(
                              //                     //             milliseconds:
                              //                     //                 100), () {
                              //                     //       setState(() {
                              //                     //         jobCareerLevel =
                              //                     //             jobCareerLevel
                              //                     //                 ? false
                              //                     //                 : true;
                              //                     //       });
                              //                     //     });
                              //                     //   },
                              //                     //   child: Padding(
                              //                     //     padding:
                              //                     //         const EdgeInsets.only(
                              //                     //             right: 10),
                              //                     //     child: Material(
                              //                     //       color: isDarkMode ==
                              //                     //               false
                              //                     //           ? ColorApp.colorgray
                              //                     //           : const Color(
                              //                     //               0xff38373c),
                              //                     //       elevation: 1,
                              //                     //       shape:
                              //                     //           RoundedRectangleBorder(
                              //                     //               borderRadius:
                              //                     //                   BorderRadius
                              //                     //                       .circular(
                              //                     //                           5)),
                              //                     //       child: Container(
                              //                     //         height: 18,
                              //                     //         width: 28,
                              //                     //         child: Center(
                              //                     //           child: Container(
                              //                     //             width: 15,
                              //                     //             height: 15,
                              //                     //             child: Image.asset(
                              //                     //                 ImangeAssests
                              //                     //                     .dltImage,
                              //                     //                 color: isDarkMode ==
                              //                     //                         true
                              //                     //                     ? ColorApp
                              //                     //                         .colorwhite
                              //                     //                     : Colors
                              //                     //                         .black,
                              //                     //                 fit: BoxFit
                              //                     //                     .fill),
                              //                     //           ),
                              //                     //         ),
                              //                     //       ),
                              //                     //     ),
                              //                     //   ),
                              //                     // ),
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets.only(
                              //                               right: 0,
                              //                               bottom: 0),
                              //                       child: InkWell(
                              //                         onTap: () {
                              //                           Future.delayed(
                              //                               Duration(
                              //                                   milliseconds:
                              //                                       100), () {
                              //                             setState(() {
                              //                               Navigator.push(
                              //                                   context,
                              //                                   MaterialPageRoute(
                              //                                       builder:
                              //                                           (context) =>
                              //                                               AddCareerLevel(
                              //                                                 navigationDeciderId: '1',
                              //                                               )));
                              //                             });
                              //                           });
                              //                         },
                              //                         child: Material(
                              //                           color: isDarkMode ==
                              //                                   false
                              //                               ? ColorApp.colorgray
                              //                               : ColorApp
                              //                                   .colorblackgalf
                              //                                   .withOpacity(
                              //                                       0.2),
                              //                           elevation: 0,
                              //                           shape:
                              //                               RoundedRectangleBorder(
                              //                                   borderRadius:
                              //                                       BorderRadius
                              //                                           .circular(
                              //                                               5)),
                              //                           child: Container(
                              //                             decoration:
                              //                                 BoxDecoration(
                              //                               color: isDarkMode ==
                              //                                       false
                              //                                   ? ColorApp
                              //                                       .colorgray
                              //                                   : ColorApp
                              //                                       .colorblackgalf
                              //                                       .withOpacity(
                              //                                           0.2),
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           5),
                              //                             ),
                              //                             height: 25,
                              //                             width: 33,
                              //                             child: Center(
                              //                               child: Icon(
                              //                                 Icons.add,
                              //                                 color: isDarkMode ==
                              //                                         true
                              //                                     ? Colors.white
                              //                                     : ColorApp
                              //                                         .colorblack,
                              //                               ),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ],
                              //             ),
                              //             ListView.builder(
                              //                 physics: ScrollPhysics(),
                              //                 shrinkWrap: true,
                              //                 itemCount: val
                              //                     .careerLevelListData.length,
                              //                 itemBuilder: (contex, index) {
                              //                   return Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             top: 1),
                              //                     child:
                              //                         deleteCareelLevel == true
                              //                             ? Column(
                              //                                 children: [
                              //                                   Row(
                              //                                     children: [
                              //                                       Padding(
                              //                                         padding: const EdgeInsets
                              //                                                 .only(
                              //                                             right:
                              //                                                 5,
                              //                                             left:
                              //                                                 3,
                              //                                             bottom:
                              //                                                 5),
                              //                                         child:
                              //                                             Container(
                              //                                           decoration: BoxDecoration(
                              //                                               color:
                              //                                                   ColorApp.colorprimary,
                              //                                               borderRadius: BorderRadius.circular(4)),
                              //                                           child:
                              //                                               Padding(
                              //                                             padding:
                              //                                                 const EdgeInsets.all(2),
                              //                                             child:
                              //                                                 Container(
                              //                                               width:
                              //                                                   s.width * 0.10,
                              //                                               height:
                              //                                                   30,
                              //                                               decoration:
                              //                                                   BoxDecoration(
                              //                                                 borderRadius: BorderRadius.circular(3),
                              //                                                 color: Colors.white,
                              //                                                 border: Border.all(color: ColorApp.colorprimary),
                              //                                               ),
                              //                                               child:
                              //                                                   Padding(
                              //                                                 padding: EdgeInsets.all(2),
                              //                                                 child: Material(
                              //                                                   color: ColorApp.colorprimary,
                              //                                                   elevation: 1,
                              //                                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                              //                                                   child: Center(
                              //                                                     child: Icon(
                              //                                                       Icons.timeline_outlined,
                              //                                                       color: Colors.white,
                              //                                                     ),
                              //                                                   ),
                              //                                                 ),
                              //                                               ),
                              //                                             ),
                              //                                           ),
                              //                                         ),
                              //                                       ),
                              //                                       Padding(
                              //                                         padding: const EdgeInsets
                              //                                                 .only(
                              //                                             left:
                              //                                                 10),
                              //                                         child:
                              //                                             Text(
                              //                                           val.careerLevelListData[index]
                              //                                               .title
                              //                                               .toString(),
                              //                                           style:
                              //                                               TextStyle(
                              //                                             fontWeight:
                              //                                                 FontWeight.w500,
                              //                                             fontSize:
                              //                                                 12,
                              //                                             color: isDarkMode == true
                              //                                                 ? Colors.white
                              //                                                 : ColorApp.colornewblack,
                              //                                           ),
                              //                                         ),
                              //                                       ),
                              //                                       GestureDetector(
                              //                                         onTap:
                              //                                             () {
                              //                                           SkillDeleteAlert(
                              //                                               context,
                              //                                               val.careerLevelListData[index].id.toString(),
                              //                                               "Delete Careel Level",
                              //                                               "this wil delete from all section of you",
                              //                                               "profile",
                              //                                               "profileCareerLavelDelete",
                              //                                               val.careerLevelListData[index].title.toString());
                              //                                         },
                              //                                         child:
                              //                                             Padding(
                              //                                           padding:
                              //                                               const EdgeInsets.only(right: 20),
                              //                                           child: Visibility(
                              //                                               visible: jobCareerLevel,
                              //                                               child: Container(
                              //                                                 height: 20,
                              //                                                 width: 20,
                              //                                                 decoration: BoxDecoration(
                              //                                                   color: Colors.red[100],
                              //                                                 ),
                              //                                                 child: Center(
                              //                                                   child: Icon(
                              //                                                     Icons.clear,
                              //                                                     size: 18,
                              //                                                     color: Colors.red,
                              //                                                   ),
                              //                                                 ),
                              //                                               )),
                              //                                         ),
                              //                                       ),
                              //                                     ],
                              //                                   ),
                              //                                 ],
                              //                               )
                              //                             : ProgressLoading(),
                              //                   );
                              //                 }),
                              //           ],
                              //         ),
                              //       );
                              //       ;
                              //     }
                              //   }
                              // }),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Column(
                          children: [
                            Material(
                              elevation: 1,
                              color: isDarkMode == false
                                  ? Colors.white
                                  : ColorApp.colorblackgalf.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Consumer<GetGalleryController>(
                                  builder: (context, val, child) {
                                if (val.isGetGalleryLoading) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.20,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 5, 5, 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 60.0,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Container(
                                                    width: 48.0,
                                                    height: 48.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: s.width * 0.4,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.6,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.7,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.4,
                                                        height: 15.0,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 3,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Container(
                                                    width: 48.0,
                                                    height: 48.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: s.width * 0.4,
                                                        height: 8.0,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.6,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.7,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.4,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  if (val.galleryListData.isEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 14, 10),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 0),
                                                    child: Text(
                                                      "Your Profile Gallery",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: isDarkMode ==
                                                                true
                                                            ? Colors.white
                                                            : ColorApp
                                                                .colorblackgalf,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0,
                                                                bottom: 5),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Future.delayed(
                                                                Duration(
                                                                    milliseconds:
                                                                        100),
                                                                () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              AddGalleryImage()));
                                                            });
                                                          },
                                                          child: Material(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            elevation: 0,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: isDarkMode == false
                                                                    ? ColorApp
                                                                        .colorgray
                                                                    : ColorApp
                                                                        .colorblackgalf
                                                                        .withOpacity(
                                                                            0.2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              height: 25,
                                                              width: 33,
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: isDarkMode ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : ColorApp
                                                                          .colorblack,
                                                                ),
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
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 8, 17, 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3),
                                                child: Text(
                                                  "Your Profile Gallery",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          setState(() {
                                                            jobGallery =
                                                                jobGallery
                                                                    ? false
                                                                    : true;
                                                          });
                                                        });
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Image.asset(
                                                                width: 17,
                                                                height: 16,
                                                                ImangeAssests
                                                                    .dltImage,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colorblack,
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            bottom: 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AddGalleryImage()));
                                                        });
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colorblack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Choose or upload your image your Liked.",
                                                  style: TextStyle(
                                                      color: isDarkMode == false
                                                          ? ColorApp
                                                              .colorblackgalf
                                                          : Colors.white70,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: deleteGallery == true
                                                    ? GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        padding:
                                                            EdgeInsets.zero,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        gridDelegate:
                                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              100,
                                                          crossAxisSpacing: 8,
                                                          mainAxisSpacing: 4,
                                                        ),
                                                        itemCount: val
                                                            .galleryListData
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext ctx,
                                                                index) {
                                                          return Container(
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: Colors.amber,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                12),
                                                                        border: Border.all(
                                                                            color: AppColors
                                                                                .colorpurpal)),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      child:
                                                                          Image(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: NetworkImage(
                                                                            '${Constants.imageBaseUrl}${val.galleryListData[index].image}'),
                                                                      ),
                                                                    )),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 8,
                                                                      bottom:
                                                                          0),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        SkillDeleteAlert(
                                                                            context,
                                                                            val.galleryListData[index].id.toString(),
                                                                            "Delete from Gallery",
                                                                            "this wil delete from all section of you",
                                                                            "profile",
                                                                            "profileGalleryDelete",
                                                                            "Gallery");
                                                                      },
                                                                      child: Visibility(
                                                                          visible: jobGallery,
                                                                          child: Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                20,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.red[100],
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Icon(
                                                                                Icons.clear,
                                                                                size: 18,
                                                                                color: Colors.red,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        })
                                                    : ProgressLoading(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }),

                              //  FutureBuilder<List<JobSeekerGalleryModel>>(
                              //   future: GlobalVarData.pereferredJobGallery,
                              //   builder: (context, snapshot) {
                              //     if (!snapshot.hasData) {
                              //       return Container(
                              //         color: isDarkMode == false
                              //             ? Colors.white
                              //             : const Color(0xff38373c),
                              //         child: Shimmer.fromColors(
                              //           baseColor: Colors.grey,
                              //           highlightColor: Colors.white30,
                              //           child: Container(
                              //             child: Padding(
                              //               padding: const EdgeInsets.only(
                              //                   left: 8, right: 8),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: [
                              //                   Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             left: 5,
                              //                             top: 20,
                              //                             bottom: 7),
                              //                     child: Container(
                              //                       width: 48.0,
                              //                       height: 48.0,
                              //                       decoration: BoxDecoration(
                              //                           color: Colors.white,
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(4)),
                              //                     ),
                              //                   ),
                              //                   Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             left: 5,
                              //                             top: 20,
                              //                             bottom: 7),
                              //                     child: Container(
                              //                       width: 48.0,
                              //                       height: 48.0,
                              //                       decoration: BoxDecoration(
                              //                           color: Colors.white,
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(4)),
                              //                     ),
                              //                   ),
                              //                   Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             left: 5,
                              //                             top: 20,
                              //                             bottom: 7),
                              //                     child: Container(
                              //                       width: 48.0,
                              //                       height: 48.0,
                              //                       decoration: BoxDecoration(
                              //                           color: Colors.white,
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(4)),
                              //                     ),
                              //                   ),
                              //                   Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             left: 5,
                              //                             top: 20,
                              //                             bottom: 7),
                              //                     child: Container(
                              //                       width: 48.0,
                              //                       height: 48.0,
                              //                       decoration: BoxDecoration(
                              //                           color: Colors.white,
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(4)),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     } else if (snapshot!.data?.isEmpty ?? false) {
                              //       return Padding(
                              //         padding: const EdgeInsets.fromLTRB(
                              //             4, 10, 10, 5),
                              //         child: Column(
                              //           children: [
                              //             Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Column(
                              //                 children: [
                              //                   Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             bottom: 10),
                              //                     child: Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceBetween,
                              //                       children: [
                              //                         Padding(
                              //                           padding:
                              //                               const EdgeInsets
                              //                                       .only(
                              //                                   bottom: 3),
                              //                           child: Text(
                              //                             "Your Profile Gallery",
                              //                             style: TextStyle(
                              //                               fontSize: 17,
                              //                               color: isDarkMode ==
                              //                                       true
                              //                                   ? Colors.white
                              //                                   : ColorApp
                              //                                       .colorblackgalf,
                              //                               fontWeight:
                              //                                   FontWeight.w500,
                              //                             ),
                              //                           ),
                              //                         ),
                              //                         Row(
                              //                           children: [
                              //                             Material(
                              //                               elevation: 1,
                              //                               shape: RoundedRectangleBorder(
                              //                                   borderRadius:
                              //                                       BorderRadius
                              //                                           .circular(
                              //                                               5.0)),
                              //                               color: isDarkMode ==
                              //                                       false
                              //                                   ? ColorApp
                              //                                       .colorgray
                              //                                   : const Color(
                              //                                       0xff38373c),
                              //                               child: EffectButton(
                              //                                 Ontap: () {
                              //                                   Future.delayed(
                              //                                       Duration(
                              //                                           milliseconds:
                              //                                               100),
                              //                                       () {
                              //                                     Navigator.push(
                              //                                         context,
                              //                                         MaterialPageRoute(
                              //                                             builder: (context) =>
                              //                                                 AddGalleryImage()));
                              //                                   });
                              //                                 },
                              //                                 icon: Icons.add,
                              //                                 color: isDarkMode ==
                              //                                         false
                              //                                     ? Colors
                              //                                         .black87
                              //                                     : Colors
                              //                                         .white,
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     } else {
                              //       return Padding(
                              //         padding: const EdgeInsets.fromLTRB(
                              //             8, 8, 17, 8),
                              //         child: Column(
                              //           children: [
                              //             Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(
                              //                       bottom: 3),
                              //                   child: Text(
                              //                     "Your Profile Gallery",
                              //                     style: TextStyle(
                              //                       fontSize: 17,
                              //                       color: isDarkMode == true
                              //                           ? Colors.white
                              //                           : ColorApp
                              //                               .colorblackgalf,
                              //                       fontWeight: FontWeight.w500,
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     InkWell(
                              //                       onTap: () {
                              //                         Future.delayed(
                              //                             Duration(
                              //                                 milliseconds:
                              //                                     100), () {
                              //                           setState(() {
                              //                             jobGallery =
                              //                                 jobGallery
                              //                                     ? false
                              //                                     : true;
                              //                           });
                              //                         });
                              //                       },
                              //                       child: Padding(
                              //                         padding:
                              //                             const EdgeInsets.only(
                              //                                 right: 10),
                              //                         child: Material(
                              //                           color: isDarkMode ==
                              //                                   false
                              //                               ? ColorApp.colorgray
                              //                               : const Color(
                              //                                   0xff38373c),
                              //                           elevation: 1,
                              //                           shape:
                              //                               RoundedRectangleBorder(
                              //                                   borderRadius:
                              //                                       BorderRadius
                              //                                           .circular(
                              //                                               5)),
                              //                           child: Container(
                              //                             height: 18,
                              //                             width: 28,
                              //                             child: Center(
                              //                               child: Container(
                              //                                 width: 15,
                              //                                 height: 15,
                              //                                 child: Image.asset(
                              //                                     ImangeAssests
                              //                                         .dltImage,
                              //                                     color: isDarkMode ==
                              //                                             true
                              //                                         ? ColorApp
                              //                                             .colorwhite
                              //                                         : Colors
                              //                                             .black,
                              //                                     fit: BoxFit
                              //                                         .fill),
                              //                               ),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                     Material(
                              //                       elevation: 1,
                              //                       shape:
                              //                           RoundedRectangleBorder(
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           5.0)),
                              //                       color: isDarkMode == false
                              //                           ? ColorApp.colorgray
                              //                           : const Color(
                              //                               0xff38373c),
                              //                       child: EffectButton(
                              //                         Ontap: () {
                              //                           Future.delayed(
                              //                               Duration(
                              //                                   milliseconds:
                              //                                       100), () {
                              //                             Navigator.push(
                              //                                 context,
                              //                                 MaterialPageRoute(
                              //                                     builder:
                              //                                         (context) =>
                              //                                             AddGalleryImage()));
                              //                           });
                              //                         },
                              //                         icon: Icons.add,
                              //                         color: isDarkMode == false
                              //                             ? Colors.black87
                              //                             : Colors.white,
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ],
                              //             ),
                              //             Padding(
                              //               padding: const EdgeInsets.fromLTRB(
                              //                   0, 0, 0, 10),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.start,
                              //                 children: [
                              //                   Text(
                              //                     "Choose or upload your image your Liked.",
                              //                     style: TextStyle(
                              //                         color: isDarkMode == false
                              //                             ? ColorApp
                              //                                 .colorblackgalf
                              //                             : Colors.white70,
                              //                         fontSize: 13),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             Row(
                              //               children: [
                              //                 Expanded(
                              //                   child: deleteGallery == true
                              //                       ? GridView.builder(
                              //                           shrinkWrap: true,
                              //                           physics:
                              //                               NeverScrollableScrollPhysics(),
                              //                           padding:
                              //                               EdgeInsets.zero,
                              //                           scrollDirection:
                              //                               Axis.vertical,
                              //                           gridDelegate:
                              //                               const SliverGridDelegateWithMaxCrossAxisExtent(
                              //                             maxCrossAxisExtent:
                              //                                 100,
                              //                             crossAxisSpacing: 8,
                              //                             mainAxisSpacing: 4,
                              //                           ),
                              //                           itemCount: snapshot
                              //                               .data?.length,
                              //                           itemBuilder:
                              //                               (BuildContext ctx,
                              //                                   index) {
                              //                             return Container(
                              //                               alignment: Alignment
                              //                                   .center,
                              //                               decoration:
                              //                                   BoxDecoration(
                              //                                       // color: Colors.amber,
                              //                                       borderRadius:
                              //                                           BorderRadius.circular(
                              //                                               15)),
                              //                               child: Stack(
                              //                                 children: [
                              //                                   Container(
                              //                                       decoration: BoxDecoration(
                              //                                           borderRadius:
                              //                                               BorderRadius.circular(
                              //                                                   12),
                              //                                           border: Border.all(
                              //                                               color: AppColors
                              //                                                   .colorpurpal)),
                              //                                       child:
                              //                                           ClipRRect(
                              //                                         borderRadius:
                              //                                             BorderRadius.circular(
                              //                                                 12),
                              //                                         child:
                              //                                             Image(
                              //                                           height:
                              //                                               50,
                              //                                           width:
                              //                                               50,
                              //                                           fit: BoxFit
                              //                                               .cover,
                              //                                           image: NetworkImage(
                              //                                               '${Constants.imageBaseUrl}${snapshot.data![index].image}'),
                              //                                         ),
                              //                                       )),
                              //                                   Padding(
                              //                                     padding: const EdgeInsets
                              //                                             .only(
                              //                                         right: 8,
                              //                                         bottom:
                              //                                             0),
                              //                                     child: Align(
                              //                                       alignment:
                              //                                           Alignment
                              //                                               .topRight,
                              //                                       child:
                              //                                           GestureDetector(
                              //                                         onTap:
                              //                                             () {
                              //                                           SkillDeleteAlert(
                              //                                               context,
                              //                                               snapshot.data![index].id.toString(),
                              //                                               "Delete from Gallery",
                              //                                               "this wil delete from all section of you",
                              //                                               "profile",
                              //                                               "profileGalleryDelete",
                              //                                               "Gallery");
                              //                                         },
                              //                                         child: Visibility(
                              //                                             visible: jobGallery,
                              //                                             child: Container(
                              //                                               height:
                              //                                                   20,
                              //                                               width:
                              //                                                   20,
                              //                                               decoration:
                              //                                                   BoxDecoration(
                              //                                                 color: Colors.red[100],
                              //                                               ),
                              //                                               child:
                              //                                                   Center(
                              //                                                 child: Icon(
                              //                                                   Icons.clear,
                              //                                                   size: 18,
                              //                                                   color: Colors.red,
                              //                                                 ),
                              //                                               ),
                              //                                             )),
                              //                                       ),
                              //                                     ),
                              //                                   ),
                              //                                 ],
                              //                               ),
                              //                             );
                              //                           })
                              //                       : ProgressLoading(),
                              //                 ),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     }
                              //   },
                              // ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: Consumer<GetWorkAuthorizationController>(
                              builder: (context, val, child) {
                            if (val.isLoading) {
                              return Container(
                                width: s.width,
                                height: s.height * 0.20,
                                color: isDarkMode == false
                                    ? Colors.white
                                    : const Color(0xff38373c),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white30,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 5, 5, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 60.0,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 3,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              if (val.workAuthListData.isEmpty) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 14, 10),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppString.workAuthorization,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 0,
                                                              bottom: 0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      100), () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AddWorkAuthorization()));
                                                          });
                                                        },
                                                        child: Material(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            height: 25,
                                                            width: 33,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colorblack,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 15, 19, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppString.workAuthorization,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                  : ColorApp.colorblackgalf,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: InkWell(
                                                  onTap: () {
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      setState(() {
                                                        workAuthDelete =
                                                            workAuthDelete
                                                                ? false
                                                                : true;
                                                      });
                                                    });
                                                  },
                                                  child: Material(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: 25,
                                                      width: 33,
                                                      child: Center(
                                                        child: Image.asset(
                                                            width: 17,
                                                            height: 16,
                                                            ImangeAssests
                                                                .dltImage,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0, bottom: 0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddWorkAuthorization()));
                                                    });
                                                  },
                                                  child: Material(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: 25,
                                                      width: 33,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : ColorApp
                                                                  .colorblack,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: deleteSkillLevel == true
                                                ? GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    gridDelegate:
                                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                                      // padding: const EdgeInsets.all(10),
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 0,
                                                      maxCrossAxisExtent: 180.0,

                                                      childAspectRatio: 3,
                                                    ),
                                                    itemCount: val
                                                        .workAuthListData
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext ctx,
                                                            index) {
                                                      workAuthImage = val
                                                          .workAuthListData[
                                                              index]
                                                          .flag
                                                          .toString();
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 5),
                                                                  child:
                                                                      Container(
                                                                    height: 23,
                                                                    width: 25,
                                                                    child: Image.network(
                                                                        'https://api.publish.jobs/pjcloud/country/' +
                                                                            workAuthImage!),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  val
                                                                      .workAuthListData[
                                                                          index]
                                                                      .title
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    color: isDarkMode ==
                                                                            true
                                                                        ? Colors
                                                                            .white
                                                                        : ColorApp
                                                                            .colornewblack,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    SkillDeleteAlert(
                                                                        context,
                                                                        val
                                                                            .workAuthListData[
                                                                                index]
                                                                            .id
                                                                            .toString(),
                                                                        "Delete from Work Authorization Country",
                                                                        "this wil delete from all section of you",
                                                                        "profile",
                                                                        "workAuthDelete",
                                                                        val.workAuthListData[index]
                                                                            .title
                                                                            .toString());
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            0),
                                                                    child: Visibility(
                                                                        visible: workAuthDelete,
                                                                        child: Container(
                                                                          color: tapped
                                                                              ? Colors.red.withOpacity(0.5)
                                                                              : Colors.white,
                                                                          child:
                                                                              Icon(
                                                                            Icons.clear,
                                                                            color:
                                                                                AppColors.colorred,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    })
                                                : ProgressLoading(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: Consumer<GetPreferredPositionController>(
                              builder: (context, val, child) {
                            if (val.isLoading) {
                              return Container(
                                width: s.width,
                                height: s.height * 0.20,
                                color: isDarkMode == false
                                    ? Colors.white
                                    : const Color(0xff38373c),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white30,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 5, 5, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 60.0,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 3,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              if (val.preferredPositionListData.isEmpty) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 14, 10),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppString.preferedJobPosition,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 0,
                                                              bottom: 0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      100), () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AddPreferJobPositon()));
                                                          });
                                                        },
                                                        child: Material(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            height: 25,
                                                            width: 33,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colorblack,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 15, 16, 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppString.preferedJobPosition,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: isDarkMode == true
                                                  ? Colors.white
                                                  : ColorApp.colorblackgalf,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: InkWell(
                                                  onTap: () {
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      setState(() {
                                                        preferJobPosDlt =
                                                            preferJobPosDlt
                                                                ? false
                                                                : true;
                                                      });
                                                    });
                                                  },
                                                  child: Material(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: 25,
                                                      width: 33,
                                                      child: Center(
                                                        child: Image.asset(
                                                            width: 17,
                                                            height: 16,
                                                            ImangeAssests
                                                                .dltImage,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0, bottom: 0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 100),
                                                        () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddPreferJobPositon()));
                                                    });
                                                  },
                                                  child: Material(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: 25,
                                                      width: 33,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : ColorApp
                                                                  .colorblack,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: deletePositionLevel == true
                                                ? GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    gridDelegate:
                                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                                      // padding: const EdgeInsets.all(10),
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 0,
                                                      maxCrossAxisExtent: 180.0,

                                                      childAspectRatio: 3,
                                                    ),
                                                    itemCount: val
                                                        .preferredPositionListData
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext ctx,
                                                            index) {
                                                      return Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: ColorApp
                                                                          .colorprimary,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(2),
                                                                    child:
                                                                        Container(
                                                                      width: s.width *
                                                                          0.10,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(3),
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                ColorApp.colorprimary),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(2),
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              ColorApp.colorprimary,
                                                                          elevation:
                                                                              1,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                18,
                                                                            width:
                                                                                28,
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                width: 15,
                                                                                height: 15,
                                                                                child: Image.asset(ImangeAssests.expIcon, color: ColorApp.colorwhite, fit: BoxFit.fill),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  val
                                                                      .preferredPositionListData[
                                                                          index]
                                                                      .title
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    color: isDarkMode ==
                                                                            true
                                                                        ? Colors
                                                                            .white
                                                                        : ColorApp
                                                                            .colornewblack,
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  SkillDeleteAlert(
                                                                      context,
                                                                      val
                                                                          .preferredPositionListData[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      "Delete from Prefered Position ",
                                                                      "this wil delete from all section of you",
                                                                      "profile",
                                                                      "profilePositionDelete",
                                                                      val
                                                                          .preferredPositionListData[
                                                                              index]
                                                                          .title
                                                                          .toString());
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 0),
                                                                  child:
                                                                      Visibility(
                                                                          visible:
                                                                              preferJobPosDlt,
                                                                          child:
                                                                              Container(
                                                                            color: tapped
                                                                                ? Colors.red.withOpacity(0.5)
                                                                                : Colors.white,
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              color: AppColors.colorred,
                                                                            ),
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    })
                                                : ProgressLoading(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Column(
                          children: [
                            Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              color: isDarkMode == false
                                  ? Colors.white
                                  : ColorApp.colorblackgalf.withOpacity(0.2),
                              elevation: 1,
                              child: Consumer<GetPreferredJobTypeController>(
                                  builder: (context, val, child) {
                                if (val.isLoading) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.20,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 5, 5, 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 60.0,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Container(
                                                    width: 48.0,
                                                    height: 48.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: s.width * 0.4,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.6,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.7,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.4,
                                                        height: 15.0,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 3,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Container(
                                                    width: 48.0,
                                                    height: 48.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: s.width * 0.4,
                                                        height: 8.0,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.6,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.7,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: s.width * 0.4,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  if (val.preferredJobTypeListData.isEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 14, 10),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppString.preferedJobType,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: isDarkMode ==
                                                                true
                                                            ? Colors.white
                                                            : ColorApp
                                                                .colorblackgalf,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0,
                                                                  bottom: 0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Future.delayed(
                                                                  Duration(
                                                                      milliseconds:
                                                                          100),
                                                                  () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                AddPreferJobType()));
                                                              });
                                                            },
                                                            child: Material(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              elevation: 0,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: isDarkMode == false
                                                                      ? ColorApp
                                                                          .colorgray
                                                                      : ColorApp
                                                                          .colorblackgalf
                                                                          .withOpacity(
                                                                              0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                height: 25,
                                                                width: 33,
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: isDarkMode ==
                                                                            true
                                                                        ? Colors
                                                                            .white
                                                                        : ColorApp
                                                                            .colorblack,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 16, 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppString.preferedJobType,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : ColorApp.colorblackgalf,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          setState(() {
                                                            preferJobTypeDlt =
                                                                preferJobTypeDlt
                                                                    ? false
                                                                    : true;
                                                          });
                                                        });
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Image.asset(
                                                                width: 17,
                                                                height: 16,
                                                                ImangeAssests
                                                                    .dltImage,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colorblack,
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            bottom: 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AddPreferJobType()));
                                                        });
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colorblack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: deleteJobTypeLevel ==
                                                        true
                                                    ? GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        padding:
                                                            EdgeInsets.zero,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        gridDelegate:
                                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                          // padding: const EdgeInsets.all(10),
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 0,
                                                          maxCrossAxisExtent:
                                                              180.0,

                                                          childAspectRatio: 3,
                                                        ),
                                                        itemCount: val
                                                            .preferredJobTypeListData
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext ctx,
                                                                index) {
                                                          return Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: ColorApp
                                                                              .colorprimary,
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(2),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              s.width * 0.10,
                                                                          height:
                                                                              30,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(3),
                                                                            color:
                                                                                Colors.white,
                                                                            border:
                                                                                Border.all(color: ColorApp.colorprimary),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(2),
                                                                            child:
                                                                                Material(
                                                                              color: ColorApp.colorprimary,
                                                                              elevation: 1,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                                                              child: Center(
                                                                                child: Icon(
                                                                                  Icons.watch_later_outlined,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      val
                                                                          .preferredJobTypeListData[
                                                                              index]
                                                                          .title
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            14,
                                                                        color: isDarkMode ==
                                                                                true
                                                                            ? Colors.white
                                                                            : ColorApp.colornewblack,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      SkillDeleteAlert(
                                                                          context,
                                                                          val.preferredJobTypeListData[index].id
                                                                              .toString(),
                                                                          "Delete Prefered Job Type",
                                                                          "this wil delete from all section of you",
                                                                          "profile",
                                                                          "profileJobTypeDelete",
                                                                          val.preferredJobTypeListData[index]
                                                                              .title
                                                                              .toString());
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              0),
                                                                      child: Visibility(
                                                                          visible: preferJobTypeDlt,
                                                                          child: Container(
                                                                            color: tapped
                                                                                ? Colors.red.withOpacity(0.5)
                                                                                : Colors.white,
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              color: AppColors.colorred,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        })
                                                    : ProgressLoading(),
                                              ),
                                            ],
                                          ),
                                          /*       Material(
                                        color:
                                        Colors.white.withOpacity(0.0),
                                        child: InkWell(
                                            child: Container(
                                              width: s.width * 10,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "View all Jobs Types",
                                                        style: TextStyle(
                                                          color: ColorApp
                                                              .colorprimary,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              Future.delayed(
                                                  Duration(
                                                      milliseconds: 100),
                                                      () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                AllJobTypeListShow()));
                                                  });
                                            }),
                                      ),*/
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Column(
                          children: [
                            Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                color: isDarkMode == false
                                    ? Colors.white
                                    : ColorApp.colorblackgalf.withOpacity(0.2),
                                elevation: 1,
                                child: Consumer<GetPreferredJobSeekerLocation>(
                                    builder: (context, val, child) {
                                  if (val.isLoadingLocation) {
                                    return Container(
                                      width: s.width,
                                      height: s.height * 0.16,
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : const Color(0xff38373c),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white30,
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 10, 5, 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 40.0,
                                                            height: 8.0,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 5, 5, 10),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    if (val
                                        .preferredJobLocationListData.isEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 14, 10),
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 3),
                                                        child: Text(
                                                          AppString
                                                              .preferedJobLocaiton,
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblackgalf,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 0,
                                                                    bottom: 0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Future.delayed(
                                                                    Duration(
                                                                        milliseconds:
                                                                            100),
                                                                    () {
                                                                  setState(() {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                AddPreferJobLocation()));
                                                                  });
                                                                });
                                                              },
                                                              child: Material(
                                                                color: isDarkMode == false
                                                                    ? ColorApp
                                                                        .colorgray
                                                                    : ColorApp
                                                                        .colorblackgalf
                                                                        .withOpacity(
                                                                            0.2),
                                                                elevation: 0,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: isDarkMode ==
                                                                            false
                                                                        ? ColorApp
                                                                            .colorgray
                                                                        : ColorApp
                                                                            .colorblackgalf
                                                                            .withOpacity(0.2),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  height: 25,
                                                                  width: 33,
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: isDarkMode ==
                                                                              true
                                                                          ? Colors
                                                                              .white
                                                                          : ColorApp
                                                                              .colorblack,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 15, 10, 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 3),
                                                  child: Text(
                                                    AppString
                                                        .preferedJobLocaiton,
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : ColorApp
                                                              .colorblackgalf,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      100), () {
                                                            setState(() {
                                                              jobPreferedLocation =
                                                                  jobPreferedLocation
                                                                      ? false
                                                                      : true;
                                                            });
                                                          });
                                                        },
                                                        child: Material(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            height: 25,
                                                            width: 33,
                                                            child: Center(
                                                              child: Image.asset(
                                                                  width: 17,
                                                                  height: 16,
                                                                  ImangeAssests
                                                                      .dltImage,
                                                                  color: isDarkMode ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : ColorApp
                                                                          .colorblack,
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 0,
                                                              bottom: 0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      100), () {
                                                            setState(() {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              AddPreferJobLocation()));
                                                            });
                                                          });
                                                        },
                                                        child: Material(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            height: 25,
                                                            width: 33,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colorblack,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: deleteJobLocation ==
                                                          true
                                                      ? GridView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          padding:
                                                              EdgeInsets.zero,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          gridDelegate:
                                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                            // padding: const EdgeInsets.all(10),
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing: 0,
                                                            maxCrossAxisExtent:
                                                                180.0,

                                                            childAspectRatio: 3,
                                                          ),
                                                          itemCount: val
                                                              .preferredJobLocationListData
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext ctx,
                                                                  index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 1),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Container(
                                                                                  decoration: BoxDecoration(color: ColorApp.colorprimary, borderRadius: BorderRadius.circular(4)),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(2),
                                                                                    child: Container(
                                                                                      width: s.width * 0.10,
                                                                                      height: 30,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(3),
                                                                                        color: Colors.white,
                                                                                        border: Border.all(color: ColorApp.colorprimary),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(2),
                                                                                        child: Material(
                                                                                          color: ColorApp.colorprimary,
                                                                                          elevation: 1,
                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                                                                          child: Center(
                                                                                            child: Icon(
                                                                                              Icons.location_on_outlined,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 8),
                                                                                  child: Text(
                                                                                    val.preferredJobLocationListData[index].city!.title.toString(),
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontSize: 14,
                                                                                      color: isDarkMode == true ? Colors.white : ColorApp.colornewblack,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          SkillDeleteAlert(
                                                                              context,
                                                                              val.preferredJobLocationListData[index].id.toString(),
                                                                              "Delete Prefered Job Location ",
                                                                              "this wil delete from all section of you",
                                                                              "profile",
                                                                              "profileJobLocationDelete",
                                                                              val.preferredJobLocationListData[index].city!.title.toString());
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 20),
                                                                          child: Visibility(
                                                                              visible: jobPreferedLocation,
                                                                              child: Container(
                                                                                height: 20,
                                                                                width: 20,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.red[100],
                                                                                ),
                                                                                child: Center(
                                                                                  child: Icon(
                                                                                    Icons.clear,
                                                                                    color: Colors.red,
                                                                                    size: 18,
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          })
                                                      : ProgressLoading(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                })),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Column(
                          children: [
                            Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              color: isDarkMode == false
                                  ? Colors.white
                                  : ColorApp.colorblackgalf.withOpacity(0.2),
                              elevation: 1,
                              child: FutureBuilder<
                                  GetjobseekerExpectedSalaryModel>(
                                future: GlobalVarData.salaryList,
                                builder: (context, snapshot) {
                                  print(snapshot.data?.currencies?.currency
                                      .toString());
                                  if (!snapshot.hasData) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 40.0,
                                                            height: 8.0,
                                                            color: Colors.white,
                                                          ),
                                                        ]),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 40.0,
                                                            height: 8.0,
                                                            color: Colors.white,
                                                          ),
                                                        ]),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.data?.currencies?.currency
                                          .toString() ==
                                      null) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12, top: 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, left: 13),
                                                child: Text(
                                                  'Expected Salary',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            bottom: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddSalary()));
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colorblack,
                                                            ),
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
                                    );
                                  } else {
                                    String rupees =
                                        snapshot.data?.currencies?.currency ??
                                            '';
                                    String desirepay =
                                        snapshot.data?.desiredPay ?? '';
                                    String title =
                                        snapshot.data?.salarytypes?.title ?? '';
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 0, 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Text(
                                                  'Expected Salary',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Material(
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  color: isDarkMode == false
                                                      ? ColorApp.colorgray
                                                      : const Color(0xff38373c),
                                                  child: EffectButton(
                                                    Ontap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => EditExpectedSalary(
                                                                id: snapshot
                                                                    .data!.id
                                                                    .toString(),
                                                                currency: snapshot
                                                                    .data!
                                                                    .currencies!
                                                                    .currency
                                                                    .toString(),
                                                                paymentFreguency:
                                                                    snapshot
                                                                        .data!
                                                                        .desiredPay
                                                                        .toString(),
                                                                pay: snapshot
                                                                    .data!
                                                                    .salarytypes
                                                                    ?.title
                                                                    .toString()),
                                                          ));
                                                    },
                                                    icon: Icons.edit,
                                                    color: isDarkMode == false
                                                        ? Colors.black87
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Container(
                                                  width: s.width * 0.10,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorApp
                                                            .colorprimary),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: ColorApp
                                                              .colorprimary,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3)),
                                                      width: s.width * 0.10,
                                                      height: 32,
                                                      child: Icon(
                                                        Icons
                                                            .watch_later_outlined,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                (rupees + " ") +
                                                    (desirepay + " ") +
                                                    (title + " "),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : ColorApp.colornewblack,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: FutureBuilder<List<GetResumeModel>>(
                              future: GlobalVarData.resumeList,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.16,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.16,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                  ;
                                } else if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 15, 5, 5),
                                            child: Text(
                                              AppString.resume,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: isDarkMode == true
                                                    ? Colors.white
                                                    : ColorApp.colorblackgalf,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12, top: 8),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, bottom: 0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddResume()));
                                                    },
                                                    child: Material(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: 25,
                                                        width: 33,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                          physics: ScrollPhysics(),
                                          itemCount: snapshot.data!.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5,
                                                            left: 10,
                                                            right: 10),
                                                    child: Row(
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            width:
                                                                s.width * 0.09,
                                                            height: 28,
                                                            child: Image.asset(
                                                                ImangeAssests
                                                                    .pdfImg,
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .resume
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colornewblack,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          })
                                    ],
                                  );
                                } else {
                                  return Material(
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 15, 5, 15),
                                              child: Text(
                                                AppString.resume,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : ColorApp.colorblackgalf,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 3),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            bottom: 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddResume()));
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colorblack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: Consumer<GetCertificationController>(
                              builder: (context, val, snapshot) {
                            if (val.isLoading) {
                              return Container(
                                width: s.width,
                                height: s.height * 0.20,
                                color: isDarkMode == false
                                    ? Colors.white
                                    : const Color(0xff38373c),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white30,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 5, 5, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 60.0,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 3,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.6,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.7,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: s.width * 0.4,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              if (val.certificationsListData.isEmpty) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 9, 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Traning & Certification ',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: isDarkMode == true
                                                ? Colors.white
                                                : ColorApp.colorblackgalf,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 3),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0, bottom: 0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddTraningCertification()));
                                                },
                                                child: Material(
                                                  color: isDarkMode == false
                                                      ? ColorApp.colorgray
                                                      : ColorApp.colorblackgalf
                                                          .withOpacity(0.2),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    height: 25,
                                                    width: 33,
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            isDarkMode == true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Traning & Certification ',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : ColorApp.colorblackgalf,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            bottom: 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddTraningCertification()));
                                                      },
                                                      child: Material(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode ==
                                                                    false
                                                                ? ColorApp
                                                                    .colorgray
                                                                : ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height: 25,
                                                          width: 33,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : ColorApp
                                                                      .colorblack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: s.width,
                                        child: ListView.builder(
                                            physics: ScrollPhysics(),
                                            itemCount: val
                                                .certificationsListData.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 2),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: ColorApp
                                                                      .colorprimary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(2),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      s.width *
                                                                          0.10,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: ColorApp
                                                                            .colorprimary),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(2),
                                                                    child:
                                                                        Material(
                                                                      color: ColorApp
                                                                          .colorprimary,
                                                                      elevation:
                                                                          1,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(2)),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            18,
                                                                        width:
                                                                            28,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                15,
                                                                            height:
                                                                                15,
                                                                            child: Image.asset(ImangeAssests.trinaningIcon,
                                                                                color: ColorApp.colorwhite,
                                                                                fit: BoxFit.fill),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      8,
                                                                      10,
                                                                      8,
                                                                      0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              val.certificationsListData[index].certificate.toString(),
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 14,
                                                                                color: isDarkMode == true ? Colors.white : ColorApp.colornewblack,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              val.certificationsListData[index].institute.toString(),
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: isDarkMode == false ? const Color(0xff5e5873) : Colors.white70,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 0),
                                                                              child: Text(
                                                                                '${val.certificationsListData[index].startDate ?? ''}' + " " + ' ${val.certificationsListData[index].endDate ?? ''}',
                                                                                style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  color: isDarkMode == false ? const Color(0xff5e5873) : Colors.white70,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 0),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => EditTraningCertification(
                                                                                          id: val.certificationsListData[index].id.toString(),
                                                                                          institueUpdateData: val.certificationsListData[index].institute.toString(),
                                                                                          certificateName: val.certificationsListData[index].certificate.toString(),
                                                                                          descriptionUpdateData: val.certificationsListData[index].description.toString(),
                                                                                          //  educationList: eduList,

                                                                                          startDate: val.certificationsListData[index].startDate,
                                                                                          endDate: val.certificationsListData[index].endDate,

                                                                                          navigationDeciderId: '2',
                                                                                        )));
                                                                          },
                                                                          child:
                                                                              Material(
                                                                            color: isDarkMode == false
                                                                                ? ColorApp.colorgray
                                                                                : ColorApp.colorblackgalf.withOpacity(0.2),
                                                                            elevation:
                                                                                0,
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: isDarkMode == false ? ColorApp.colorgray : ColorApp.colorblackgalf.withOpacity(0.2),
                                                                                borderRadius: BorderRadius.circular(5),
                                                                              ),
                                                                              height: 25,
                                                                              width: 33,
                                                                              child: Center(
                                                                                child: Image.asset(width: 17, height: 16, ImangeAssests.eImage, color: isDarkMode == true ? Colors.white : ColorApp.colorblack, fit: BoxFit.fill),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Expanded(
                                      //       child: GridView.builder(
                                      //           shrinkWrap: true,
                                      //           physics:
                                      //           NeverScrollableScrollPhysics(),
                                      //           padding: EdgeInsets.zero,
                                      //           scrollDirection:
                                      //           Axis.vertical,
                                      //           gridDelegate:
                                      //           SliverGridDelegateWithMaxCrossAxisExtent(
                                      //             // padding: const EdgeInsets.all(10),
                                      //             crossAxisSpacing: 10,
                                      //             mainAxisSpacing: 0,
                                      //             maxCrossAxisExtent:
                                      //             180.0,
                                      //
                                      //             childAspectRatio: 3,
                                      //           ),
                                      //           itemCount:
                                      //           snapshot.data?.length,
                                      //           itemBuilder:
                                      //               (BuildContext ctx,
                                      //               index) {
                                      //             return Column(
                                      //               children: [
                                      //                 Row(
                                      //                   mainAxisAlignment:
                                      //                   MainAxisAlignment
                                      //                       .start,
                                      //                   children: [
                                      //                     Padding(
                                      //                       padding: const EdgeInsets
                                      //                           .only(
                                      //                           right: 5),
                                      //                       child:
                                      //                       Container(
                                      //                         width:
                                      //                         s.width *
                                      //                             0.10,
                                      //                         height: 33,
                                      //                         decoration:
                                      //                         BoxDecoration(
                                      //                           borderRadius:
                                      //                           BorderRadius
                                      //                               .circular(
                                      //                               3),
                                      //                           color: Colors
                                      //                               .white,
                                      //                           border: Border
                                      //                               .all(
                                      //                               color:
                                      //                               ColorApp
                                      //                                   .colorprimary),
                                      //                         ),
                                      //                         child:
                                      //                         Padding(
                                      //                           padding:
                                      //                           const EdgeInsets
                                      //                               .all(
                                      //                               1.5),
                                      //                           child:
                                      //                           Container(
                                      //                             decoration: BoxDecoration(
                                      //                                 color:
                                      //                                 ColorApp
                                      //                                     .colorprimary,
                                      //                                 borderRadius: BorderRadius
                                      //                                     .circular(
                                      //                                     3)),
                                      //                             width: s
                                      //                                 .width *
                                      //                                 0.10,
                                      //                             height:
                                      //                             32,
                                      //                             child:
                                      //                             Icon(
                                      //                               Icons
                                      //                                   .watch_later_outlined,
                                      //                               color:
                                      //                               Colors
                                      //                                   .white,
                                      //                             ),
                                      //                           ),
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                     Expanded(
                                      //                       child: Column(
                                      //                         crossAxisAlignment:
                                      //                         CrossAxisAlignment
                                      //                             .start,
                                      //                         children: [
                                      //                           Text(
                                      //                             snapshot
                                      //                                 .data?[index]
                                      //                                 .certificate
                                      //                                 .toString() ??
                                      //                                 '',
                                      //                             style:
                                      //                             TextStyle(
                                      //                               fontWeight:
                                      //                               FontWeight
                                      //                                   .w500,
                                      //                               fontSize:
                                      //                               14,
                                      //                               color: isDarkMode ==
                                      //                                   true
                                      //                                   ? Colors
                                      //                                   .white
                                      //                                   : ColorApp
                                      //                                   .colornewblack,
                                      //                             ),
                                      //                           ),
                                      //                           Text(
                                      //                             snapshot
                                      //                                 .data?[index]
                                      //                                 .institute
                                      //                                 .toString() ??
                                      //                                 '',
                                      //                             style:
                                      //                             TextStyle(
                                      //                               fontSize:
                                      //                               12,
                                      //                               color: isDarkMode ==
                                      //                                   false
                                      //                                   ? const Color(
                                      //                                   0xff5e5873)
                                      //                                   : Colors
                                      //                                   .white70,
                                      //                             ),
                                      //                           ),
                                      //                           Padding(
                                      //                             padding:
                                      //                             const EdgeInsets
                                      //                                 .only(
                                      //                                 top: 0),
                                      //                             child:
                                      //                             Text(
                                      //                               '${snapshot
                                      //                                   .data![index]
                                      //                                   .startDate
                                      //                                   ?.year
                                      //                                   .toString() ??
                                      //                                   ''} -'
                                      //                                   ' ${snapshot
                                      //                                   .data![index]
                                      //                                   .endDate
                                      //                                   ?.year
                                      //                                   .toString() ??
                                      //                                   'In Progress'}',
                                      //                               style:
                                      //                               TextStyle(
                                      //                                 fontSize:
                                      //                                 12,
                                      //                                 color: isDarkMode ==
                                      //                                     false
                                      //                                     ? const Color(
                                      //                                     0xff5e5873)
                                      //                                     : Colors
                                      //                                     .white70,
                                      //                               ),
                                      //                             ),
                                      //                           ),
                                      //                         ],
                                      //                       ),
                                      //                     )
                                      //                   ],
                                      //                 ),
                                      //               ],
                                      //             );
                                      //           }),
                                      //     ),
                                      //   ],
                                      // ),
                                      // Material(
                                      //   color: Colors.white.withOpacity(0.0),
                                      //   child: InkWell(
                                      //       child: Container(
                                      //         width: s.width * 10,
                                      //         child: Row(
                                      //           crossAxisAlignment:
                                      //           CrossAxisAlignment.center,
                                      //           mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //           children: [
                                      //             Center(
                                      //               child: Text(
                                      //                 "View all  Skills",
                                      //                 style: TextStyle(
                                      //                     color: ColorApp
                                      //                         .colorprimary),
                                      //               ),
                                      //             ),
                                      //             Icon(
                                      //               Icons.arrow_forward,
                                      //               color:
                                      //               AppColors.colorhalfgray,
                                      //             )
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       onTap: () {
                                      //         Future.delayed(
                                      //             Duration(milliseconds: 100),
                                      //                 () {
                                      //               Navigator.push(
                                      //                   context,
                                      //                   MaterialPageRoute(
                                      //                       builder: (context) =>
                                      //                           UpdataSkillEdit()));
                                      //             });
                                      //       }),
                                      // )
                                    ],
                                  ),
                                );
                              }
                            }
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: FutureBuilder<JobSeekerRelocationModel>(
                              future: GlobalVarData
                                  .pereferredJobSeekerRelocationlist,
                              builder: (BuildContext context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                      width: s.width,
                                      height: s.height * 0.16,
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : const Color(0xff38373c),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white30,
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 10, 5, 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 40.0,
                                                            height: 8.0,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 5, 5, 10),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                } else {
                                  bool _relaction =
                                      (snapshot.data?.checked ?? 'false') ==
                                              'false'
                                          ? false
                                          : true;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Column(
                                      children: [
                                        // FutureBuilder(
                                        //   builder: (context, snapshot) {
                                        //     return Column(
                                        //       children: [
                                        //         Row(
                                        //           mainAxisAlignment:
                                        //               MainAxisAlignment.start,
                                        //           children: [
                                        //             Padding(
                                        //               padding: const EdgeInsets
                                        //                       .fromLTRB(
                                        //                   13, 10, 0, 0),
                                        //               child: Text(
                                        //                 AppString.relocation,
                                        //                 style: TextStyle(
                                        //                     fontSize: 17,
                                        //                     color: isDarkMode ==
                                        //                             true
                                        //                         ? Colors.white
                                        //                         : ColorApp
                                        //                             .colorblackgalf,
                                        //                     fontWeight:
                                        //                         FontWeight
                                        //                             .w500),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //         Consumer<
                                        //                 PostRelocationController>(
                                        //             builder:
                                        //                 (context, val, child) {
                                        //           return Padding(
                                        //             padding: const EdgeInsets
                                        //                 .fromLTRB(0, 0, 0, 10),
                                        //             child: val.loadingRelocation ==
                                        //                     false
                                        //                 ? Consumer<
                                        //                     PostRelocationController>(
                                        //                     builder: (context,
                                        //                         val, child) {
                                        //                       return Padding(
                                        //                         padding:
                                        //                             const EdgeInsets
                                        //                                     .only(
                                        //                                 bottom:
                                        //                                     9),
                                        //                         child: Row(
                                        //                           mainAxisAlignment:
                                        //                               MainAxisAlignment
                                        //                                   .spaceBetween,
                                        //                           children: [
                                        //                             Padding(
                                        //                               padding: const EdgeInsets
                                        //                                       .only(
                                        //                                   left:
                                        //                                       10),
                                        //                               child: _relaction ==
                                        //                                       false
                                        //                                   ? Text(
                                        //                                       "I'm not willing to relocate",
                                        //                                       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: isDarkMode == true ? ColorApp.colorwhite : ColorApp.colorblack.withOpacity(0.5)),
                                        //                                     )
                                        //                                   : Text(
                                        //                                       "I'm willing to relocate",
                                        //                                       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: isDarkMode == true ? ColorApp.colorwhite : ColorApp.colorblack.withOpacity(0.5)),
                                        //                                     ),
                                        //                             ),
                                        //                             Padding(
                                        //                               padding: const EdgeInsets
                                        //                                       .only(
                                        //                                   right:
                                        //                                       10),
                                        //                               child: val.loadingRelocation ==
                                        //                                       false
                                        //                                   ? FlutterSwitch(
                                        //                                       height: s.height * 0.035,
                                        //                                       width: s.width * 0.178,
                                        //                                       inactiveColor: ColorApp.colorblackgalf,
                                        //                                       activeColor: ColorApp.colorprimary,
                                        //                                       value: _relaction,
                                        //                                       onToggle: (value) {
                                        //                                         setState(() {
                                        //                                           val.jobSeekerRelocationAdd(value.toString(), context);
                                        //                                         });
                                        //
                                        //                                         Timer(
                                        //                                             Duration(seconds: 1),
                                        //                                             () => setState(() {
                                        //                                                   GlobalVarData.pereferredJobSeekerRelocationlist = GetRelocationController().getJobRelocation();
                                        //                                                 }));
                                        //                                       },
                                        //                                     )
                                        //                                   : SizedBox(
                                        //                                       height: 25,
                                        //                                       width: 25,
                                        //                                       child: CircularProgressIndicator()),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                       );
                                        //                     },
                                        //                   )
                                        //                 : ProgressLoading(),
                                        //           );
                                        //         }),
                                        //       ],
                                        //     );
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                color: isDarkMode == false
                                    ? Colors.white
                                    : ColorApp.colorblackgalf.withOpacity(0.2),
                                elevation: 1,
                                child: Consumer<GetLanguageController>(
                                    builder: (context, val, child) {
                                  if (val.isLoadinglanguage) {
                                    return Container(
                                      width: s.width,
                                      height: s.height * 0.20,
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : const Color(0xff38373c),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white30,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 5, 5, 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 60.0,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          width: s.width * 0.4,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      2.0),
                                                        ),
                                                        Container(
                                                          width: s.width * 0.6,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      2.0),
                                                        ),
                                                        Container(
                                                          width: s.width * 0.7,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      2.0),
                                                        ),
                                                        Container(
                                                          width: s.width * 0.4,
                                                          height: 15.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                height: 3,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          width: s.width * 0.4,
                                                          height: 8.0,
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      2.0),
                                                        ),
                                                        Container(
                                                          width: s.width * 0.6,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      2.0),
                                                        ),
                                                        Container(
                                                          width: s.width * 0.7,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      2.0),
                                                        ),
                                                        Container(
                                                          width: s.width * 0.4,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    if (val.languageListData.isEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 14, 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppString.languageUsed,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : ColorApp.colorblackgalf,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, bottom: 0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Future.delayed(
                                                          Duration(
                                                              milliseconds:
                                                                  100), () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddLanguage()));
                                                      });
                                                    },
                                                    child: Material(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: 25,
                                                        width: 33,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 15, 0, 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppString.languageUsed,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : ColorApp
                                                              .colorblackgalf,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      100), () {
                                                            setState(() {
                                                              languageDlt =
                                                                  languageDlt
                                                                      ? false
                                                                      : true;
                                                            });
                                                          });
                                                        },
                                                        child: Material(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            height: 25,
                                                            width: 33,
                                                            child: Center(
                                                              child: Image.asset(
                                                                  width: 17,
                                                                  height: 16,
                                                                  ImangeAssests
                                                                      .dltImage,
                                                                  color: isDarkMode ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : ColorApp
                                                                          .colorblack,
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 14,
                                                              bottom: 0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      100), () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AddLanguage()));
                                                          });
                                                        },
                                                        child: Material(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDarkMode == false
                                                                  ? ColorApp
                                                                      .colorgray
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            height: 25,
                                                            width: 33,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : ColorApp
                                                                        .colorblack,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: deleteJobLanguage ==
                                                          true
                                                      ? GridView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          padding:
                                                              EdgeInsets.zero,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          gridDelegate:
                                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                            // padding: const EdgeInsets.all(10),
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing: 0,
                                                            maxCrossAxisExtent:
                                                                180.0,

                                                            childAspectRatio: 3,
                                                          ),
                                                          itemCount: val
                                                              .languageListData
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext ctx,
                                                                  index) {
                                                            return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 1),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(right: 10),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(color: ColorApp.colorprimary, borderRadius: BorderRadius.circular(4)),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(2),
                                                                                        child: Container(
                                                                                          width: s.width * 0.10,
                                                                                          height: 30,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(3),
                                                                                            color: Colors.white,
                                                                                            border: Border.all(color: ColorApp.colorprimary),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.all(2),
                                                                                            child: Material(
                                                                                              color: ColorApp.colorprimary,
                                                                                              elevation: 1,
                                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                                                                              child: Container(
                                                                                                height: 18,
                                                                                                width: 28,
                                                                                                child: Center(
                                                                                                  child: Container(
                                                                                                    width: 15,
                                                                                                    height: 15,
                                                                                                    child: Image.asset(ImangeAssests.expIcon, color: ColorApp.colorwhite, fit: BoxFit.fill),
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
                                                                                    padding: const EdgeInsets.only(left: 8),
                                                                                    child: Text(
                                                                                      val.languageListData[index].title!.toString(),
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontSize: 14,
                                                                                        color: isDarkMode == true ? Colors.white : ColorApp.colornewblack,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            SkillDeleteAlert(
                                                                                context,
                                                                                val.languageListData[index].id.toString(),
                                                                                "Delete Language ?",
                                                                                "this wil delete from all section of you",
                                                                                "profile",
                                                                                "profileLanguageDelete",
                                                                                val.languageListData[index].title.toString());
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 20),
                                                                            child: Visibility(
                                                                                visible: languageDlt,
                                                                                child: Container(
                                                                                  height: 20,
                                                                                  width: 20,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.red[100],
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Icon(
                                                                                      Icons.clear,
                                                                                      color: Colors.red,
                                                                                      size: 18,
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ));
                                                          })
                                                      : ProgressLoading(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                }),
                              ),
                            ),
                            // Material(
                            //     color: isDarkMode == false
                            //         ? Colors.white
                            //         : const Color(0xff38373c),
                            //     elevation: 1,
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(12)),
                            //     child:
                            //         FutureBuilder<List<JobSeekerLanguageModel>>(
                            //       future: GlobalVarData.languageListFuture,
                            //       builder: (context, snapshot) {
                            //         if (!snapshot.hasData) {
                            //           return Container(
                            //             width: s.width,
                            //             color: isDarkMode == false
                            //                 ? Colors.white
                            //                 : const Color(0xff38373c),
                            //             child: Shimmer.fromColors(
                            //               baseColor: Colors.grey,
                            //               highlightColor: Colors.white30,
                            //               child: Container(
                            //                 child: Row(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Expanded(
                            //                       child: Column(
                            //                         crossAxisAlignment:
                            //                             CrossAxisAlignment
                            //                                 .start,
                            //                         children: <Widget>[
                            //                           Padding(
                            //                             padding:
                            //                                 const EdgeInsets
                            //                                         .fromLTRB(
                            //                                     8, 10, 5, 5),
                            //                             child: Row(
                            //                               mainAxisAlignment:
                            //                                   MainAxisAlignment
                            //                                       .spaceBetween,
                            //                               children: [
                            //                                 Container(
                            //                                   width: 40.0,
                            //                                   height: 8.0,
                            //                                   color:
                            //                                       Colors.white,
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                           ),
                            //                           Padding(
                            //                             padding:
                            //                                 const EdgeInsets
                            //                                         .fromLTRB(
                            //                                     8, 5, 5, 5),
                            //                             child: Container(
                            //                               width: s.width * 0.94,
                            //                               height: 8.0,
                            //                               color: Colors.white,
                            //                             ),
                            //                           ),
                            //                           Padding(
                            //                             padding:
                            //                                 const EdgeInsets
                            //                                         .fromLTRB(
                            //                                     8, 5, 5, 5),
                            //                             child: Container(
                            //                               width: s.width * 0.94,
                            //                               height: 8.0,
                            //                               color: Colors.white,
                            //                             ),
                            //                           ),
                            //                           Padding(
                            //                             padding:
                            //                                 const EdgeInsets
                            //                                         .fromLTRB(
                            //                                     8, 5, 5, 5),
                            //                             child: Container(
                            //                               width: s.width * 0.94,
                            //                               height: 8.0,
                            //                               color: Colors.white,
                            //                             ),
                            //                           ),
                            //                           Padding(
                            //                             padding:
                            //                                 const EdgeInsets
                            //                                         .fromLTRB(
                            //                                     8, 5, 5, 10),
                            //                             child: Container(
                            //                               width: s.width * 0.94,
                            //                               height: 8.0,
                            //                               color: Colors.white,
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     )
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           );
                            //         } else if (snapshot!.data?.isEmpty ??
                            //             false) {
                            //           return Padding(
                            //             padding: const EdgeInsets.fromLTRB(
                            //                 10, 15, 10, 15),
                            //             child: Padding(
                            //               padding:
                            //                   const EdgeInsets.only(bottom: 10),
                            //               child: Row(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Text(
                            //                     AppString.languageUsed,
                            //                     style: TextStyle(
                            //                         fontSize: 17,
                            //                         color: isDarkMode == true
                            //                             ? Colors.white
                            //                             : AppColors.colorblack,
                            //                         fontWeight:
                            //                             FontWeight.bold),
                            //                   ),
                            //                   Row(
                            //                     children: [
                            //                       Padding(
                            //                         padding:
                            //                             const EdgeInsets.only(
                            //                                 right: 10),
                            //                         child: Material(
                            //                           shape:
                            //                               RoundedRectangleBorder(
                            //                                   borderRadius:
                            //                                       BorderRadius
                            //                                           .circular(
                            //                                               5.0)),
                            //                           color: isDarkMode == false
                            //                               ? ColorApp.colorgray
                            //                               : const Color(
                            //                                   0xff38373c),
                            //                           elevation: 1,
                            //                           child: EffectButton(
                            //                               Ontap: () {
                            //                                 Future.delayed(
                            //                                     Duration(
                            //                                         milliseconds:
                            //                                             100),
                            //                                     () {
                            //                                   Navigator.push(
                            //                                       context,
                            //                                       MaterialPageRoute(
                            //                                           builder:
                            //                                               (context) =>
                            //                                                   AddLanguage()));
                            //                                 });
                            //                               },
                            //                               icon: Icons.add,
                            //                               color: isDarkMode ==
                            //                                       false
                            //                                   ? Colors.black87
                            //                                   : Colors.white),
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   )
                            //                 ],
                            //               ),
                            //             ),
                            //           );
                            //         } else {
                            //           return Padding(
                            //             padding: const EdgeInsets.fromLTRB(
                            //                 10, 15, 0, 15),
                            //             child: Column(
                            //               children: [
                            //                 Row(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment
                            //                           .spaceBetween,
                            //                   children: [
                            //                     Text(
                            //                       AppString.languageUsed,
                            //                       style: TextStyle(
                            //                           fontSize: 17,
                            //                           color: isDarkMode == true
                            //                               ? Colors.white
                            //                               : AppColors
                            //                                   .colorblack,
                            //                           fontWeight:
                            //                               FontWeight.bold),
                            //                     ),
                            //                     Row(
                            //                       children: [
                            //                         Padding(
                            //                           padding:
                            //                               const EdgeInsets.only(
                            //                                   right: 8),
                            //                           child: Material(
                            //                             elevation: 1,
                            //                             shape: RoundedRectangleBorder(
                            //                                 borderRadius:
                            //                                     BorderRadius
                            //                                         .circular(
                            //                                             5.0)),
                            //                             color: isDarkMode ==
                            //                                     false
                            //                                 ? ColorApp.colorgray
                            //                                 : const Color(
                            //                                     0xff38373c),
                            //                             child: EffectButton(
                            //                               Ontap: () {
                            //                                 Future.delayed(
                            //                                     Duration(
                            //                                         milliseconds:
                            //                                             100),
                            //                                     () {
                            //                                   setState(() {
                            //                                     languageDlt =
                            //                                         languageDlt
                            //                                             ? false
                            //                                             : true;
                            //                                   });
                            //                                 });
                            //                               },
                            //                               icon: Icons.delete,
                            //                               color: isDarkMode ==
                            //                                       false
                            //                                   ? Colors.black87
                            //                                   : Colors.white,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                         Padding(
                            //                           padding:
                            //                               const EdgeInsets.only(
                            //                                   right: 20),
                            //                           child: Material(
                            //                             shape: RoundedRectangleBorder(
                            //                                 borderRadius:
                            //                                     BorderRadius
                            //                                         .circular(
                            //                                             5.0)),
                            //                             color: isDarkMode ==
                            //                                     false
                            //                                 ? ColorApp.colorgray
                            //                                 : const Color(
                            //                                     0xff38373c),
                            //                             elevation: 1,
                            //                             child: EffectButton(
                            //                                 Ontap: () {
                            //                                   Future.delayed(
                            //                                       Duration(
                            //                                           milliseconds:
                            //                                               100),
                            //                                       () {
                            //                                     Navigator.push(
                            //                                         context,
                            //                                         MaterialPageRoute(
                            //                                             builder:
                            //                                                 (context) =>
                            //                                                     AddLanguage()));
                            //                                   });
                            //                                 },
                            //                                 icon: Icons.add,
                            //                                 color: isDarkMode ==
                            //                                         false
                            //                                     ? Colors.black87
                            //                                     : Colors.white),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     )
                            //                   ],
                            //                 ),
                            //                 SizedBox(
                            //                   height: 8,
                            //                 ),
                            //                 Row(
                            //                   children: [
                            //                     Expanded(
                            //                       child: deleteJobLanguage ==
                            //                               true
                            //                           ? GridView.builder(
                            //                               shrinkWrap: true,
                            //                               physics:
                            //                                   NeverScrollableScrollPhysics(),
                            //                               padding:
                            //                                   EdgeInsets.zero,
                            //                               scrollDirection:
                            //                                   Axis.vertical,
                            //                               gridDelegate:
                            //                                   SliverGridDelegateWithMaxCrossAxisExtent(
                            //                                 // padding: const EdgeInsets.all(10),
                            //                                 crossAxisSpacing:
                            //                                     10,
                            //                                 mainAxisSpacing: 0,
                            //                                 maxCrossAxisExtent:
                            //                                     180.0,
                            //
                            //                                 childAspectRatio: 3,
                            //                               ),
                            //                               itemCount: snapshot
                            //                                   .data!.length,
                            //                               itemBuilder:
                            //                                   (BuildContext ctx,
                            //                                       index) {
                            //                                 return Padding(
                            //                                     padding:
                            //                                         const EdgeInsets
                            //                                                 .only(
                            //                                             top: 1),
                            //                                     child: Column(
                            //                                       children: [
                            //                                         Row(
                            //                                           mainAxisAlignment:
                            //                                               MainAxisAlignment
                            //                                                   .spaceBetween,
                            //                                           children: [
                            //                                             Expanded(
                            //                                               child:
                            //                                                   Column(
                            //                                                 children: [
                            //                                                   Row(
                            //                                                     children: [
                            //                                                       Container(
                            //                                                         width: s.width * 0.10,
                            //                                                         height: 33,
                            //                                                         decoration: BoxDecoration(
                            //                                                           borderRadius: BorderRadius.circular(3),
                            //                                                           color: Colors.white,
                            //                                                           border: Border.all(color: ColorApp.colorprimary),
                            //                                                         ),
                            //                                                         child: Padding(
                            //                                                           padding: const EdgeInsets.all(1.5),
                            //                                                           child: Container(
                            //                                                             decoration: BoxDecoration(color: ColorApp.colorprimary, borderRadius: BorderRadius.circular(3)),
                            //                                                             width: s.width * 0.10,
                            //                                                             height: 32,
                            //                                                             child: Icon(
                            //                                                               Icons.location_on_outlined,
                            //                                                               color: Colors.white,
                            //                                                             ),
                            //                                                           ),
                            //                                                         ),
                            //                                                       ),
                            //                                                       Padding(
                            //                                                         padding: const EdgeInsets.only(left: 8),
                            //                                                         child: Text(
                            //                                                           snapshot.data![index].title!.toString(),
                            //                                                           style: TextStyle(
                            //                                                             fontWeight: FontWeight.w500,
                            //                                                             fontSize: 14,
                            //                                                             color: isDarkMode == true ? Colors.white : ColorApp.colornewblack,
                            //                                                           ),
                            //                                                         ),
                            //                                                       ),
                            //                                                     ],
                            //                                                   )
                            //                                                 ],
                            //                                               ),
                            //                                             ),
                            //                                             GestureDetector(
                            //                                               onTap:
                            //                                                   () {
                            //                                                 SkillDeleteAlert(
                            //                                                     context,
                            //                                                     snapshot.data![index].id.toString(),
                            //                                                     "delete from Profile",
                            //                                                     "this wil delete from all section of you",
                            //                                                     "profile",
                            //                                                     "profileLanguageDelete");
                            //                                               },
                            //                                               child:
                            //                                                   Padding(
                            //                                                 padding:
                            //                                                     const EdgeInsets.only(right: 20),
                            //                                                 child: Visibility(
                            //                                                     visible: languageDlt,
                            //                                                     child: Container(
                            //                                                       height: 20,
                            //                                                       width: 20,
                            //                                                       decoration: BoxDecoration(
                            //                                                         color: Colors.red[100],
                            //                                                       ),
                            //                                                       child: Center(
                            //                                                         child: Icon(
                            //                                                           Icons.clear,
                            //                                                           color: Colors.red,
                            //                                                           size: 18,
                            //                                                         ),
                            //                                                       ),
                            //                                                     )),
                            //                                               ),
                            //                                             ),
                            //                                           ],
                            //                                         ),
                            //                                       ],
                            //                                     ));
                            //                               })
                            //                           : ProgressLoading(),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //           );
                            //         }
                            //       },
                            //     )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: FutureBuilder<jobseekerAssociationModel>(
                              future: GlobalVarData.associationFuture,
                              builder: (context, snapshot) {
                                String? htmlData =
                                    snapshot.data?.association.toString() ?? "";
                                final document = parse(htmlData);
                                final String associationString =
                                    parse(document.body!.text)
                                        .documentElement!
                                        .text;
                                if (!snapshot.hasData) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.16,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.16,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.data?.association
                                        .toString() ==
                                    "null") {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 5, 5, 5),
                                              child: Text(
                                                AppString.coverlatter,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 7),
                                              child: GestureDetector(
                                                onTap: () {
                                                  //  Get.to(QuillTest());
                                                },
                                                child: InkWell(
                                                  onTap: () {
                                                    coverLatter(
                                                      namedata: "Cover Latter",
                                                      aboutId: snapshot.data?.id
                                                          .toString(),
                                                      aboutDate:
                                                          associationString,
                                                      headerText:
                                                          AppString.editAbout,
                                                      subtitle: AppString
                                                          .editExecutiveSubtitle,
                                                    );
                                                  },
                                                  child: Material(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: 25,
                                                      width: 33,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : ColorApp
                                                                  .colorblack,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                  ;
                                } else {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 5, 5, 5),
                                              child: Text(
                                                AppString.coverlatter,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              child: InkWell(
                                                onTap: () {
                                                  coverLatter(
                                                    namedata: "Cover Latter",
                                                    aboutId: snapshot.data!.id
                                                        .toString(),
                                                    aboutDate:
                                                        associationString,
                                                    headerText:
                                                        AppString.editAbout,
                                                    subtitle: AppString
                                                        .editExecutiveSubtitle,
                                                  );
                                                },
                                                child: Material(
                                                  color: isDarkMode == false
                                                      ? ColorApp.colorgray
                                                      : ColorApp.colorblackgalf
                                                          .withOpacity(0.2),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    height: 25,
                                                    width: 33,
                                                    child: Center(
                                                      child: Image.asset(
                                                          width: 17,
                                                          height: 16,
                                                          ImangeAssests.eImage,
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : ColorApp
                                                                  .colorblack,
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 5, 5, 5),
                                                child: ReadMoreText(
                                                  associationString,
                                                  trimCollapsedText:
                                                      'Learn more',
                                                  trimExpandedText: 'show'
                                                      ' less',
                                                  moreStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorApp.colorprimary,
                                                  ),
                                                  lessStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorApp.colorprimary,
                                                  ),

                                                  trimLines: 3,
                                                  // preDataText: "AMANDA",
                                                  preDataTextStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  style: TextStyle(
                                                      color: isDarkMode == false
                                                          ? ColorApp
                                                              .colorblackgalf
                                                          : Colors.white70,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  colorClickableText:
                                                      AppColors.colordark,
                                                  trimMode: TrimMode.Line,

                                                  // trimExpandedText: ' show less',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Column(
                          children: [
                            Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              color: isDarkMode == false
                                  ? Colors.white
                                  : ColorApp.colorblackgalf.withOpacity(0.2),
                              elevation: 1,
                              child: FutureBuilder<JobSeekerGenderModel>(
                                future: GlobalVarData.genderListFuture,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: s.width,
                                      height: s.height * 0.16,
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : const Color(0xff38373c),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white30,
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 10, 5, 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 40.0,
                                                            height: 8.0,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 5, 5, 10),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.data?.title.toString() ==
                                      'null') {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 14, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppString.gender,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: isDarkMode == true
                                                    ? Colors.white
                                                    : ColorApp.colorblackgalf,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 0, bottom: 0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddGender()));
                                              },
                                              child: Material(
                                                color: isDarkMode == false
                                                    ? ColorApp.colorgray
                                                    : ColorApp.colorblackgalf
                                                        .withOpacity(0.2),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 25,
                                                  width: 33,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : ColorApp.colorblack,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 0, 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3),
                                                child: Text(
                                                  AppString.gender,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : ColorApp
                                                              .colorblackgalf,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: s.width * 0.04),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddGender()));
                                                  },
                                                  child: Material(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: 25,
                                                      width: 33,
                                                      child: Center(
                                                        child: Image.asset(
                                                            width: 17,
                                                            height: 16,
                                                            ImangeAssests
                                                                .eImage,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 1),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: ColorApp
                                                                  .colorprimary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            child: Container(
                                                              width: s.width *
                                                                  0.10,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: ColorApp
                                                                        .colorprimary),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Material(
                                                                  color: ColorApp
                                                                      .colorprimary,
                                                                  elevation: 1,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2)),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .person_outline,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                          snapshot.data!.title
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colornewblack,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Column(
                          children: [
                            Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              color: isDarkMode == false
                                  ? Colors.white
                                  : ColorApp.colorblackgalf.withOpacity(0.2),
                              elevation: 1,
                              child: FutureBuilder<JobSeekerStatusModel>(
                                future: GlobalVarData.MartialListFuture,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: s.width,
                                      height: s.height * 0.16,
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : const Color(0xff38373c),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white30,
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 10, 5, 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 40.0,
                                                            height: 8.0,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 5, 5, 5),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 5, 5, 10),
                                                      child: Container(
                                                        width: s.width * 0.94,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.data!.title.toString() ==
                                      "null") {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: isDarkMode == false
                                            ? Colors.white
                                            : const Color(0xff38373c),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 8, 8),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 3),
                                                  child: Text(
                                                    AppString.martialstatus,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: isDarkMode ==
                                                                true
                                                            ? Colors.white
                                                            : ColorApp
                                                                .colorblackgalf,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5, bottom: 0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddMaritalStatus()));
                                                    },
                                                    child: Material(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: 25,
                                                        width: 33,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 0, 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3),
                                                child: Text(
                                                  AppString.martialstatus,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : ColorApp
                                                              .colorblackgalf,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: s.width * 0.04),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddMaritalStatus()));
                                                  },
                                                  child: Material(
                                                    color: isDarkMode == false
                                                        ? ColorApp.colorgray
                                                        : ColorApp
                                                            .colorblackgalf
                                                            .withOpacity(0.2),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ==
                                                                false
                                                            ? ColorApp.colorgray
                                                            : ColorApp
                                                                .colorblackgalf
                                                                .withOpacity(
                                                                    0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      height: 25,
                                                      width: 33,
                                                      child: Center(
                                                        child: Image.asset(
                                                            width: 17,
                                                            height: 16,
                                                            ImangeAssests
                                                                .eImage,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 1, bottom: 7),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: ColorApp
                                                                  .colorprimary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            child: Container(
                                                              width: s.width *
                                                                  0.10,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: ColorApp
                                                                        .colorprimary),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Material(
                                                                  color: ColorApp
                                                                      .colorprimary,
                                                                  elevation: 1,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2)),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .person_outline,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                          snapshot.data!.title
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colornewblack,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: isDarkMode == false
                              ? Colors.white
                              : ColorApp.colorblackgalf.withOpacity(0.2),
                          elevation: 1,
                          child: FutureBuilder<JobSeekerSummaryModel>(
                              future: GlobalVarData.summeryFuture,
                              builder: (context, snapshot) {
                                String? htmlData =
                                    snapshot.data?.summary.toString() ?? "";
                                final document = parse(htmlData);
                                final String aboutString =
                                    parse(document.body!.text)
                                        .documentElement!
                                        .text;
                                if (!snapshot.hasData) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.16,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: s.width,
                                    height: s.height * 0.16,
                                    color: isDarkMode == false
                                        ? Colors.white
                                        : const Color(0xff38373c),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white30,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 10, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 40.0,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 5),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 5, 5, 10),
                                                    child: Container(
                                                      width: s.width * 0.94,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.data?.summary.toString() ==
                                    'null') {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: isDarkMode == false
                                          ? Colors.white
                                          : const Color(0xff38373c),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 5, 5, 5),
                                                child: Text(
                                                  AppString.about,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : ColorApp
                                                              .colorblackgalf,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    //  Get.to(QuillTest());
                                                  },
                                                  child: InkWell(
                                                    onTap: () {
                                                      about(
                                                        namedata: "About",
                                                        aboutId: snapshot
                                                            .data?.id
                                                            .toString(),
                                                        aboutDate: aboutString,
                                                        headerText:
                                                            AppString.editAbout,
                                                        subtitle: AppString
                                                            .editExecutiveSubtitle,
                                                      );
                                                    },
                                                    child: Material(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDarkMode ==
                                                                  false
                                                              ? ColorApp
                                                                  .colorgray
                                                              : ColorApp
                                                                  .colorblackgalf
                                                                  .withOpacity(
                                                                      0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        height: 25,
                                                        width: 33,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : ColorApp
                                                                    .colorblack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 5, 5, 5),
                                              child: Text(
                                                AppString.about,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: isDarkMode == true
                                                        ? Colors.white
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              child: InkWell(
                                                onTap: () {
                                                  about(
                                                    namedata: "About",
                                                    aboutId: snapshot.data!.id
                                                        .toString(),
                                                    aboutDate: aboutString,
                                                    headerText:
                                                        AppString.editAbout,
                                                    subtitle: AppString
                                                        .editExecutiveSubtitle,
                                                  );
                                                },
                                                child: Material(
                                                  color: isDarkMode == false
                                                      ? ColorApp.colorgray
                                                      : ColorApp.colorblackgalf
                                                          .withOpacity(0.2),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: isDarkMode == false
                                                          ? ColorApp.colorgray
                                                          : ColorApp
                                                              .colorblackgalf
                                                              .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    height: 25,
                                                    width: 33,
                                                    child: Center(
                                                      child: Image.asset(
                                                          width: 17,
                                                          height: 16,
                                                          ImangeAssests.eImage,
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : ColorApp
                                                                  .colorblack,
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 5, 5, 5),
                                                child: ReadMoreText(
                                                  aboutString,
                                                  trimCollapsedText:
                                                      'Learn more',
                                                  trimExpandedText: 'show'
                                                      ' less',
                                                  moreStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorApp.colorprimary,
                                                  ),
                                                  lessStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorApp.colorprimary,
                                                  ),

                                                  trimLines: 3,
                                                  // preDataText: "AMANDA",
                                                  preDataTextStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  style: TextStyle(
                                                      color: isDarkMode == false
                                                          ? ColorApp
                                                              .colorblackgalf
                                                          : Colors.white70,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  colorClickableText:
                                                      AppColors.colordark,
                                                  trimMode: TrimMode.Line,

                                                  // trimExpandedText: ' show less',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: isDarkMode == true
                  ? ColorApp.colorblack
                  : ColorApp.colorbackground,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: isDarkMode == true
                    ? ColorApp.colorblack
                    : ColorApp.colorbackground,
                elevation: 0,
                actions: [
                  Container(
                    width: s.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Image.asset(
                            fit: BoxFit.contain,
                            "images/abc.png",
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0)),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorApp.colorwhite,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: s.width * 0.099,
                                    height: s.height * 0.044,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Icon(
                                        color: Colors.grey,
                                        size: 18,
                                        Icons.notification_add_outlined,
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: Container(
                                child: Image.asset(
                                  fit: BoxFit.contain,
                                  height: 80,
                                  ImangeAssests.personImage,
                                  width: s.width * 0.099,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: s.height * 0.029,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: s.width * 0.1, right: s.width * 0.19),
                    child: Container(
                      height: s.height * 0.4,
                      width: s.width,
                      child: Image.asset(ImangeAssests.pic2ImageOnBoarding,
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.019,
                  ),
                  Text(
                    "A Little Atemp Here",
                    style: TextStyle(
                      color: isDarkMode == true
                          ? AppColors.colorwhite
                          : AppColors.colorblack,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.019,
                  ),
                  Text(
                    "Please Login to see Profile",
                    style: TextStyle(
                      color: isDarkMode == true
                          ? AppColors.colorwhite
                          : AppColors.colorblack,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.019,
                  ),
                  SubmitButton(
                    textColor: isDarkMode == true
                        ? AppColors.colorwhite
                        : AppColors.colorwhite,
                    backGroundColor: ColorApp.colorprimary,
                    borderRadius: BorderRadius.circular(22),
                    widthButton: s.width * 0.699,
                    heightButton: s.height * 0.054,
                    textButton: 'Login Now',
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                              builder: (context) => LogInScreen(
                                    checkNav: 'profile',
                                  )));
                    },
                  )
                ],
              ),
            ),
    );
  }

  objective(
      {aboutId,
      String? aboutDate,
      headerText,
      subtitle,
      onSave,
      uniqueData,
      namedata}) {
    final s = MediaQuery.of(context).size;
    ABD abd = ABD();
    String aboutData1 = aboutDate.toString() == 'null' ? '' : aboutDate!;
    String thisUnique = uniqueData;
    aboutController.text = aboutData1;
    aboutController.selection =
        TextSelection.collapsed(offset: aboutController.text.length);
    DataServices dataServices = DataServices();

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Wrap(
          children: <Widget>[
            Container(
                width: s.width,
                height: s.height,
                child: Scaffold(
                    backgroundColor:
                        isDarkMode == true ? Color(0xff343434) : Colors.white,
                    appBar: AppBar(
                      actions: [],
                      elevation: 0,
                      backgroundColor: isDarkMode == false
                          ? ColorApp.colorblackgalf.withOpacity(0.7)
                          : Color(0xff787777).withOpacity(0.7),
                      automaticallyImplyLeading: false,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(namedata,
                            style: TextStyle(
                                color: isDarkMode == false
                                    ? ColorApp.colorblack.withOpacity(0.6)
                                    : ColorApp.colorbackground
                                        .withOpacity(0.69))),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          color: isDarkMode == true
                              ? Color(0xff343434)
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8, left: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            "Introduce your self edit your profile to show client you have the skills and Experienc they are looking for",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: isDarkMode == false
                                                    ? ColorApp.colorblack
                                                        .withOpacity(0.6)
                                                    : ColorApp.colorbackground
                                                        .withOpacity(0.69),
                                                fontWeight: FontWeight.w400),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter objective text';
                                                  }
                                                  return null;
                                                },
                                                controller: aboutController,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: null,
                                                minLines: 8,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorApp
                                                            .colorprimary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      borderSide: BorderSide(
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.3)
                                                              : Colors.black54
                                                                  .withOpacity(
                                                                      0.3))),
                                                  filled: true,
                                                  fillColor: isDarkMode == true
                                                      ? Color(0xff343434)
                                                      : Colors.white,
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.3)
                                                              : Colors.black54
                                                                  .withOpacity(
                                                                      0.3))),
                                                  counterStyle: TextStyle(
                                                      color: isDarkMode == false
                                                          ? Colors.black
                                                          : Colors.black45),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : Colors.black
                                                          .withOpacity(0.71),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: s.height * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0, right: 10),
                                            child: SubmitButton(
                                                border: Border.all(
                                                    color: isDarkMode == false
                                                        ? AppColors.colorblack
                                                            .withOpacity(0.3)
                                                        : Colors.white
                                                            .withOpacity(0.2)),
                                                textColor: isDarkMode == true
                                                    ? AppColors.colorwhite
                                                    : AppColors.colorblack,
                                                backGroundColor:
                                                    isDarkMode == true
                                                        ? Color(0xff343434)
                                                        : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                heightButton: s.height * 0.05,
                                                widthButton: s.width * 0.30,
                                                textButton: "Cancel",
                                                onPressed: () {
                                                  Get.back();
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                }),
                                          ),
                                          Consumer<
                                              PostObjSummaryAchivementAssociationController>(
                                            builder: (context, val, child) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7, left: 10),
                                                child: Center(
                                                    child: Material(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  color: ColorApp.colorprimary,
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    splashColor: AppColors
                                                        .colorindigo
                                                        .withOpacity(0.8),
                                                    onTap: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        if (thisUnique ==
                                                            'snapshot.data.objective') {
                                                          val
                                                              .jobSeekerAddObjectives(
                                                                  aboutController
                                                                      .text,
                                                                  aboutId
                                                                      .toString(),
                                                                  context)
                                                              .then((value) {
                                                            GlobalVarData
                                                                    .objectiveFuture =
                                                                GetObjectController()
                                                                    .jobSeekerObjectives();
                                                            Get.back();
                                                            Navigator.popUntil(
                                                                context,
                                                                (route) => route
                                                                    .isFirst);
                                                          });
                                                        } else if (thisUnique ==
                                                            ' snapshot.data.association') {
                                                          val
                                                              .jobSeekerAddAssociation(
                                                                  aboutController
                                                                      .text,
                                                                  aboutId
                                                                      .toString(),
                                                                  context)
                                                              .then((value) {
                                                            GlobalVarData
                                                                    .associationFuture =
                                                                GetJobSeekerAssociationController()
                                                                    .jobSeekerAssociation();
                                                            Get.back();
                                                            Navigator.popUntil(
                                                                context,
                                                                (route) => route
                                                                    .isFirst);
                                                          });
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                        height:
                                                            s.height * 0.051,
                                                        width: s.width * 0.36,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Center(
                                                            child: val.loadingSeeker ==
                                                                    false
                                                                ? Text(
                                                                    "Save Changes",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: isDarkMode ==
                                                                                false
                                                                            ? AppColors.colorwhite
                                                                            : Colors.white),
                                                                  )
                                                                : CircularProgressIndicator())),
                                                  ),
                                                )),
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
                          ),
                        ),
                      ),
                    ))),
          ],
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  coverLatter(
      {aboutId, String? aboutDate, headerText, subtitle, onSave, namedata}) {
    final s = MediaQuery.of(context).size;
    ABD abd = ABD();
    String aboutData1 = aboutDate.toString() == 'null' ? '' : aboutDate!;
    aboutController.text = aboutData1;

    aboutController.selection =
        TextSelection.collapsed(offset: aboutController.text.length);
    DataServices dataServices = DataServices();

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Wrap(
          children: <Widget>[
            Container(
                width: s.width,
                height: s.height,
                child: Scaffold(
                    backgroundColor:
                        isDarkMode == true ? Color(0xff343434) : Colors.white,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: isDarkMode == false
                          ? ColorApp.colorblackgalf.withOpacity(0.7)
                          : Color(0xff787777).withOpacity(0.7),
                      automaticallyImplyLeading: false,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(namedata,
                            style: TextStyle(
                                color: isDarkMode == false
                                    ? ColorApp.colorblack.withOpacity(0.6)
                                    : ColorApp.colorbackground
                                        .withOpacity(0.69))),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          color: isDarkMode == true
                              ? Color(0xff343434)
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8, left: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            "Introduce your self edit your profile to show client you have the skills and Experienc they are looking for",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: isDarkMode == false
                                                    ? ColorApp.colorblack
                                                        .withOpacity(0.6)
                                                    : ColorApp.colorbackground
                                                        .withOpacity(0.69),
                                                fontWeight: FontWeight.w400),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter cover latter';
                                                  }
                                                  return null;
                                                },
                                                controller: aboutController,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: null,
                                                minLines: 8,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorApp
                                                            .colorprimary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      borderSide: BorderSide(
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.3)
                                                              : Colors.black54
                                                                  .withOpacity(
                                                                      0.3))),
                                                  filled: true,
                                                  fillColor: isDarkMode == true
                                                      ? Color(0xff343434)
                                                      : Colors.white,
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.3)
                                                              : Colors.black54
                                                                  .withOpacity(
                                                                      0.3))),
                                                  counterStyle: TextStyle(
                                                      color: isDarkMode == false
                                                          ? Colors.black
                                                          : Colors.black45),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : Colors.black
                                                          .withOpacity(0.71),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: s.height * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0, right: 10),
                                            child: SubmitButton(
                                                border: Border.all(
                                                    color: isDarkMode == false
                                                        ? AppColors.colorblack
                                                            .withOpacity(0.3)
                                                        : Colors.white
                                                            .withOpacity(0.2)),
                                                textColor: isDarkMode == true
                                                    ? AppColors.colorwhite
                                                    : AppColors.colorblack,
                                                backGroundColor:
                                                    isDarkMode == true
                                                        ? Color(0xff343434)
                                                        : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                heightButton: s.height * 0.05,
                                                widthButton: s.width * 0.30,
                                                textButton: "Cancel",
                                                onPressed: () {
                                                  Get.back();
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                }),
                                          ),
                                          Consumer<
                                              PostObjSummaryAchivementAssociationController>(
                                            builder: (context, val, child) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7, left: 10),
                                                child: Center(
                                                    child: Material(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  color: ColorApp.colorprimary,
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    splashColor: AppColors
                                                        .colorindigo
                                                        .withOpacity(0.8),
                                                    onTap: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        val
                                                            .jobSeekerAddAssociation(
                                                                aboutController
                                                                    .text,
                                                                aboutId
                                                                    .toString(),
                                                                context)
                                                            .then((value) {
                                                          GlobalVarData
                                                                  .associationFuture =
                                                              GetJobSeekerAssociationController()
                                                                  .jobSeekerAssociation();
                                                          Get.back();
                                                          Navigator.popUntil(
                                                              context,
                                                              (route) => route
                                                                  .isFirst);
                                                        });
                                                      }
                                                      // } else if (thisUnique ==
                                                      //     'snapshot.data.summary') {
                                                      //   val
                                                      //       .jobSeekerAddSummary(
                                                      //           aboutController
                                                      //               .text,
                                                      //           aboutId
                                                      //               .toString(),
                                                      //           context)
                                                      //       .then((value) {
                                                      //     GlobalVarData
                                                      //             .summeryFuture =
                                                      //         GetSummaryController()
                                                      //             .jobSeekerSummary();
                                                      //     Navigator.pop(context);
                                                      //   });
                                                      // } else if (thisUnique ==
                                                      //     'snapshot.data.achievement') {
                                                      //   val
                                                      //       .jobSeekerAddAchievement(
                                                      //           aboutController
                                                      //               .text,
                                                      //           aboutId
                                                      //               .toString(),
                                                      //           context)
                                                      //       .then((value) {
                                                      //     GlobalVarData
                                                      //             .achievementFuture =
                                                      //         GetJobSeekerAchievementController()
                                                      //             .jobSeekerAchievement();
                                                      //     Navigator.pop(context);
                                                      //   });
                                                      // }
                                                    },
                                                    child: Container(
                                                        height:
                                                            s.height * 0.051,
                                                        width: s.width * 0.36,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Center(
                                                            child: val.loadingAddAssociation ==
                                                                    false
                                                                ? Text(
                                                                    "Save Changes",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: isDarkMode ==
                                                                                false
                                                                            ? AppColors.colorwhite
                                                                            : Colors.white),
                                                                  )
                                                                : CircularProgressIndicator())),
                                                  ),
                                                )),
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
                          ),
                        ),
                      ),
                    ))),
          ],
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  about({aboutId, String? aboutDate, headerText, subtitle, onSave, namedata}) {
    final s = MediaQuery.of(context).size;
    ABD abd = ABD();
    String aboutData1 = aboutDate.toString() == 'null' ? '' : aboutDate!;
    aboutController.text = aboutData1;

    aboutController.selection =
        TextSelection.collapsed(offset: aboutController.text.length);
    DataServices dataServices = DataServices();

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Wrap(
          children: <Widget>[
            Container(
                width: s.width,
                height: s.height,
                child: Scaffold(
                    backgroundColor:
                        isDarkMode == true ? Color(0xff343434) : Colors.white,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: isDarkMode == false
                          ? ColorApp.colorblackgalf.withOpacity(0.7)
                          : Color(0xff787777).withOpacity(0.7),
                      automaticallyImplyLeading: false,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(namedata,
                            style: TextStyle(
                                color: isDarkMode == false
                                    ? ColorApp.colorblack.withOpacity(0.6)
                                    : ColorApp.colorbackground
                                        .withOpacity(0.69))),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          color: isDarkMode == true
                              ? Color(0xff343434)
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8, left: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            "Introduce your self edit your profile to show client you have the skills and Experienc they are looking for",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: isDarkMode == false
                                                    ? ColorApp.colorblack
                                                        .withOpacity(0.6)
                                                    : ColorApp.colorbackground
                                                        .withOpacity(0.69),
                                                fontWeight: FontWeight.w400),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter About text';
                                                  }
                                                  return null;
                                                },
                                                controller: aboutController,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: null,
                                                minLines: 8,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorApp
                                                            .colorprimary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      borderSide: BorderSide(
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.3)
                                                              : Colors.black54
                                                                  .withOpacity(
                                                                      0.3))),
                                                  filled: true,
                                                  fillColor: isDarkMode == true
                                                      ? Color(0xff343434)
                                                      : Colors.white,
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.3)
                                                              : Colors.black54
                                                                  .withOpacity(
                                                                      0.3))),
                                                  counterStyle: TextStyle(
                                                      color: isDarkMode == false
                                                          ? Colors.black
                                                          : Colors.black45),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : Colors.black
                                                          .withOpacity(0.71),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: s.height * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0, right: 10),
                                            child: SubmitButton(
                                                border: Border.all(
                                                    color: isDarkMode == false
                                                        ? AppColors.colorblack
                                                            .withOpacity(0.3)
                                                        : Colors.white
                                                            .withOpacity(0.2)),
                                                textColor: isDarkMode == true
                                                    ? AppColors.colorwhite
                                                    : AppColors.colorblack,
                                                backGroundColor:
                                                    isDarkMode == true
                                                        ? Color(0xff343434)
                                                        : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                heightButton: s.height * 0.05,
                                                widthButton: s.width * 0.30,
                                                textButton: "Cancel",
                                                onPressed: () {
                                                  Get.back();
                                                  Navigator.popUntil(context,
                                                      (route) => route.isFirst);
                                                }),
                                          ),
                                          Consumer<
                                              PostObjSummaryAchivementAssociationController>(
                                            builder: (context, val, child) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7, left: 10),
                                                child: Center(
                                                    child: Material(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  color: ColorApp.colorprimary,
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    splashColor: AppColors
                                                        .colorindigo
                                                        .withOpacity(0.8),
                                                    onTap: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        val
                                                            .jobSeekerAddSummary(
                                                                aboutController
                                                                    .text,
                                                                aboutId
                                                                    .toString(),
                                                                context)
                                                            .then((value) {
                                                          GlobalVarData
                                                                  .summeryFuture =
                                                              GetSummaryController()
                                                                  .jobSeekerSummary();
                                                          Get.back();
                                                          Navigator.popUntil(
                                                              context,
                                                              (route) => route
                                                                  .isFirst);
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                        height:
                                                            s.height * 0.051,
                                                        width: s.width * 0.36,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Center(
                                                            child: val.loadingSeekerSummary ==
                                                                    false
                                                                ? Text(
                                                                    "Save Changes",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: isDarkMode ==
                                                                                false
                                                                            ? AppColors.colorwhite
                                                                            : Colors.white),
                                                                  )
                                                                : CircularProgressIndicator())),
                                                  ),
                                                )),
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
                          ),
                        ),
                      ),
                    ))),
          ],
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  SkillDeleteAlert(BuildContext context, id, deleteText, subtitle, subtitle2,
      uniqueId, title) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor:
          isDarkMode == true ? ColorApp.colorbgbtn : ColorApp.colorbgbtn,
      insetPadding: EdgeInsets.only(
        bottom: Get.height * 0.42,
        top: Get.height * 0.3,
        left: Get.width * 0.04,
        right: Get.width * 0.04,
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      actions: [
        Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: isDarkMode == true
                        ? ColorApp.colornewblack
                        : Colors.grey),
                width: MediaQuery.of(context).size.width,
                height: Get.height * 0.06,
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.02, top: 12),
                  child: Text(
                    deleteText,
                    style: TextStyle(
                      color: isDarkMode == true
                          ? ColorApp.colorbackground
                          : ColorApp.colorbackground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: "this will delete" + " ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Montserrat",
                                              fontSize: 15,
                                              color: isDarkMode == true
                                                  ? ColorApp.colornewblack
                                                  : ColorApp.colornewblack),
                                          children: <TextSpan>[
                                        TextSpan(
                                          text: '"$title"',
                                          style: TextStyle(
                                            color: isDarkMode == true
                                                ? ColorApp.colorprimary
                                                : ColorApp.colorprimary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                          ),
                                        ),
                                        TextSpan(
                                          text: " " +
                                              'from all section of Your Profile',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Montserrat",
                                              fontSize: 15,
                                              color: isDarkMode == true
                                                  ? ColorApp.colornewblack
                                                  : ColorApp.colornewblack),
                                        ),
                                      ])),
                                ],
                              )),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.3,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (uniqueId == 'profileSkillDelete') {
                        deleteDataSkill = false;
                        Navigator.pop(context);
                      } else if (uniqueId == 'profileCareerLavelDelete') {
                        jobCareerLevel = false;
                        Navigator.pop(context);
                      } else if (uniqueId == 'profileGalleryDelete') {
                        jobGallery = false;
                        Navigator.pop(context);
                      } else if (uniqueId == 'workAuthDelete') {
                        workAuthDelete = false;
                        Navigator.pop(context);
                      } else if (uniqueId == 'profilePositionDelete') {
                        preferJobPosDlt = false;
                        Navigator.pop(context);
                      } else if (uniqueId == 'profileJobTypeDelete') {
                        preferJobTypeDlt = false;
                        Navigator.pop(context);
                      } else if (uniqueId == 'profileLanguageDelete') {
                        languageDlt = false;
                        Navigator.pop(context);
                      } else if (uniqueId == 'profileJobLocationDelete') {
                        jobPreferedLocation = false;
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorApp.colornewblack),
                      borderRadius: BorderRadius.circular(6),
                      color: ColorApp.colorbgbtn,
                    ),
                    child: Center(
                      child: Text(
                        'No, Thanks',
                        style: TextStyle(
                            fontSize: 15, color: ColorApp.colornewblack),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Consumer<PostDeleteAlertProfileBase>(
                  builder: (context, val, child) {
                    return ElevatedButton(
                      onPressed: () {
                        if (uniqueId == 'profileSkillDelete') {
                          setState(() {
                            deleteSkillLevel = false;
                            deleteDataSkill = false;
                          });
                          val.jobSkillDelete(id, context);
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              GlobalVarData.skillListFuture =
                                  GetJobSkillController().jobSeekerSkill();
                              deleteSkillLevel = true;
                            });
                          });
                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetJobSkillController>(context,
                                      listen: false)
                                  .skillListData
                                  .clear();
                              Provider.of<GetJobSkillController>(context,
                                      listen: false)
                                  .jobSeekerSkill();
                            });
                            Navigator.pop(context);
                          });
                        } else if (uniqueId == 'profileCareerLavelDelete') {
                          setState(() {
                            deleteCareelLevel = false;
                            jobCareerLevel = false;
                          });
                          val.jobSeekerDeleteCareerLevel(id, context);
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              setState(() {
                                GlobalVarData.pereferredJobCareerLevel =
                                    GetJobSeekerCareerLevelController()
                                        .getJobSeekerCareerLevel();
                                deleteCareelLevel = true;
                              });
                            });
                          });
                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetJobSeekerCareerLevelController>(
                                      context,
                                      listen: false)
                                  .getJobSeekerCareerLevel();
                              Provider.of<GetJobSeekerCareerLevelController>(
                                      context,
                                      listen: false)
                                  .getJobSeekerCareerLevel();
                            });
                            Navigator.pop(context);
                          });
                        } else if (uniqueId == 'workAuthDelete') {
                          setState(() {
                            deleteWorkAuthLevel = false;
                            workAuthDelete = false;
                          });
                          val.jobWorkAuthDelete(id, context);
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              setState(() {
                                GlobalVarData.workAuthListFuture =
                                    GetWorkAuthorizationController()
                                        .getJobSeekerWorkAuthorization();
                                deleteWorkAuthLevel = true;
                              });
                            });
                          });
                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetWorkAuthorizationController>(
                                      context,
                                      listen: false)
                                  .workAuthListData
                                  .clear();
                              Provider.of<GetWorkAuthorizationController>(
                                      context,
                                      listen: false)
                                  .getJobSeekerWorkAuthorization();
                            });
                            Navigator.pop(context);
                          });
                        } else if (uniqueId == 'profilePositionDelete') {
                          setState(() {
                            deletePositionLevel = false;
                            preferJobPosDlt = false;
                          });
                          val.jobPreferredPositionDelete(id, context);
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              setState(() {
                                GlobalVarData.pereferredPositionListFuture =
                                    GetPreferredPositionController()
                                        .getJobSeekerPreferredPosition();
                                deletePositionLevel = true;
                              });
                            });
                          });
                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetPreferredPositionController>(
                                      context,
                                      listen: false)
                                  .preferredPositionListData
                                  .clear();
                              Provider.of<GetPreferredPositionController>(
                                      context,
                                      listen: false)
                                  .getJobSeekerPreferredPosition();
                            });
                            Navigator.pop(context);
                          });
                        } else if (uniqueId == 'profileJobTypeDelete') {
                          setState(() {
                            deleteJobTypeLevel = false;
                            preferJobTypeDlt = false;
                          });
                          val.jobTypeDelete(id, context);
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              setState(() {
                                GlobalVarData.pereferredJobTypeListFuture =
                                    GetPreferredJobTypeController()
                                        .getJobSeekerPreferredJobType();
                                deleteJobTypeLevel = true;
                              });
                            });
                          });
                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetPreferredJobTypeController>(
                                      context,
                                      listen: false)
                                  .preferredJobTypeListData
                                  .clear();
                              Provider.of<GetPreferredJobTypeController>(
                                      context,
                                      listen: false)
                                  .getJobSeekerPreferredJobType();
                            });
                            Navigator.pop(context);
                          });
                        } else if (uniqueId == 'profileLanguageDelete') {
                          setState(() {
                            deleteJobLanguage = false;
                            languageDlt = false;
                          });
                          val.jobLanguageDelete(id, context);
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              setState(() {
                                GlobalVarData.languageListFuture =
                                    GetLanguageController()
                                        .getJobSeekerLanguage();
                                deleteJobLanguage = true;
                              });
                            });
                          });

                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetLanguageController>(context,
                                      listen: false)
                                  .languageListData
                                  .clear();
                              Provider.of<GetLanguageController>(context,
                                      listen: false)
                                  .getJobSeekerLanguage();
                            });
                            Navigator.pop(context);
                          });
                        } else if (uniqueId == 'profileGalleryDelete') {
                          setState(() {
                            deleteGallery = false;
                            jobGallery = false;
                            // languageDlt=false;
                          });
                          val.jobGalleryDelete(id, context);
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              setState(() {
                                GlobalVarData.pereferredJobGallery =
                                    GetGalleryController().getGallery();
                                deleteGallery = true;
                              });
                            });
                          });
                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetGalleryController>(context,
                                      listen: false)
                                  .galleryListData
                                  .clear();
                              Provider.of<GetGalleryController>(context,
                                      listen: false)
                                  .getGallery();
                            });
                            Navigator.pop(context);
                          });
                        } else if (uniqueId == 'profileJobLocationDelete') {
                          // setState(() {
                          //   deleteJobLocation = false;
                          //   jobPreferedLocation = false;
                          // });
                          val.jobTypeDeleteLocation(id, context);
                          Timer(Duration(seconds: 2), () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Provider.of<GetPreferredJobSeekerLocation>(
                                      context,
                                      listen: false)
                                  .preferredJobLocationListData
                                  .clear();
                              Provider.of<GetPreferredJobSeekerLocation>(
                                      context,
                                      listen: false)
                                  .getJobSeekerPreferredJobLocation();
                            });
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        )),
                        shadowColor: MaterialStateProperty.all(Colors.red),
                        backgroundColor:
                            MaterialStateProperty.all(ColorApp.colorprimary),
                      ),
                      child: val.loadingSkillDelete == false
                          ? Text(
                              "Delete",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: isDarkMode == false
                                      ? AppColors.colorwhite
                                      : Colors.white),
                            )
                          : SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator()),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
