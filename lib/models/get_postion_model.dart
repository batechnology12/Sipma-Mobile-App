// To parse this JSON data, do
//
//     final getpostionmodel = getpostionmodelFromJson(jsonString);

import 'dart:convert';

Getpostionmodel getpostionmodelFromJson(String str) =>
    Getpostionmodel.fromJson(json.decode(str));

String getpostionmodelToJson(Getpostionmodel data) =>
    json.encode(data.toJson());

class Getpostionmodel {
  String message;
  GetPostionData data;

  Getpostionmodel({
    required this.message,
    required this.data,
  });

  factory Getpostionmodel.fromJson(Map<String, dynamic> json) =>
      Getpostionmodel(
        message: json["message"],
        data: GetPostionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class GetPostionData {
  int id;
  String userId;
  String employmentType;
  String companyName;
  GetpostionDepartment department;
  String recruitment;
  dynamic others;
  dynamic otherDepartment;
  String location;
  String startDate;
  String endDate;
  String industryName;
  String description;
  DateTime? createdAt;
  DateTime? updatedAt;
  GetpostionRequirment? requirment;

  GetPostionData({
    required this.id,
    required this.userId,
    required this.employmentType,
    required this.companyName,
    required this.department,
    required this.recruitment,
    required this.others,
    required this.otherDepartment,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.industryName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.requirment,
  });

  factory GetPostionData.fromJson(Map<String, dynamic> json) => GetPostionData(
        id: json["id"] ?? 0 ?? "",
        userId: json["user_id"] ?? "",
        employmentType: json["employment_type"] ?? "",
        companyName: json["company_name"] ?? "",
        department: GetpostionDepartment.fromJson(json["department"]),
        recruitment: json["recruitment"] ?? "",
        others: json["others"] ?? "",
        otherDepartment: json["other_department"] ?? "",
        location: json["location"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        industryName: json["industry_name"] ?? "",
        description: json["description"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        requirment: json["requirment"] == null
            ? null
            : GetpostionRequirment.fromJson(json["requirment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employment_type": employmentType,
        "company_name": companyName,
        "department": department.toJson(),
        "recruitment": recruitment,
        "others": others,
        "other_department": otherDepartment,
        "location": location,
        "start_date": startDate,
        "end_date": endDate,
        "industry_name": industryName,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "requirment": requirment!.toJson(),
      };
}

class GetpostionDepartment {
  int id;
  String title;
  String description;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetpostionDepartment({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetpostionDepartment.fromJson(Map<String, dynamic> json) =>
      GetpostionDepartment(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class GetpostionRequirment {
  int id;
  String departmentId;
  String name;
  dynamic description;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetpostionRequirment({
    required this.id,
    required this.departmentId,
    required this.name,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetpostionRequirment.fromJson(Map<String, dynamic> json) =>
      GetpostionRequirment(
        id: json["id"] ?? 0,
        departmentId: json["department_id"] ?? "",
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_id": departmentId,
        "name": name,
        "description": description,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}



// // To parse this JSON data, do
// //
// //     final getpostionmodel = getpostionmodelFromJson(jsonString);

// import 'dart:convert';

// Getpostionmodel getpostionmodelFromJson(String str) =>
//     Getpostionmodel.fromJson(json.decode(str));

// String getpostionmodelToJson(Getpostionmodel data) =>
//     json.encode(data.toJson());

// class Getpostionmodel {
//   String message;
//   GetPostionData data;

//   Getpostionmodel({
//     required this.message,
//     required this.data,
//   });

//   factory Getpostionmodel.fromJson(Map<String, dynamic> json) =>
//       Getpostionmodel(
//         message: json["message"],
//         data: GetPostionData.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class GetPostionData {
//   int id;
//   String userId;
//   String employmentType;
//   String companyName;
//   String department;
//   String recruitment;
//   String others;
//   String otherDepartment;
//   String location;
//   String startDate;
//   String endDate;
//   String industryName;
//   String description;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   GetPostionData({
//     required this.id,
//     required this.userId,
//     required this.employmentType,
//     required this.companyName,
//     required this.department,
//     required this.recruitment,
//     required this.others,
//     required this.otherDepartment,
//     required this.location,
//     required this.startDate,
//     required this.endDate,
//     required this.industryName,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory GetPostionData.fromJson(Map<String, dynamic> json) => GetPostionData(
//         id: json["id"] ?? 0,
//         userId: json["user_id"] ?? "??" "",
//         employmentType: json["employment_type"] ?? "",
//         companyName: json["company_name"] ?? "",
//         department: json["department"] ?? "",
//         recruitment: json["recruitment"] ?? "",
//         others: json["others"] ?? "",
//         otherDepartment: json["other_department"] ?? "",
//         location: json["location"] ?? "",
//         startDate: json["start_date"] ?? "",
//         endDate: json["end_date"] ?? "",
//         industryName: json["industry_name"] ?? "",
//         description: json["description"] ?? "",
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "employment_type": employmentType,
//         "company_name": companyName,
//         "department": department,
//         "recruitment": recruitment,
//         "others": others,
//         "other_department": otherDepartment,
//         "location": location,
//         "start_date": startDate,
//         "end_date": endDate,
//         "industry_name": industryName,
//         "description": description,
//         "created_at": createdAt!.toIso8601String(),
//         "updated_at": updatedAt!.toIso8601String(),
//       };
// }
