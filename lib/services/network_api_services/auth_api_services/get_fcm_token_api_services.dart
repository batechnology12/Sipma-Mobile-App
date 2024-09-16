import 'dart:io';
import 'package:dio/dio.dart';
import 'package:simpa/services/base_urls/base_urls.dart';

class GetFcmTokenApiService extends BaseApiService {
  Future fcmTokenStoreApiService({required String id}) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      var response = await dio.post(getFcmTokenURL,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {"id": id});
      responseJson = response;
      print(
          "---------------------------FCM Token--------------------$id--------");
      print(response.statusCode);
      print(response.data);
    } on SocketException {
      print("no internet");
    }
    return responseJson;
  }
}
