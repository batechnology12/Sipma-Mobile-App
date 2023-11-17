class AddPositonsModel {
  String employment_type;
  String company_name;
  String location;
  String start_date;
  String end_date;
  String industry_name;
  String designation;
  dynamic department;
  dynamic requireMents;
  dynamic others;
  dynamic othersdepartment;

  AddPositonsModel({
    required this.company_name,
    required this.employment_type,
    required this.end_date,
    required this.industry_name,
    required this.location,
    required this.start_date,
    required this.requireMents,
    required this.department,
    required this.designation,
     this.others,
    this.othersdepartment,
  });
}
