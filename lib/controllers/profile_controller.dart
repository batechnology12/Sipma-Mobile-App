import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpa/models/add_positions_model.dart';
import 'package:simpa/models/friend_list_model.dart';
import 'package:simpa/models/friend_request_model.dart';
import 'package:simpa/models/get_education_skills_model.dart';
import 'package:simpa/models/notiofication_list_model.dart';
import 'package:simpa/models/profile_model.dart';
import 'package:simpa/models/search_friends_model.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_educatinal_skills_api_service.dart';
import 'package:simpa/services/network_api_services/notification_list/notification_list.dart';
import 'package:simpa/services/network_api_services/notification_list/notification_mark_as_count.dart';
import 'package:simpa/services/network_api_services/post_api_services/get_other_profile_api_services.dart';
import 'package:simpa/services/network_api_services/post_api_services/get_profile_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/add_posotions_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/add_skills_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/change_password_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/delete_my_account_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/forgetPwd_verify_otp_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/forget_password_api_service.dart';
import 'package:simpa/services/network_api_services/profile_api_services/friend_request_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/my_friend_list_api_services.dart';
import 'package:dio/dio.dart' as dio;
import 'package:simpa/services/network_api_services/profile_api_services/resend_otp_api_service.dart';
import 'package:simpa/services/network_api_services/profile_api_services/reset_password_api_service.dart';
import 'package:simpa/services/network_api_services/profile_api_services/respond_request_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/search_user_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/send_friend_request.dart';
import 'package:simpa/services/network_api_services/profile_api_services/update_background_image_api_services.dart';
import 'package:simpa/services/network_api_services/profile_api_services/update_profile_pic.dart';
import 'package:simpa/services/network_api_services/profile_api_services/update_userdetails_api_services.dart';
import 'package:simpa/view/create_new_password.dart';
import 'package:simpa/view/forgot_password_verifypage.dart';
import 'package:simpa/view/login/login_view/loginpage.dart';
import 'package:simpa/view/profile_sccuessful_page.dart';
import 'package:simpa/view/profile_settings_view/profile_madatory_fill_page.dart';
import 'package:simpa/view/setting_proifile_page.dart';
import 'package:simpa/view/sucessfull.dart';
import 'package:simpa/widgets/bottumnavigationbar.dart';

class ProfileController extends GetxController {
  GetFriendListApiServices getFriendListApiServices =
      GetFriendListApiServices();
  GetFriendRequestListApiServices getFriendRequestListApiServices =
      GetFriendRequestListApiServices();

  GetProfileApiServices getProfileApiServices = GetProfileApiServices();
  SearchFriendsApiServices searchFriendsApiServices =
      SearchFriendsApiServices();

  SendFriendRequestAPIServices sendFriendRequestAPIServices =
      SendFriendRequestAPIServices();

  RespondFriendRequestAPIServices respondFriendRequestAPIServices =
      RespondFriendRequestAPIServices();

  ChangePasswordApiServices changePasswordApiServices =
      ChangePasswordApiServices();

  GetOtherProfileApiServices getOtherProfileApiServices =
      GetOtherProfileApiServices();

  UpdateProfilePicApi updateProfilePicApi = UpdateProfilePicApi();

  UpdateUserDetailsApi updateUserDetailsApi = UpdateUserDetailsApi();

  GetNotificationListApi getNotificationLiistApi = GetNotificationListApi();

  AddSkillssApiServices addSkillssApiServices = AddSkillssApiServices();

  AddPositonsApiServices addPositonsApiServices = AddPositonsApiServices();

  UpdateProfileBackgroundPicApi updateProfileBackgroundPicApi =
      UpdateProfileBackgroundPicApi();

  MarkNotifcationAsCount markNotifcationAsCount = MarkNotifcationAsCount();

  List<FriendList> myFriendList = [];
  // List<FriendList> friendRequestList = [];
  List<FriendRequestList> friendRequestList = [];
  List<ProfileModel> profileData = [];
  List<ProfileModel> otherUserProfileData = [];
  List<SearchFriendsList> searchFriendsList = [];

  RxInt initialIndex = 0.obs;

  RxString educationlist = "".obs;

  RxBool isLoading = false.obs;
  RxBool isBackgroundLoading = false.obs;
  RxBool friendsearchLoading = false.obs;

  var tBioController = TextEditingController();

  var selectedCategory;

