import 'dart:io';
import 'package:dio/dio.dart';
import 'package:simpa/services/base_urls/base_urls.dart';

class SendVerificationApiService extends BaseApiService {
  Future sendVerification({required String emailId}) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      // final prefs = await SharedPreferences.getInstance();
      // String? authtoken = prefs.getString("auth_token");
      var response = await dio.post(sendEmailVerify,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {"email": emailId});

      print("::::::::<Send email verify>::::::::status code::::::::::::::");

      print(response.statusCode);
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
