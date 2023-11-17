import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpa/models/profile_update_model.dart';
import 'package:simpa/services/base_urls/base_urls.dart';

class UpdateUserDetailsApi extends BaseApiService {
  Future updateUserDetails(
      {required String name,
      required String bio,
      required String lastName,
      required String designation,
      required String email,
      required String education,
      required String? hisOrher,
      required String mobile}) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");

      var response = await dio.post(updateProfileURL,
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $authtoken',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
            "name": name,
            "last_name": lastName,
            "bio": bio,
            "designation": designation,
            "official_email": email,
            "mobile": mobile,
            "his_her": hisOrher,
            "education": education
          });
      print(
          "::::::::<Update Profile>::::::::status code:::::::$hisOrher::$bio:");
      print(response.statusCode);
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }

  dynamic returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        print("here.>>>>>>>>>>>>");
        return responseJson;
      case 400:
      // throw BadRequestException(response.body.toString());
      case 401:
      case 403:
      // throw UnauthorisedException(response.body.toString());
      case 404:
      // throw UnauthorisedException(response.body.toString());
      case 500:
      default:
      // throw FetchDataException(
      //     'Error occured while communication with server' +
      //         ' with status code : ${response.statusCode}');
    }
  }
}
