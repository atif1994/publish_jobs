import 'dart:async';
import 'dart:convert';

import 'package:firstapp/model/GetjobSeekerCareerLevelModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../App Services/global_vars.dart';
import '../../component_pages/CupertinoTabBar/cupertino_tab_bar.dart';
import '../../model/email_check_model.dart';
import '../Home Get Apis/get_applied_jobs_controller.dart';
import '../Home Get Apis/get_saved_jobs_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_certificationList_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_experience_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_gallery_Controller.dart';
import '../Profile Controllers/Profile Get Apis/get_job_seeker_association_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_job_skill_list_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_jobseeker_career_level_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_jobseeker_gender_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_language_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_personal_objective_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_preferred_job_location_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_preferred_job_type_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_preferred_position_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_qualification_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_ready_to_work_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_relocation_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_resume_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_summary_controller.dart';
import '../Profile Controllers/Profile Get Apis/get_work_authorization_controller.dart';

class PostRegisterApiWithSessionController with ChangeNotifier {
  String incurrectPassword = '';
  bool loading = false;
  bool isLoading = false;
  bool dataload = false;
  String emailCheck = 'guest';
  String token = '';
  bool emailCheckLoading = false;
  setData(String tokenVal) {
    token = tokenVal;
    notifyListeners();
  }

  Future<EmailCheckModel> checkEmail(String email) async {
    emailCheckLoading = true;

    var data;
    notifyListeners();
    try {
      String url = "https://api.publish.jobs/api/checkEmail?email=$email";
      Response response = await post(
        Uri.parse(url),
        body: {
          'email': email,
        },
        //headers: requestHeaders
      );
      data = jsonDecode(response.body.toString());
      emailCheckLoading = false;
      return EmailCheckModel.fromJson(data);
    } catch (e) {
      emailCheckLoading = false;
      notifyListeners();
      print(e.toString());
      return EmailCheckModel.fromJson(data);
    }
  }

