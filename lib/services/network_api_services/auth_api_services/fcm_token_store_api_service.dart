import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpa/services/base_urls/base_urls.dart';

class FcmTokenStoreApiService extends BaseApiService {
  Future fcmTokenStoreApiService({required String token,required String id}) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");
      var response = await dio.post(fcmTokenStoreApiUrl,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $authtoken',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
              data: {
                "token":token,
                "id":id
              }
              );
              
      print("::::::::<fcmTokenStoreApiService-api>::::::::status code::::::::::::::");
      print(".....$token");
      print(".....$id");
      print(response.statusCode);
      print(response.data);
      responseJson = response;
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