  getProfile() async {
    dio.Response<dynamic> response = await getProfileApiServices.getProfile();
    final prefs = await SharedPreferences.getInstance();
    profileData.clear();
    if (response.statusCode == 200) {
      ProfileModel profileModel = ProfileModel.fromJson(response.data);
      await prefs.setString("user_id", profileModel.user.id.toString());
      profileData.add(profileModel);
    } else if (response.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token", "null");

      Get.to(const loginpage());
    }
    update();
  }

  checkWhetherHeGo() async {
    dio.Response<dynamic> response = await getProfileApiServices.getProfile();
    profileData.clear();
    if (response.statusCode == 200) {
      ProfileModel profileModel = ProfileModel.fromJson(response.data);
      profileData.add(profileModel);
      update();
      if (profileModel.positions.isEmpty ||
          profileModel.skills.isEmpty ||
          profileModel.user.education == null) {
        Get.offAll(() => const SettingProfileMadatoryPage());
      } else {
        Get.offAll(() => BottomNavigationBarExample());
      }
    } else if (response.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token", "null");
      Get.to(const loginpage());
    }
  }

  getOtherProfile({required String userid}) async {
    isLoading(true);
    otherUserProfileData.clear();
    dio.Response<dynamic> response =
        await getOtherProfileApiServices.getOtherProfile(userId: userid);
    isLoading(false);
    if (response.statusCode == 200) {
      ProfileModel profileModel = ProfileModel.fromJson(response.data);
      otherUserProfileData.add(profileModel);
      print("--------is friend == ${profileModel.isFriend}");
      print("--------is friend == ${profileModel.user.name}");
    } else if (response.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token", "null");
      Get.to(const loginpage());
    }
    update();
  }

  getMyFriendList() async {
    dio.Response<dynamic> response =
        await getFriendListApiServices.getFriendListApiServices();

    if (response.statusCode == 200) {
      FriendListModel friendListModel = FriendListModel.fromJson(response.data);
      myFriendList = friendListModel.friendList;
    }
    update();
  }

  getMyFriendRequestList() async {
    dio.Response<dynamic> response =
        await getFriendRequestListApiServices.getFriendRequestListApiServices();
    if (response.statusCode == 200) {
      FriendRequestListModel friendListModel =
          FriendRequestListModel.fromJson(response.data);
      friendRequestList = friendListModel.friendRequestList;
    }
    update();
  }

  searchUser(String keyWord) async {
    friendsearchLoading(true);
    searchFriendsList.clear();
    dio.Response<dynamic> response =
        await searchFriendsApiServices.searchFriends(keyWord: keyWord);

    if (response.statusCode == 200) {
      SearchFriendsModel searchFriendsModel =
          SearchFriendsModel.fromJson(response.data);
      searchFriendsList = searchFriendsModel.friendList;
    }
    friendsearchLoading(false);
    update();
  }

