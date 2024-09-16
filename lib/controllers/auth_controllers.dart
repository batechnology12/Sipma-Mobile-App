import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/city_list_model.dart';
import 'package:simpa/models/department_model.dart';
import 'package:simpa/models/get_postion_model.dart';
import 'package:simpa/models/industries_model.dart';
import 'package:simpa/models/profile_update_model.dart';
import 'package:simpa/models/register_model.dart';
import 'package:simpa/models/requiremets_models.dart';
import 'package:simpa/models/skills_model.dart';
import 'package:simpa/models/slider_model.dart';
import 'package:simpa/models/state_list_model.dart';
import 'package:simpa/models/student_profile_update_model.dart';
import 'package:simpa/services/network_api_services/auth_api_services/add_educatinal_skills_api_service.dart';
import 'package:simpa/services/network_api_services/auth_api_services/check_verify_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/fcm_token_store_api_service.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_city_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_departments_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_postion_service.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_requirements_list_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_skills_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_slider_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_states_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/login_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/register_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/register_otp_verify.dart';
import 'package:simpa/services/network_api_services/auth_api_services/send_verification_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/student_professional_api_service.dart';
import 'package:simpa/services/network_api_services/auth_api_services/student_update_profile_model.dart';
import 'package:simpa/services/network_api_services/auth_api_services/update_education_skills_api_service.dart';
import 'package:simpa/services/network_api_services/auth_api_services/update_profile_api_services.dart';
import 'package:simpa/services/network_api_services/auth_api_services/userType_update_api_service.dart';
import 'package:simpa/services/network_api_services/auth_api_services/user_name_check_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/education_list_api_services.dart';
import 'package:simpa/view/alert_box/widgets/onbording_profotional.dart';
import 'package:simpa/view/alert_box/widgets/onbording_students.dart';
import 'package:simpa/view/otp_page.dart';
import 'package:simpa/view/register_details_page.dart';
import 'package:simpa/view/register_splash.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_industries_api_services.dart';
import 'package:simpa/view/student_register_details_view_page.dart';
import '../models/get_education_list_model.dart';
import '../services/network_api_services/auth_api_services/otp_verify_api_services.dart';
import 'package:dio/dio.dart' as dio;

class AuthController extends GetxController {
  RxBool isDesignationSelected = false.obs;
  RxBool isInduaturesSelected = false.obs;
  RxBool isEducationSelected = false.obs;
  RxBool isLoading = false.obs;
  RxInt selctedIndex = 100.obs;
  RxInt wayIndex = 0.obs;
  RxInt professinalindex = 0.obs;
  RxInt mobileStatus = 0.obs;
  var selectedState;
  var selectedCity;
  var selectdt;
  var selectdt1;

  DateTime date1 = DateTime.now();
  DateTime date = DateTime.now();

  RxBool isUserNameAvailable = false.obs;

  RxBool isShowDialogActive = false.obs;

  List<Department> departments = [];
  List<SliderList> sliderList = [];

  List<Requirement> requirementList = [];

  List<StateList> stateList = [];
  List<CityList> cityList = [];

  GetDepartmentServicesApi getDepartmentServicesApi =
      GetDepartmentServicesApi();
  LoginServicesApi loginServicesApi = LoginServicesApi();
  OtpVerifyServicesApi otpVerifyServicesApi = OtpVerifyServicesApi();
  RegisterServicesApi registerServicesApi = RegisterServicesApi();
  ProfileUpdateServicesApi profileUpdateServicesApi =
      ProfileUpdateServicesApi();
  UserNameApiServices userNameApiServices = UserNameApiServices();
  GetSliderApiServices getSliderApiServices = GetSliderApiServices();

  RegisterOtpVerifyServicesApi registerOtpVerifyServicesApi =
      RegisterOtpVerifyServicesApi();

  GetIndustriesApiServices getIndustriesApiServices =
      GetIndustriesApiServices();
  GetPostionApiServices getpostionApiServices = GetPostionApiServices();
  GetRequirementsApiServices getRequirementsApiServices =
      GetRequirementsApiServices();

  SendVerificationApiService sendVerificationApiService =
      SendVerificationApiService();

