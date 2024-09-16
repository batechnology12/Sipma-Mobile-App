import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpa/services/base_urls/base_urls.dart';

class ResetPwdApiServices extends BaseApiService {
  Future resetPwdApiServices(
      {
        required String password,
        required String confirmPassword,
      }) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? mobileNumer = prefs.getString("mobile");

      var response = await dio.post(resetPasswordURL,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
             "password":password,
             "password_confirmation":confirmPassword,
             "mobile":mobileNumer
          });
          print("::::::::<reset password api>:$mobileNumer:::$password:::$confirmPassword:::::status code::::::::::");
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
