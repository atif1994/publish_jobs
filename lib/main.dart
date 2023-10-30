import 'package:firstapp/App%20Services/api_services_provider.dart';
import 'package:firstapp/Network%20Controller/Appbar%20Controller/get_appbar_controller.dart';
import 'package:firstapp/api/api.dart';

import 'package:firstapp/views_screen/splash_screen/splash_screen1.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App Services/Jobs List Services/filter_city.dart';
import 'App Services/Jobs List Services/filter_country.dart';
import 'App Services/Jobs List Services/job_type.dart';
import 'Network Controller/Applay Controller/post_applay.dart';
import 'Network Controller/Applay Controller/post_applay_later_controller.dart';
import 'Network Controller/General Controllers/forgot_password_controller.dart';
import 'Network Controller/Home Get Apis/get_saved_jobs_controller.dart';
import 'Network Controller/Home Get Apis/get_socila_link_controller.dart';
import 'Network Controller/Home Post Apis/post_add_report_job_controller.dart';
import 'Network Controller/Home Post Apis/post_add_save_job_controller.dart';
import 'Network Controller/Home Post Apis/post_register_api_withsession_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_gallery_Controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_jobSeekercareer_apply_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_certificationList_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_experience_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_job_skill_list_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_language_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_personal_objective_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_preferred_job_location_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_preferred_job_type_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_preferred_position_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_qualification_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_resume_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_salary_controller.dart';
import 'Network Controller/Profile Controllers/Profile Get Apis/get_work_authorization_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post__jobseekerAddExpectedSalary.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_add_career_level_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_add_language_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_add_personal_info_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_add_prefered_location_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_add_preferjob_type_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_add_resume_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_delete_AlertApi_profilebase_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_education_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_experience_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_genderController.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_job_skill_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_martial_status_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_obj_summ_achm_assoc_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_preferedjob_position_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_readyto_work_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_relocation_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_training_certification_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_updata_certification_controller.dart';
import 'Network Controller/Profile Controllers/Profile Post Apis/post_work_authorization_controller.dart';
import 'Network Controller/UpdatePassword Controller/updata_password_controller.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
  SharedPreferences preferences = await SharedPreferences.getInstance();
 String isLogin= preferences.getString('tokenHeader').toString();

  preferences.remove('tokenProviderTemp');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ifPfofileData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String isLogin= preferences.getString('tokenProvider').toString();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => ABD(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostAddPersonalInfoController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostEducationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostExperienceController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostDeleteAlertProfileBase(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostJobSkill(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostObjSummaryAchivementAssociationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostRelocationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostTrainingCertification(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostWorkAuthorizationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostReadyToWorkController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostMartialStatusController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostGenderController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostLanguageController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostPreferJobLocationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostPreferJobTypeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostPreferJobPositionController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostWorkAuthorizationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostRegisterApiWithSessionController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostAddSaveJobController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostAddReportJobController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostCareerLevelController(),
        ),
        ChangeNotifierProvider(
          create: (_) => UpdateTrainingCertification(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetQualificationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetExperienceController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetJobSkillController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetCertificationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetJobSeekerCareerLevelController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetPreferredJobSeekerLocation(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetWorkAuthorizationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetPreferredPositionController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetPreferredJobTypeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetLanguageController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetGalleryController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostAddResumeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => CityListService(),
        ),
        ChangeNotifierProvider(
          create: (_) => CountryListService(),
        ),
        ChangeNotifierProvider(
          create: (_) => JobTypeService(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostJobApplayController(),
        ),
        ChangeNotifierProvider(
          create: (_) => UpdatePasswordController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostAddExpectedSalaryController(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostApplayLaterController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetSocialLinksController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetSalaryController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetAppBarImageController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetSavedJobsController(),
        ),

        ChangeNotifierProvider(
          create: (_) => GetObjectController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ForgotPasswordController(),
        ),


      ],
      child: GetMaterialApp(

          debugShowCheckedModeBanner: false, home: SplashScreen()),
    );
  }
}
