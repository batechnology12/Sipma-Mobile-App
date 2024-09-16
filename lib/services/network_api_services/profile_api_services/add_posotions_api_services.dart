import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpa/models/add_positions_model.dart';
import 'package:simpa/services/base_urls/base_urls.dart';

class AddPositonsApiServices extends BaseApiService {
  Future addPositions(
      {required AddPositonsModel addPostionsModel,
      required String useId}) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");

      var response = await dio.post(addPositionURL,
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
            "user_id": useId,
            // "title": addPostionsModel.title,
            "department": addPostionsModel.department,
            "recruitment": addPostionsModel.requireMents,
            "employment_type": addPostionsModel.employment_type,
            "company_name": addPostionsModel.company_name,
            "location": addPostionsModel.location,
            "start_date": addPostionsModel.start_date,
            if (addPostionsModel.end_date != "null")
              "end_date": addPostionsModel.end_date,
            "industry_name": "oo",
            "description": "tt",
            "other_department": addPostionsModel.othersdepartment
          });

      print(response.statusCode);
      print(response.data);
      print(addPostionsModel.othersdepartment);
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

  Future updateositions(
      {required AddPositonsModel addPostionsModel,
      required String useId,
      required String id}) async {
    dynamic responseJson;
    try {
      var dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      String? authtoken = prefs.getString("auth_token");

      var response = await dio.post(updatePositionURL,
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
            "user_id": useId,
            "id": id,
            "department": addPostionsModel.department,
            "recruitment": addPostionsModel.requireMents,
            "employment_type": addPostionsModel.employment_type,
            "company_name": addPostionsModel.company_name,
            "location": addPostionsModel.location,
            "start_date": addPostionsModel.start_date,
            if (addPostionsModel.end_date != "null")
              "end_date": addPostionsModel.end_date,
            "industry_name": "oo",
            "description": "tt",
            "other_department": addPostionsModel.othersdepartment
          });

      print(response.statusCode);
      print(response.data);
      print(addPostionsModel.othersdepartment);
      responseJson = response;
       return responseJson;
    } on SocketException {
      print("no internet");
    }
   
  }
}
