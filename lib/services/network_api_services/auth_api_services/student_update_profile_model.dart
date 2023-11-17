import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpa/models/student_profile_update_model.dart';
import 'package:simpa/services/base_urls/base_urls.dart';

class StudentProfileUpdateServicesApi extends BaseApiService {
  Future studentProfileUpdate(StudentProfileUpdateModel studentProfileUpdateModel) async {
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
            "user_type": "Student",
            "current_company": studentProfileUpdateModel.currentCompany,
            "designation": studentProfileUpdateModel.department,
            "department": studentProfileUpdateModel.designation,
            "recruitment": studentProfileUpdateModel.requirement,
            "industry_name": studentProfileUpdateModel.industries,
            "official_email": studentProfileUpdateModel.officialEmail,
            "address": studentProfileUpdateModel.address,
            "pincode": studentProfileUpdateModel.pincode,
            "city": studentProfileUpdateModel.city,
            "state": studentProfileUpdateModel.state,
            "other_department": studentProfileUpdateModel.othersdepartment,
            "education": studentProfileUpdateModel.education
          });
      print(
          "::::::::<Student Update Profile>::::::::status code:::::::::${studentProfileUpdateModel.designation}:");
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