  CheckVerificationApiService checkVerificationApiService =
      CheckVerificationApiService();

  registerUser(RegisterModel registerModel) async {
    isLoading(true);
    dio.Response<dynamic> response =
        await registerServicesApi.registerApi(registerModel);
    isLoading(false);

    if (response.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      // await prefs.setString("auth_token", response.data["token"]);
      await prefs.setString("temp_auth_token", response.data["token"]);
      await prefs.setString("verify", "false");
      Get.to(OtpScreen(
        phoneNumber: registerModel.mobile,
        otp: response.data["user"]["otp"].toString(),
      ));
    } else if (response.statusCode == 422) {
      Get.rawSnackbar(
        messageText: Text(
          response.data["errors"].first,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  otpVerify(String otp) async {
    isLoading(true);
    dio.Response<dynamic> response =
        await otpVerifyServicesApi.otpVerifyApi(otp: otp);
    isLoading(false);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      String? tempAuthToken = prefs.getString("temp_auth_token");
      await prefs.setString("auth_token", tempAuthToken!);
      Get.offAll(const RegisterDetailsView());
      //success
      Get.rawSnackbar(
        messageText: const Text(
          "OTP Verified Successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
    } else if (response.statusCode == 400) {
      Get.rawSnackbar(
        messageText: const Text(
          "Invalid OTP",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  registerOtpVerify(String otp) async {
    isLoading(true);
    dio.Response<dynamic> response =
        await registerOtpVerifyServicesApi.registerotpVerifyApi(otp: otp);
    isLoading(false);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      String? tempAuthToken = prefs.getString("temp_auth_token");
      await prefs.setString("auth_token", tempAuthToken!);
      if (wayIndex.value == 0) {
        Get.offAll(const StudentRegisterDetailsView());
      } else {
        Get.offAll(const RegisterDetailsView());
      }
      //success
      Get.rawSnackbar(
        messageText: const Text(
          "OTP Verified Successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
    } else if (response.statusCode == 400) {
      Get.rawSnackbar(
        messageText: const Text(
          "Invalid OTP",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  getDepartmentList() async {
    dio.Response<dynamic> response =
        await getDepartmentServicesApi.getDepartmentApi();

    if (response.statusCode == 200) {
      DepartmentModel departmentModel = DepartmentModel.fromJson(response.data);
      departments = departmentModel.departments;
      update();
    }
  }

  GetSkillsServicesApi getSkillsServicesApi = GetSkillsServicesApi();

  getSkillsList() async {
    dio.Response<dynamic> response = await getSkillsServicesApi.getSkillsApi();

    if (response.statusCode == 200) {
      SkillsModel skillsdataModel = SkillsModel.fromJson(response.data);
      skillsDataList = skillsdataModel.data;
      update();
    }
  }

  List<Industry> industriesList = [];
  List<SkillsData> skillsDataList = [];
  List<GetPostionData> getpostionDataList = [];

  getIndustriesList() async {
    dio.Response<dynamic> response =
        await getIndustriesApiServices.getIndustriePostApiServices();

    if (response.statusCode == 200) {
      IndustriesModel departmentModel = IndustriesModel.fromJson(response.data);
      industriesList = departmentModel.industries;
      update();
    }
  }

  Future<void> getpostionList({required String postionid}) async {
    isLoading(true);
    try {
      dio.Response<dynamic> response =
          await getpostionApiServices.getpostionApiServices(postionid);
      isLoading(false);
      if (response.statusCode == 200) {
        Getpostionmodel postionModel = Getpostionmodel.fromJson(response.data);
        getpostionDataList.clear();
        getpostionDataList.add(postionModel.data);
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  updateProfile(ProfileUpdateModel profileUpdateModel) async {
    isLoading(true);
    dio.Response<dynamic> response =
        await profileUpdateServicesApi.profileUpdate(profileUpdateModel);
    isLoading(false);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("verify", "true");
      // if(wayIndex.value == 0){
      //   Get.offAll(OnbordingStudent());
      // } else {
      //   Get.offAll(ObordingProfotional());
      // }
      Get.offAll(const ObordingProfotional());
      // Get.rawSnackbar(
      //   messageText: const Text(
      //     "Registered Successfully",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.green,
      // );
    } else {
      Get.rawSnackbar(
        messageText: const Text(
          "Something went wrong",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  //student update profile
  StudentProfileUpdateServicesApi studentProfileUpdateServicesApi =
      StudentProfileUpdateServicesApi();

  studentUpdateProfile(
      StudentProfileUpdateModel studentProfileUpdateModel) async {
    isLoading(true);
    dio.Response<dynamic> response = await studentProfileUpdateServicesApi
        .studentProfileUpdate(studentProfileUpdateModel);
    isLoading(false);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("verify", "true");
      // if(wayIndex.value == 0){
      //   Get.offAll(OnbordingStudent());
      // } else {
      //   Get.offAll(ObordingProfotional());
      // }
      Get.offAll(const OnbordingStudent());
      // Get.rawSnackbar(
      //   messageText: const Text(
      //     "Registered Successfully",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.green,
      // );
    } else {
      Get.rawSnackbar(
        messageText: const Text(
          "Something went wrong",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  //existing user - update user type
  UserTypeUpdateApiService userTypeUpdateApiService =
      UserTypeUpdateApiService();

  updateUserType({required String userType}) async {
    dio.Response<dynamic> response = await userTypeUpdateApiService
        .userTypeUpdateApiService(userType: userType);
    if (response.statusCode == 200) {
      Get.back();
    }
  }

  loginUser({required String username, required String password}) async {
    isLoading(true);
    dio.Response<dynamic> response =
        await loginServicesApi.loginApi(username: username, password: password);
    isLoading(false);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token", response.data["token"]);
      // await prefs.setString("user_id", response.data["user"]["id"]);
      await prefs.setString("verify", "true");
      Get.find<ProfileController>().checkWhetherHeGo();
      // Get.rawSnackbar(
      //   messageText: const Text(
      //     "Login Successful",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.green,
      // );
    } else if (response.statusCode == 401) {
      Get.rawSnackbar(
        messageText: Text(
          response.data["error"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    } else {
      Get.rawSnackbar(
        messageText: const Text(
          "Invalid User name / Password",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  checkUserName({required String userName}) async {
    dio.Response<dynamic> response =
        await userNameApiServices.username(userName: userName);

    if (response.statusCode == 200) {
      isUserNameAvailable(true);
      update();
    } else if (response.statusCode == 409) {
      isUserNameAvailable(false);
      update();
    }
  }

  getSlider() async {
    dio.Response<dynamic> response = await getSliderApiServices.getSliders();

    if (response.statusCode == 201) {
      update();
      SliderModel sliderModel = SliderModel.fromJson(response.data);
      sliderList = sliderModel.sliderList;
    }
    update();
  }

  //fcm token store api
  FcmTokenStoreApiService fcmTokenStoreApiService = FcmTokenStoreApiService();

  fcmtoken({required String token, required String id}) async {
    dio.Response<dynamic> response = await fcmTokenStoreApiService
        .fcmTokenStoreApiService(token: token, id: id);
    if (response.statusCode == 200) {
    } else {
      Get.snackbar("Something went wrong", response.statusCode.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  sendEmailVerification({required String emailId}) async {
    bool isEmailSent = false;
    dio.Response<dynamic> response =
        await sendVerificationApiService.sendVerification(emailId: emailId);

    if (response.statusCode == 200) {
      isEmailSent = true;
      Get.rawSnackbar(
          messageText: Text(
            "Email verification link sent",
            style: primaryfont.copyWith(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green);
    } else if (response.statusCode == 400) {
      isEmailSent = false;
      Get.rawSnackbar(
          messageText: Text(
            "Email is Already Verified or Taken",
            style: primaryfont.copyWith(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red);
    }

    return isEmailSent;
  }

  checkEmailVerification({required String emailId}) async {
    bool isverified = false;
    dio.Response<dynamic> response =
        await checkVerificationApiService.checkVerification(emailId: emailId);

    if (response.statusCode == 200) {
      if (response.data["status"] == "1") {
        isverified = true;
      } else {
        isverified = false;
      }
    } else {
      isverified = false;
    }

    return isverified;
  }

  GetStateApiServices getStateApiServices = GetStateApiServices();

  GetCityApiServices getCityApiServices = GetCityApiServices();

  getStateList() async {
    dio.Response<dynamic> response = await getStateApiServices.getStateApi();
    if (response.statusCode == 200) {
      StateListModel stateListModel = StateListModel.fromJson(response.data);
      stateList = stateListModel.stateList;
    }
    update();
  }

  getCityList(int stateId) async {
    try {
      dio.Response<dynamic> response =
          await getCityApiServices.getCityApi(stateId);
      if (response.statusCode == 200) {
        CityListModel cityListModel = CityListModel.fromJson(response.data);
        cityList = cityListModel.cityList;
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  getRequiremetList() async {
    try {
      dio.Response<dynamic> response =
          await getRequirementsApiServices.getRequiremtsApi();
      if (response.statusCode == 200) {
        RequirementsModel requirementsModel =
            RequirementsModel.fromJson(response.data);
        requirementList = requirementsModel.requirement;
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  //education list
  GetEducationListApiServices getEducationListApiServices =
      GetEducationListApiServices();
  List<Educationlistdata> educationData = [];

  education() async {
    dio.Response<dynamic> response =
        await getEducationListApiServices.geteducationList();
    if (response.statusCode == 200) {
      GeteducationListModel educationListModel =
          GeteducationListModel.fromJson(response.data);
      educationData = educationListModel.data;
    } else {
      Get.rawSnackbar(
        messageText: const Text(
          "Something went wrong",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
    update();
  }

  AddEducationSkillssApiServices addeducationskillsapiservices =
      AddEducationSkillssApiServices();

  addEducationalSkills({
    required String institutionname,
    required String userId,
    required String educationtitle,
    required String city,
    required String state,
    required String frombatch,
    required String tilldate,
    required String educationdescription,
    required String flag,
  }) async {
    isLoading(true);
    dio.Response<dynamic> response =
        await addeducationskillsapiservices.addEducationalSkills(
            institutionname: institutionname,
            educationtitle: educationtitle,
            city: city,
            state: state,
            frombatch: frombatch,
            educationdescription: educationdescription,
            flag: flag,
            tilldate: tilldate);

    print("-------->>-----------<<-------->>>>>>>");
    print(response.data);
    isLoading(false);
    if (response.statusCode == 201) {
      Get.back();
      Get.find<ProfileController>().getEducationalSkillsApi();
      // getProfile();
      // if (isFromLogin) {
      //   Get.offAll(() => const SettingProfileMadatoryPage());
      // } else {
      //   Get.offAll(() => const SettingProfilePage());
      // }
      Get.rawSnackbar(
        messageText: const Text(
          "New Skill added",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
    } else {
      Get.rawSnackbar(
        messageText: const Text(
          "Unable to add skill",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  //student professional
  StudentProfile studentProfile = StudentProfile();
  studentProfessionaltype({required String type}) async {
    dio.Response<dynamic> response =
        await studentProfile.studentProfile(type: type);
    if (response.statusCode == 200) {
      Get.offAll(const registersplash());
    }
  }

  //existing user
  eStudentProfessionaltype({required String type}) async {
    dio.Response<dynamic> response =
        await studentProfile.studentProfile(type: type);
    if (response.statusCode == 200) {}
  }

  //update education skills
  UpdateEducationSkillssApiServices updateEducationSkillssApiServices =
      UpdateEducationSkillssApiServices();

  updateEducationSkills(
      {required String institutionname,
      required String educationtitle,
      required String id,
      required String city,
      required String state,
      required String frombatch,
      required String educationdescription,
      required String tilldate}) async {
    dio.Response<dynamic> response =
        await updateEducationSkillssApiServices.updateEducationalSkillsApi(
            institutionname: institutionname,
            educationtitle: educationtitle,
            id: id,
            city: city,
            state: state,
            frombatch: frombatch,
            educationdescription: educationdescription,
            tilldate: tilldate);
    if (response.statusCode == 200) {
      Get.back();
      Get.rawSnackbar(
        messageText: const Text(
          "Education updated successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
    }
    update();
    Get.find<ProfileController>().getEducationalSkillsApi();
  }

  geteducationList() {}
}
