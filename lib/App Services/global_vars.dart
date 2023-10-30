import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/GetjobSeekerCareerLevelModel.dart';
import '../model/applied_job_model.dart';
import '../model/cuntom_user_profile_model.dart';
import '../model/get_resume_model.dart';
import '../model/get_salary_model.dart';
import '../model/job_seeker_career_level_model.dart';
import '../model/job_seeker_certification_model.dart';
import '../model/job_seeker_gallary_model.dart';
import '../model/job_seeker_gender_model.dart';
import '../model/job_seeker_job_location_model.dart';
import '../model/job_seeker_language_model.dart';
import '../model/job_seeker_martial_status_model.dart';
import '../model/job_seeker_objective_model.dart';
import '../model/job_seeker_preferred_position_model.dart';
import '../model/job_seeker_preferred_type_model.dart';
import '../model/job_seeker_ready_to_work_model.dart';
import '../model/job_seeker_relocation_model.dart';
import '../model/job_seeker_summary_model.dart';
import '../model/job_seeker_w_auth_model.dart';
import '../model/profile_personal_info_model.dart';
import '../model/saved_job_model.dart';
import '../profile_model/job_seeker_achievement_model.dart';
import '../profile_model/job_seeker_association_model.dart';
import '../profile_model/job_seeker_education_model.dart';
import '../profile_model/job_seeker_skill_model.dart';
import '../profile_model/job_seeker_work_experience_model.dart';

class GlobalVarData{
  static final tokenData = GetStorage();
  static String? temp = tokenData.read('tokenProvider');
  static String cupertinoSession = temp.toString();
  static String sessionData = 'null';
  static String personalInfoDataUpdated = 'null';
  static String personalInfoApplyData = 'null';
  static String navDivided = '2';
  static String navTabBar = '1';
  static String maritalStatus = 'null';
  static String genderStatus = 'null';
  static String salaryStatus = 'null';
  static String careelLevel = 'null';
  static String certificationadd = 'null';
  static String addEducation = 'null';
  static String objectiveDataUpdated = 'null';
  static String isEducationUpdate = 'notDone';
  static String isEducationAdd = 'notDone';
  static String isExperienceAdd = 'notDone';
  static String isExperienceUpdate = 'notDone';
  static String isSkillAdd = 'notDone';
  static String  isAppBarCalled = 'not';
  //histry related api data var
  static Future<AppliedJobModel>? appliedFuture;
  static Future<SavedJobModel>? savedFuture;
  //profile related api data var
  static Future<dynamic>? personalInfoFuture;
  static Future<UserCustomDataModel>? personalApplayFuture;
  static Future<JobSeekerObjectiveModel>? objectiveFuture;
  static Future<List<JobseekerEducationModel>>? educationListFuture;
  static Future<List<JobseekerWorkExperienceModel>>? experienceListFuture;
  static Future<JobSeekerGenderModel>? genderListFuture;
  static Future<JobSeekerStatusModel>? MartialListFuture;
  static Future<List<JobseekerSkillModel>>? skillListFuture;

  static Future<List<JobSeekerCertificationsModel>>? certificationsListFuture;
  static Future<List<JobSeekerWorkAuthorizationModel>>? workAuthListFuture;
  static Future<List<JobSeekerLanguageModel>>? languageListFuture;
  static Future<JobSeekerCareerLevelModel>? pereferredJobCareerLevel;
  static Future<List<JobSeekerGalleryModel>>? pereferredJobGallery;
 static Future<GetjobseekerExpectedSalaryModel>? salaryList;
 static Future<List<GetResumeModel>>? resumeList;
  static Future<List<JobSeekerJobLocationModel>>? preferedJoblocationListFuture;
  static Future<List<JobSeekerPreferredPositionModel>>? pereferredPositionListFuture;
  static Future<List<JobSeekerPreferredTypeModel>>? pereferredJobTypeListFuture;
  static Future<JobSeekerSummaryModel>? summeryFuture;
  static Future<JobSeekerObjectiveModel>? objectiveFuture1;
  static Future<jobseekerAchievementModel>? achievementFuture;
  static Future<jobseekerAssociationModel>? associationFuture;
  static Future<JobSeekerReadyToWorkModel>? pereferredReadyToWorklist;
  static Future<JobSeekerRelocationModel>? pereferredJobSeekerRelocationlist;

}