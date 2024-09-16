abstract class BaseApiService {
  // String get baseUrl => "http://admin.sipmaaindia.com/api/";
  String get baseUrl => "https://sipmaa.batechnology.in/api/";
  String get authUrl => "${baseUrl}auth/";

  // Authentication URLs
  String get registerURL => "${baseUrl}register_user";
  String get loginURL => "${baseUrl}login";
  String get otpVerifyURL => "${authUrl}otp_verrify";
  String get updateProfileURL => "${authUrl}profile_update";
  String get forgotPasswordURL => "${baseUrl}forgotPassword";
  String get verifyOtpURL => "${baseUrl}verifyOTP";
  String get resetPasswordURL => "${baseUrl}resetpassword";
  String get resendOtpURL => "${baseUrl}resendOTP";
  String get userNameCheckURL => "${baseUrl}user_check";
  String get changePasswordURL => "${baseUrl}change_password_new";

  // Post-related URLs
  String get getAllPostsURL => "${authUrl}get_post";
  String get uploadPostURL => "${authUrl}create_post";
  String get searchPostURL => "${authUrl}post_search";
  String get postLikeURL => "${authUrl}post_like";
  String get postCommentsURL => "${authUrl}post_comment";
  String get postCommentsListURL => "${authUrl}post_comments_list";
  String get filterPostsURL => "${authUrl}filter_post";
  String get postLikeListURL => "${authUrl}post_like_list";
  String get deletePostURL => "${authUrl}delete_post";
  String get postReportURL => "${authUrl}post_report";
  String get industriesURL => "${authUrl}industries_get";

  // Friends-related URLs
  String get searchFriendsURL => "${authUrl}friends_search";
  String get addFriendsURL => "${authUrl}add_request";
  String get friendListURL => "${authUrl}friends_list";
  String get friendRequestListURL => "${authUrl}friends_list_recive";
  String get sendFriendRequestURL => "${authUrl}add_request";
  String get updateFriendRequestURL => "${authUrl}respond_request";

  // Profile-related URLs
  String get getProfileDetailsURL => "${authUrl}profile";
  String get deleteUserURL => "${authUrl}delete_user";
  String get getpostionURL => "${authUrl}get_position";

  // Notifications URLs
  String get fcmTokenStoreApiUrl => "${authUrl}fcm-token";
  String get getNotificationListURL => "${authUrl}get_notifications";
  String get markNotificationAsReadURL => "${authUrl}mark_notification_as_read";

  // Position, Skills, and Education
  String get addPositionURL => "${authUrl}store_position";
  String get updatePositionURL => "${authUrl}update_position";
  String get addSkillsURL => "${authUrl}store_skill";
  String get getSkillsURL => "${baseUrl}getUserSkills";
  String get educationListApiUrl => "${baseUrl}geteducation/list";
  String get addEducationSkillURL => "${authUrl}store_education_skills";
  String get getEducationSkillURL => "${authUrl}get_education_skills";
  String get updateEducationSkillsURL => "${authUrl}update_education_skills";

  // Miscellaneous
  String get departmentsURL => "${baseUrl}department";
  String get sliderURL => "${baseUrl}get_slider";
  String get getFcmTokenURL => "${baseUrl}get_fcm";
  String get sendEmailVerifyURL => "${baseUrl}sendemail_verrify";
  String get checkVerificationURL => "${baseUrl}checkVerificationStatus";
  String get uploadBackgroundImage => "${authUrl}backround_image";
  String get getStateListURL => "${baseUrl}getStateList";
  String get getCityListURL => "${baseUrl}getCityList";
  String get requirementsURL => "${baseUrl}requirments";
}

// abstract class BaseApiService {
//   final String baseUrl = "http://admin.sipmaaindia.com/api/";

//   //register url
//   final String registerURl = "http://admin.sipmaaindia.com/api/register_user";

//   //login url
//   final String loginURL = "http://admin.sipmaaindia.com/api/login";

//   //otp Verify url
//   final String otpVerifyURL =
//       "http://admin.sipmaaindia.com/api/auth/otp_verrify";

// //get departments url
//   final String departmentsURL = "http://admin.sipmaaindia.com/api/department";

// //update Profile URL
//   final String updateProfileURL =
//       "http://admin.sipmaaindia.com/api/auth/profile_update";

// //get all posts
//   final String getAllPostsURL =
//       "http://admin.sipmaaindia.com/api/auth/get_post";

//   //upload  a post
//   final String uploadPostURL =
//       "http://admin.sipmaaindia.com/api/auth/create_post";

//   //Search posts
//   final String searchPostURL =
//       "http://admin.sipmaaindia.com/api/auth/post_search";

