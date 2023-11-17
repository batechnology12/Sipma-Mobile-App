// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'package:simpa/models/get_all_post_modals.dart';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String message;
  User user;
  List<Post> posts;
  List<Position> positions;
  List<Skill> skills;
  dynamic departmentName;
  int totalFriends;
  int isFriend;
  int totalLikes;
  int totalPosts;

  ProfileModel({
    required this.message,
    required this.user,
    required this.posts,
    required this.totalFriends,
    required this.isFriend,
    required this.totalLikes,
    required this.totalPosts,
    required this.positions,
    required this.departmentName,
    required this.skills,
   
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        message: json["message"],
        user: User.fromJson(json["user"]),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        totalFriends: json["total_friends"],
        isFriend: json["is_friend"],
        totalLikes: json["total_likes"],
        totalPosts: json["total_posts"],
       
        departmentName: json["department_name"]?? "",
        positions: List<Position>.from(
            json["positions"].map((x) => Position.fromJson(x))),
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "total_friends": totalFriends,
        "is_friend": isFriend,
        "total_likes": totalLikes,
        "total_posts": totalPosts,
      };
}

class User {
  int id;
  dynamic roleId;
  String name;
  String userType;
  dynamic hisHer;
  dynamic education;
  String email;
  String mobile;
  dynamic isVerrifiedMobile;
  String lastName;
  String userName;
  dynamic otp;
  dynamic backgroundImage;
  dynamic currentCompany;
  dynamic department;
  dynamic designation;
  dynamic qualification;
  dynamic officialEmail;
  dynamic profilePicture;
  dynamic clientSecret;
  dynamic clientId;
  dynamic keyName;
  String keyStatus;
  dynamic emailVerifiedAt;
  dynamic address;
  dynamic bio;
  dynamic pincode;
  dynamic city;
  dynamic state;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic otherDepartment;

  User({
    required this.id,
    required this.roleId,
    required this.name,
    required this.userType,
    required this.hisHer,
    required this.education,
    required this.email,
    required this.mobile,
    required this.backgroundImage,
    required this.isVerrifiedMobile,
    required this.lastName,
    required this.userName,
    required this.otp,
    this.currentCompany,
    required this.department,
    this.designation,
    this.qualification,
    this.officialEmail,
    this.profilePicture,
    this.clientSecret,
    this.clientId,
    this.keyName,
    required this.keyStatus,
    this.emailVerifiedAt,
    this.address,
    this.bio,
    this.pincode,
    this.city,
    this.state,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.otherDepartment,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        userType: json["user_type"]?? "null",
        hisHer: json["his_her"],
        education: json["education"]?? "",
        email: json["email"],
        mobile: json["mobile"],
        otherDepartment: json['other_department'],
        backgroundImage: json["backround_image"]?? "",
        isVerrifiedMobile: json["is_verrified_mobile"],
        lastName: json["last_name"] ?? "",
        userName: json["user_name"],
        otp: json["otp"],
        currentCompany: json["current_company"]?? "",
        department: json["department"]?? "",
        designation: json["designation"]?? "",
        qualification: json["qualification"]?? "",
        officialEmail: json["official_email"]?? "",
        profilePicture: json["profile_picture"]?? "",
        clientSecret: json["client_secret"]?? "",
        clientId: json["client_id"]?? "",
        keyName: json["Key_name"]?? "",
        keyStatus: json["Key_status"],
        emailVerifiedAt: json["email_verified_at"],
        address: json["address"]?? "",
        bio: json["bio"]?? "",
        pincode: json["pincode"],
        city: json["city"],
        state: json["state"]?? "",
        status: json["status"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "user_type": userType,
        "email": email,
        "mobile": mobile,
        "is_verrified_mobile": isVerrifiedMobile,
        "last_name": lastName,
        "user_name": userName,
        "otp": otp,
        "current_company": currentCompany,
        "department": department,
        "designation": designation,
        "qualification": qualification,
        "official_email": officialEmail,
        "profile_picture": profilePicture,
        "client_secret": clientSecret,
        "client_id": clientId,
        "Key_name": keyName,
        "Key_status": keyStatus,
        "email_verified_at": emailVerifiedAt,
        "address": address,
        "bio": bio,
        "pincode": pincode,
        "city": city,
        "state": state,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Position {
  int id;
  int userId;
  String title;
  String employmentType;
  String companyName;
  String departmentName;
  String otherDepartmentName;
  String location;
  String startDate;
  String? endDate;
  String industryName;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Position({
    required this.id,
    required this.userId,
    required this.title,
    required this.employmentType,
    required this.departmentName,
    required this.otherDepartmentName,
    required this.companyName,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.industryName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"] ?? "",
        employmentType: json["employment_type"] ?? "",
        otherDepartmentName: json["other_department"] ?? "",
        companyName: json["company_name"] ?? "",
        departmentName: json["name_depart"] ?? "",
        location: json["location"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        industryName: json["industry_name"] ?? "",
        description: json["description"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "employment_type": employmentType,
        "company_name": companyName,
        "location": location,
        "start_date": startDate,
        "end_date": endDate,
        "industry_name": industryName,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Skill {
  int id;
  int userId;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Skill({
    required this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