  sendRequest({required String userId, required int index}) async {
    dio.Response<dynamic> response =
        await sendFriendRequestAPIServices.sendFriendRequest(
            userId: userId, friendId: profileData.first.user.id.toString());

    if (response.statusCode == 200) {
      searchFriendsList[index].isFriend = true;
      update();
      Get.rawSnackbar(
        messageText: const Text(
          "Friend request sended",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
    } else {
      Get.rawSnackbar(
        messageText: Text(
          response.data["message"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  sendRequestFromProfile({required String userId}) async {
    bool isRequested = false;
    dio.Response<dynamic> response =
        await sendFriendRequestAPIServices.sendFriendRequest(
            userId: userId, friendId: profileData.first.user.id.toString());

    print("send req --------------->>");

    print(response.data);
    print(response.statusCode);

    if (response.statusCode == 200) {
      isRequested = true;
      update();
      Get.rawSnackbar(
        messageText: const Text(
          "Friend request sended",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
    } else {
      Get.rawSnackbar(
        messageText: const Text(
          "Please try again",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }

    return isRequested;
  }

  respondRequest({
    required String userId,
    required String status,
  }) async {
    dio.Response<dynamic> response = await respondFriendRequestAPIServices
        .respondFriendRequest(friendId: userId, status: status);
    print("-------------------<<This is req response>>------------");
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      getMyFriendRequestList();
      getMyFriendList();
      if (status == "1") {
        Get.rawSnackbar(
          messageText: const Text(
            "Request accepted",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        );
      } else if (status == "2") {
        Get.rawSnackbar(
          messageText: const Text(
            "Removed from request",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        );
      }
    } else {
      Get.rawSnackbar(
        messageText: Text(
          "Please try again ${response.statusCode}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  changePassword({
    required String oldPassword,
    required String currentPassword,
    required String condirmPassword,
  }) async {
    dio.Response<dynamic> response =
        await changePasswordApiServices.changePassword(
            oldPassword: oldPassword,
            currentPassword: currentPassword,
            condirmPassword: condirmPassword);

    if (response.statusCode == 200) {
      Get.back();
      Get.rawSnackbar(
        messageText: const Text(
          "password changed successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
    } else if (response.statusCode == 400) {
      Get.rawSnackbar(
        messageText: Text(
          response.data["message"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    } else if (response.statusCode == 422) {
      Get.rawSnackbar(
        messageText: Text(
          response.data["message"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  updateProfilePic({required File media}) async {
    isLoading(true);
    update();
    dio.Response<dynamic> response =
        await updateProfilePicApi.updateProfilePic(media: media);
    isLoading(false);
    update();
    if (response.statusCode == 200) {
      getProfile();
    }
  }

  updateProfileBackgoundPic({required File media}) async {
    isBackgroundLoading(true);
    update();
    dio.Response<dynamic> response = await updateProfileBackgroundPicApi
        .updateProfileBackgroundPic(media: media);
    isBackgroundLoading(false);
    update();
    if (response.statusCode == 200) {
      getProfile();
    }
  }

  updateUserDetails(
      {required String name,
      required String lastName,
      required String bio,
      required String designation,
      required String email,
      required String hisOrHer,
      required String mobile,
      required String education}) async {
    isLoading(true);
    update();
    dio.Response<dynamic> response =
        await updateUserDetailsApi.updateUserDetails(
            name: name,
            lastName: lastName,
            bio: bio,
            designation: designation,
            email: email,
            hisOrher: hisOrHer,
            education: education,
            mobile: mobile);
    isLoading(false);
    update();
    if (response.statusCode == 200) {
      Get.to(const ProfileSuccessfullPage());
      // Get.rawSnackbar(
      //   messageText: const Text(
      //     "Updated successfully",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.green,
      // );
    }
  }

  List<ListElement> notificationList = [];
  RxInt notificationCount = 0.obs;

  getNotificationList() async {
    dio.Response<dynamic> response =
        await getNotificationLiistApi.getNotifionListApi();

    if (response.statusCode == 201) {
      NotificationListModel notificationListModel =
          NotificationListModel.fromJson(response.data);
      notificationList = notificationListModel.list;
      notificationCount(notificationListModel.count);
    }
    update();
  }

  //forget password
  ForgetPasswordApiServices forgetPasswordApiServices =
      ForgetPasswordApiServices();

  forgetPassword({required String mobileoremail}) async {
    isLoading(true);
    dio.Response<dynamic> response = await forgetPasswordApiServices
        .forgetPasswordApiServices(mobileoremail: mobileoremail);
    isLoading(false);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("data", response.data["data"].toString());
      Get.to(Forgotpasswordverifiypage(
        mobile: mobileoremail,
      ));
    } else {
      Get.rawSnackbar(
        messageText: Text(
          response.data["message"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  //verfify otp
  ForgetPwdVerifyOtpApiServices forgetPwdVerifyOtpApiServices =
      ForgetPwdVerifyOtpApiServices();

  verifyOtpfpwd({required String otp}) async {
    dio.Response<dynamic> response = await forgetPwdVerifyOtpApiServices
        .forgetPwdVerifyOtpApiServices(otp: otp);

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("mobile", response.data["data"].toString());

      Get.to(const CreateNewPassword());
    } else if (response.statusCode == 404) {
      Get.rawSnackbar(
        messageText: Text(
          response.data["message"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    } else if (response.statusCode == 400) {
      Get.rawSnackbar(
        messageText: Text(
          response.data["message"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    } else if (response.statusCode == 422) {
      Get.rawSnackbar(
        messageText: const Text(
          "The otp field is required.",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
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

  //reset password
  ResetPwdApiServices resetPwdApiServices = ResetPwdApiServices();

  resetPassword(
      {required String password, required String confirmPassword}) async {
    dio.Response<dynamic> response =
        await resetPwdApiServices.resetPwdApiServices(
            password: password, confirmPassword: confirmPassword);

    if (response.statusCode == 200) {
      Get.to(const Sucessfullscreen());
    } else if (response.statusCode == 422) {
      Get.rawSnackbar(
        messageText: const Text(
          "The password field confirmation does not match.",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    } else if (response.statusCode == 404) {
      Get.rawSnackbar(
        messageText: Text(
          response.data["message"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
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

  DeleteMyAccountApiServices deleteMyAccountApiServices =
      DeleteMyAccountApiServices();

  deleteYourAccount({required String password}) async {
    dio.Response<dynamic> response =
        await deleteMyAccountApiServices.deleteMyAccount(password: password);

    if (response.statusCode == 200) {
      Get.rawSnackbar(
        messageText: const Text(
          "Your Sipmaa account got deleted",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      final prefs = await SharedPreferences.getInstance();
      // await FirebaseMessaging.instance.deleteToken();
      await prefs.setString("auth_token", "null");
      Get.offAll(const loginpage());
    } else if (response.statusCode == 422) {
      Get.rawSnackbar(
        messageText: const Text(
          "The password does not match.",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    } else if (response.statusCode == 404) {
      Get.rawSnackbar(
        messageText: Text(
          response.data["message"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    } else {
      Get.rawSnackbar(
        messageText: Text(
          response.data["message"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  //resend otp
  ResendOtpApiServices resendOtpApiServices = ResendOtpApiServices();

  resendOtp({required String mobile}) async {
    dio.Response<dynamic> response =
        await resendOtpApiServices.resendOtpApiServices(mobile: mobile);

    if (response.statusCode == 200) {
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

  addPositions(
      {required AddPositonsModel addPostionsModel,
      required String useId,
      bool isFromLogin = false}) async {
    isLoading(true);
    dio.Response<dynamic> response = await addPositonsApiServices.addPositions(
        addPostionsModel: addPostionsModel, useId: useId);
    isLoading(false);
    if (response.statusCode == 201) {
      getProfile();
      if (isFromLogin) {
        Get.offAll(() => const SettingProfileMadatoryPage());
      } else {
        Get.offAll(() => const SettingProfilePage());
      }

      Get.rawSnackbar(
        messageText: const Text(
          "Added new position",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
    } else {
      Get.rawSnackbar(
        messageText: const Text(
          "Unable to add your position",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  updatePositions(
      {required AddPositonsModel addPostionsModel,
      required String useId,
      required String id,
      bool isFromLogin = false}) async {
    isLoading(true);
    dio.Response<dynamic> response =
        await addPositonsApiServices.updateositions(
            addPostionsModel: addPostionsModel, useId: useId, id: id);
    isLoading(false);
    if (response.statusCode == 200) {
      getProfile();
      if (isFromLogin) {
        Get.offAll(() => const SettingProfileMadatoryPage());
      } else {
        Get.offAll(() => const SettingProfilePage());
      }

      Get.rawSnackbar(
        messageText: const Text(
          "Added new position",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
    } else {
      Get.rawSnackbar(
        messageText: const Text(
          "Unable to add your position",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }

  addSkills(
      {required String skills,
      required String useId,
      bool isFromLogin = false}) async {
    isLoading(true);
    dio.Response<dynamic> response =
        await addSkillssApiServices.addSkills(skills: skills, useId: useId);
    isLoading(false);
    if (response.statusCode == 201) {
      getProfile();
      if (isFromLogin) {
        Get.offAll(() => const SettingProfileMadatoryPage());
      } else {
        Get.offAll(() => const SettingProfilePage());
      }

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

  mmarkNotificationAsRead({required int notificationId}) async {
    dio.Response<dynamic> response = await markNotifcationAsCount
        .markNotificationAsRead(notificationId: notificationId.toString());
  }

  //get skill education list
  GetEducationalSkillsServicesApi getEducationskillApiServices =
      GetEducationalSkillsServicesApi();
  List<educationskillsdata> educationskillsData = [];

  getEducationalSkillsApi() async {
    dio.Response<dynamic> response =
        await getEducationskillApiServices.getEducationalSkillsApi();
    if (response.statusCode == 200) {
      GetEducationalSkillsModel educationSkillsListModel =
          GetEducationalSkillsModel.fromJson(response.data);
      educationskillsData = educationSkillsListModel.departments;
      update();
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
}