//   //Search friends
//   final String searchFriendsURL =
//       "http://admin.sipmaaindia.com/api/auth/friends_search";

//   //get profile details
//   final String getProfileDetailsURL =
//       "http://admin.sipmaaindia.com/api/auth/profile";

//   //add friends
//   final String addFriendsURL =
//       "http://admin.sipmaaindia.com/api/auth/add_request";

// //add friends
//   final String friendListURL =
//       "http://admin.sipmaaindia.com/api/auth/friends_list";

// //friends request list
//   final String frindRequestList =
//       "http://admin.sipmaaindia.com/api/auth/friends_list_recive";

// //like a post
//   final String postLikeURL = "http://admin.sipmaaindia.com/api/auth/post_like";

// //send friend request
//   final String sendFriendRequestURL =
//       "http://admin.sipmaaindia.com/api/auth/add_request";

// //update friend request
//   final String updateFriendRequestURL =
//       "http://admin.sipmaaindia.com/api/auth/respond_request";

// //post_comments
//   final String postCommemtsURL =
//       "http://admin.sipmaaindia.com/api/auth/post_comment";

//   //post_comments_list
//   final String postCommentsListURL =
//       "http://admin.sipmaaindia.com/api/auth/post_comments_list";

// //post filter api services
//   final String filerURL = "http://admin.sipmaaindia.com/api/auth/filter_post";

// //change password api services
//   final String changePasswordURL =
//       "http://admin.sipmaaindia.com/api/auth/change_password_new";

// //post_like_list
//   final String postLikeListURL =
//       "http://admin.sipmaaindia.com/api/auth/post_like_list";

// //add position
//   final String addPositionURL =
//       "http://admin.sipmaaindia.com/api/auth/store_position";

// //store skills
//   final String addSkillsURL =
//       "http://admin.sipmaaindia.com/api/auth/store_skill";

// //user_name check
//   final String userNameCheckURL = "http://admin.sipmaaindia.com/api/user_check";

// //slider Api URL
//   final String sliderURL = "http://admin.sipmaaindia.com/api/get_slider";

//   //fcm token store
//   String fcmTokenStoreApiUrl =
//       "http://admin.sipmaaindia.com/api/auth/fcm-token";

//   String getNotificationListURL =
//       "http://admin.sipmaaindia.com/api/auth/get_notifications";

//   String deletePostURL = "http://admin.sipmaaindia.com/api/auth/delete_post";

//   String getFcmToken = "http://admin.sipmaaindia.com/api/get_fcm";

//   //forget password
//   String forgotPassword = "http://admin.sipmaaindia.com/api/forgotPassword";

//   //verify-otp
//   String verifyOtp = "http://admin.sipmaaindia.com/api/verifyOTP";

//   //reset password
//   String resetPassword = "http://admin.sipmaaindia.com/api/resetpassword";

//   //delete user
//   String deleteUser = "http://admin.sipmaaindia.com/api/auth/delete_user";

//   //resend otp
//   String resendOtp = "http://admin.sipmaaindia.com/api/resendOTP";

//   //post report
//   String postReport = "http://admin.sipmaaindia.com/api/auth/post_report";

//   String industriesURL = "http://admin.sipmaaindia.com/api/industries_get";

//   String sendEmailVerify = "http://admin.sipmaaindia.com/api/sendemail_verrify";

//   String checkVerificationURL =
//       "http://admin.sipmaaindia.com/api/checkVerificationStatus";

//   String markNotificationAsread =
//       "http://admin.sipmaaindia.com/api/auth/mark_notification_as_read";

//   String uploadBackgroundImage =
//       "http://admin.sipmaaindia.com/api/auth/backround_image";

//   String getStateList = "http://admin.sipmaaindia.com/api/getStateList";

//   String getCityList = 
//   "http://admin.sipmaaindia.com/api/getCityList";

//   String requirementsURL = 
//   "http://admin.sipmaaindia.com/api/requirments";

//   String getSkillsURL = 
//   "http://admin.sipmaaindia.com/api/getUserSkills";

//   //education list
//   final String educationListApiUrl =
//       "https://admin.sipmaaindia.com/api/geteducation/list";



// //add education skill
//   final String addeducationskillUrl =
//       'http://admin.sipmaaindia.com/api/auth/store_education_skills';



//   //get education skill
//   final String geteducationskillUrl =
//       'http://admin.sipmaaindia.com/api/auth/get_education_skills';

//   //update education skills
//   final String updateEducationSkillsApiUrl = "http://admin.sipmaaindia.com/api/auth/update_education_skills";    


// }
