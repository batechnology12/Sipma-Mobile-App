import 'dart:io';
import 'package:dio/dio.dart';
import 'package:simpa/services/base_urls/base_urls.dart';

class CheckVerificationApiService extends BaseApiService {
  Future checkVerification({required String emailId}) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      // final prefs = await SharedPreferences.getInstance();
      // String? authtoken = prefs.getString("auth_token");
      var response = await dio.post(checkVerificationURL,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {"email": emailId});

      print("::::::::<check email verify>::::::::status code::::::::::::::");

      print(response.statusCode);
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