  logInApiWithSession(String email, password, deviceId, BuildContext context, String checkNav) async {
    print('${checkNav}check navvvvvvvvvvvvvvvvvv123');
    loading = true;
    notifyListeners();
    try {
      String url =
          "https://api.publish.jobs/api/token?email=$email&password=$password&device_name=$deviceId";
      Response response = await post(Uri.parse(url), body: {
        'email': email,
        "password": password,
        "device_name": deviceId,
      });
      if (response.statusCode == 200) {
        print('${checkNav}check navvvvvvvvvvvvvvvvvv under 200');
        var data = jsonDecode(response.body.toString());
        print('hrereeeeeeeeeeee0000');
        print(data['error'].toString());
       // print(data['user']['email']);
        loading = false;
        notifyListeners();
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);


        if (data['error'] != 'The provided credentials are incorrect.') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('emailProvider', email);
          await prefs.setString('checkCupertinoSearchAuh', 'yes');
          await prefs.setString('checkCupertinoHistoryAuth', 'yes');
          await prefs.setString('checkCupertinoSearchAuh', 'yes');
          await prefs.setString('tokenProvider', data['access_token']);
          final tokenData = GetStorage();
          tokenData.write('tokenProvider', data['access_token']);
          notifyListeners();
          GlobalVarData.sessionData = data['access_token'];
          if (checkNav == 'profile') {
            if (kDebugMode) {
              print("${checkNav}check nav under profile");
            }
            GlobalVarData.cupertinoSession = data['access_token'];
            Get.to(Bar(
             id: 3,
            ));
          } else if (checkNav == 'history') {
            GlobalVarData.cupertinoSession = data['access_token'];
            if (kDebugMode) {
              print('under history');
            }
            Get.to(Bar(
              id: 2,
            ));
          }
          else if (checkNav == 'jobsScreen') {
            GlobalVarData.cupertinoSession = data['access_token'];

            Get.off(Bar(
              id: 0,
            ));
          }
          else if (checkNav == 'drawer') {
            GlobalVarData.cupertinoSession = data['access_token'];

            Get.off(Bar(
              id: 0,
            ));
          }
          else
          {
            GlobalVarData.cupertinoSession = data['access_token'];
            GlobalVarData.appliedFuture =
                GetAppliedJobsController().getAppliedJobs();
            GlobalVarData.savedFuture = GetSavedJobsController().getSavedJobs();
            //profile initialization
            // GlobalVarData.personalInfoFuture = DataServices().getProfilePersonalInfo(context);
            GlobalVarData.pereferredJobSeekerRelocationlist =
                GetRelocationController().getJobRelocation();
            Timer(const Duration(milliseconds: 600), () {
              GlobalVarData.objectiveFuture =
                  GetObjectController().jobSeekerObjectives();
            });

            Timer(const Duration(milliseconds: 900), () {
              GlobalVarData.educationListFuture =
                  GetQualificationController().getEducationList();
            });
            Timer(const Duration(milliseconds: 1100), () {
              GlobalVarData.experienceListFuture =
                  GetExperienceController().getWorkExperienceList();
            });
            Timer(const Duration(milliseconds: 1500), () {
              GlobalVarData.skillListFuture =
                  GetJobSkillController().jobSeekerSkill();
            });
            Timer(const Duration(milliseconds: 1800), () {
              GlobalVarData.pereferredJobGallery =
                  GetGalleryController().getGallery();
            });
            Timer(const Duration(milliseconds: 2100), () {
              GlobalVarData.summeryFuture =
                  GetSummaryController().jobSeekerSummary();
            });
            Timer(const Duration(milliseconds: 2400), () {
              GlobalVarData.associationFuture =
                  GetJobSeekerAssociationController().jobSeekerAssociation();
            });
            Timer(const Duration(milliseconds: 2600), () {
              GlobalVarData.workAuthListFuture =
                  GetWorkAuthorizationController()
                      .getJobSeekerWorkAuthorization();
            });
            Timer(const Duration(milliseconds: 2600), () {
              GlobalVarData.languageListFuture =
                  GetLanguageController().getJobSeekerLanguage();
            });
            Timer(const Duration(milliseconds: 2800), () {
              GlobalVarData.pereferredPositionListFuture =
                  GetPreferredPositionController()
                      .getJobSeekerPreferredPosition();
            });
            Timer(const Duration(milliseconds: 3000), () {
              GlobalVarData.preferedJoblocationListFuture =
                  GetPreferredJobSeekerLocation()
                      .getJobSeekerPreferredJobLocation();
            });
            Timer(const Duration(milliseconds: 3200), () {
              GlobalVarData.pereferredJobTypeListFuture =
                  GetPreferredJobTypeController()
                      .getJobSeekerPreferredJobType();
            });
            Timer(const Duration(milliseconds: 900), () {
              GlobalVarData.pereferredJobCareerLevel =
                  GetJobSeekerCareerLavel().getJobSeekerCareerLevel()
                      as Future<JobSeekerCareerLevelModel>?;
            });
            Timer(const Duration(milliseconds: 900), () {
              GlobalVarData.resumeList = GetResumeController().GetResume();
            });
            Timer(const Duration(milliseconds: 3600), () {
              GlobalVarData.pereferredReadyToWorklist =
                  GetReadyToWorkController().getJobReadyToWork();
            });
            Timer(const Duration(milliseconds: 600), () {
              GlobalVarData.certificationsListFuture =
                  GetCertificationController().jobSeekerCertifications();
            });
            GlobalVarData.genderListFuture =
                GetJobSeekerGenderController().getJobSeekerGender();
            Timer(const Duration(milliseconds: 3000), () {
              GlobalVarData.objectiveFuture1 =
                  GetObjectController().jobSeekerObjectives();
            });
            Get.back();
          }
          //Get.defaultDialog(title: data['error']);
        }
        else {
          incurrectPassword = data['error'];
          notifyListeners();
        }
      } else {
        print('failed login status: ' + response.statusCode.toString());
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e.toString() + 'exceptionnnnnnnn');
    }
  }

  registerApiWithSession(
      String email, password, deviceId, BuildContext context,String checkNav) async {
    loading = true;
    notifyListeners();
    try {
      String url =
          "https://api.publish.jobs/api/signup?email=$email&password=$password&device_name=$deviceId";
      Response response = await post(Uri.parse(url), body: {
        'email': email,
        "password": password,
        "device_name": deviceId,
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        loading = false;
        notifyListeners();
        // UserModel userModel = UserModel(token: data['access_token'],email: data['user']['email']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('emailProvider', email);
        await prefs.setString('checkCupertinoSearchAuh', 'yes');
        await prefs.setString('checkCupertinoHistoryAuth', 'yes');
        await prefs.setString('checkCupertinoSearchAuh', 'yes');
        await prefs.setString('tokenProvider', data['access_token']);
        final tokenData = GetStorage();
        tokenData.write('tokenProvider', data['access_token']);
        print(prefs.getString('tokenProvider' + 'tokennnnnnnnnnnnnn'));
        notifyListeners();
        print(checkNav+"check vavvvvvvvvvvvvvvvvvvvvvv upper profile");
        if (checkNav == 'profile') {
          print(checkNav+"check vavvvvvvvvvvvvvvvvvvvvvv under profile");
          GlobalVarData.cupertinoSession = data['access_token'];
          Get.to(Bar(
            id: 3,
          ));
        } else if (checkNav == 'history') {
          GlobalVarData.cupertinoSession = data['access_token'];
          Get.to(Bar(
            id: 2,
          ));
        }
        else if (checkNav == 'jobsScreen') {
          GlobalVarData.cupertinoSession = data['access_token'];

          Get.off(Bar(
            id: 0,
          ));
        }
        else if (checkNav == 'drawer') {
          GlobalVarData.cupertinoSession = data['access_token'];

          Get.off(Bar(
            id: 0,
          ));
        }
        else {
          GlobalVarData.cupertinoSession = data['access_token'];
          GlobalVarData.appliedFuture =
              GetAppliedJobsController().getAppliedJobs();
          GlobalVarData.savedFuture = GetSavedJobsController().getSavedJobs();
          GlobalVarData.pereferredJobSeekerRelocationlist =
              GetRelocationController().getJobRelocation();
          Timer(const Duration(milliseconds: 600), () {
            GlobalVarData.objectiveFuture =
                GetObjectController().jobSeekerObjectives();
          });

          Timer(const Duration(milliseconds: 900), () {
            GlobalVarData.educationListFuture =
                GetQualificationController().getEducationList();
          });
          Timer(const Duration(milliseconds: 1100), () {
            GlobalVarData.experienceListFuture =
                GetExperienceController().getWorkExperienceList();
          });
          Timer(const Duration(milliseconds: 1500), () {
            GlobalVarData.skillListFuture =
                GetJobSkillController().jobSeekerSkill();
          });
          Timer(const Duration(milliseconds: 1800), () {
            GlobalVarData.pereferredJobGallery =
                GetGalleryController().getGallery();
          });
          Timer(const Duration(milliseconds: 2100), () {
            GlobalVarData.summeryFuture =
                GetSummaryController().jobSeekerSummary();
          });
          Timer(const Duration(milliseconds: 2400), () {
            GlobalVarData.associationFuture =
                GetJobSeekerAssociationController().jobSeekerAssociation();
          });
          Timer(const Duration(milliseconds: 2600), () {
            GlobalVarData.workAuthListFuture =
                GetWorkAuthorizationController()
                    .getJobSeekerWorkAuthorization();
          });
          Timer(const Duration(milliseconds: 2600), () {
            GlobalVarData.languageListFuture =
                GetLanguageController().getJobSeekerLanguage();
          });
          Timer(const Duration(milliseconds: 2800), () {
            GlobalVarData.pereferredPositionListFuture =
                GetPreferredPositionController()
                    .getJobSeekerPreferredPosition();
          });
          Timer(const Duration(milliseconds: 3000), () {
            GlobalVarData.preferedJoblocationListFuture =
                GetPreferredJobSeekerLocation()
                    .getJobSeekerPreferredJobLocation();
          });
          Timer(const Duration(milliseconds: 3200), () {
            GlobalVarData.pereferredJobTypeListFuture =
                GetPreferredJobTypeController()
                    .getJobSeekerPreferredJobType();
          });
          Timer(const Duration(milliseconds: 900), () {
            GlobalVarData.pereferredJobCareerLevel =
            GetJobSeekerCareerLavel().getJobSeekerCareerLevel()
            as Future<JobSeekerCareerLevelModel>?;
          });
          Timer(const Duration(milliseconds: 900), () {
            GlobalVarData.resumeList = GetResumeController().GetResume();
          });
          Timer(const Duration(milliseconds: 3600), () {
            GlobalVarData.pereferredReadyToWorklist =
                GetReadyToWorkController().getJobReadyToWork();
          });
          Timer(const Duration(milliseconds: 600), () {
            GlobalVarData.certificationsListFuture =
                GetCertificationController().jobSeekerCertifications();
          });
          GlobalVarData.genderListFuture =
              GetJobSeekerGenderController().getJobSeekerGender();
          Timer(const Duration(milliseconds: 3000), () {
            GlobalVarData.objectiveFuture1 =
                GetObjectController().jobSeekerObjectives();
          });
          Get.back();
        }
      } else {
        print('failed register: ' + response.statusCode.toString());
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  void logoutAPI(BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String tokenHeader = await pref.getString('tokenProvider').toString();
      if (tokenHeader != 'null') {
        Map<String, String> requestHeaders = {
          'Authorization': 'Bearer ' + tokenHeader
        };
        String url = 'https://api.publish.jobs/api/logoutMb';
        Response response = await post(Uri.parse(url), headers: requestHeaders);
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('checkCupertinoSearchAuh');
      preferences.remove('checkCupertinoHistoryAuth');
      preferences.remove('tokenProvider');
      preferences.remove('emailProvider');
      final tokenData = GetStorage();
      tokenData.remove('tokenProvider');
      // tokenData.write('tokenProvider', 'null');
      GlobalVarData.cupertinoSession = 'null';
      await preferences.clear();
      Navigator.of(context ,rootNavigator: true).push(MaterialPageRoute(builder: (context) => Bar(id: 0,)));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e.toString());
      Navigator.of(context ,rootNavigator: true).push(MaterialPageRoute(builder: (context) => Bar(id: 0,)));
    }
  }
}
