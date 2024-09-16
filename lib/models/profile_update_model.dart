// To parse this JSON data, do
//
//     final profileUpdateModel = profileUpdateModelFromJson(jsonString);


class ProfileUpdateModel {
  String currentCompany;
  String designation;
  String department;
  String industries;
  String officialEmail;
  String address;
  String pincode;
  String city;
  String state;
  dynamic requirement;
  dynamic others;
  dynamic othersdepartment;
  dynamic education;

  ProfileUpdateModel({
    required this.currentCompany,
    required this.designation,
    required this.department,
    required this.industries,
    required this.officialEmail,
    required this.address,
    required this.pincode,
    required this.city,
    required this.state,
    required this.requirement,
    required this.others,
    required this.othersdepartment,
    required this.education,
  });
}
