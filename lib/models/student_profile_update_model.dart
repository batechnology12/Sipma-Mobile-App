// To parse this JSON data, do
//
//     final profileUpdateModel = profileUpdateModelFromJson(jsonString);


class StudentProfileUpdateModel {
  dynamic currentCompany;
  dynamic designation;
  dynamic department;
  dynamic industries;
  dynamic officialEmail;
  dynamic address;
  String pincode;
  String city;
  String state;
  dynamic requirement;
  dynamic others;
  dynamic othersdepartment;
  dynamic education;

  StudentProfileUpdateModel({
    this.currentCompany,
    this.designation,
    this.department,
    this.industries,
    this.officialEmail,
    this.address,
    required this.pincode,
    required this.city,
    required this.state,
    this.requirement,
    this.others,
    this.othersdepartment,
    this.education,
  });
}
