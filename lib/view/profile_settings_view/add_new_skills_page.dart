import 'package:date_format/date_format.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/add_positions_model.dart';
import 'package:simpa/models/department_model.dart';
import 'package:simpa/models/industries_model.dart';
import 'package:simpa/models/skills_model.dart';

class AddNewSkillsView extends StatefulWidget {
  bool isFromLogin;
   AddNewSkillsView({super.key,this.isFromLogin = false});

  @override
  State<AddNewSkillsView> createState() => _AddNewSkillsViewState();
}

class _AddNewSkillsViewState extends State<AddNewSkillsView> {
  final authController = Get.find<AuthController>();
  final profileController = Get.find<ProfileController>();

  var industries;
  var employement;

  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  var titleController = TextEditingController();
  var locationController = TextEditingController();
  var companyNameController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authController.getIndustriesList();
    authController.getSkillsList();
  }

  List<String> employementType = [
    "Full time",
    "Part time",
    "Self employed",
  ];

  DateTime date = DateTime.now();
  DateTime date2 = DateTime.now();

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(1900),
      locale: const Locale('en', 'IN'),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kblue, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.blueAccent, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: kblue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null)
      setState(() {
        date = picked;
        startDateController.text = formatDate(date, [dd, "-", mm, "-", yyyy]);
      });
  }

  _selectDate2(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date2,
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(1900),
      locale: const Locale('en', 'IN'),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kblue, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.blueAccent, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: kblue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null)
      setState(() {
        date2 = picked;
        endDateController.text = formatDate(date2, [dd, "-", mm, "-", yyyy]);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Profile'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //         hintText: 'Skills',
          //         labelText: "Skills",
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10),
          //             borderSide: const BorderSide(color: Colors.black))),
          //     controller: titleController,
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<AuthController>(
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 56,
                  child: DropdownSearch<SkillsData>(
                    itemAsString: (SkillsData u) => u.name,
                    popupProps: PopupProps.menu(
                      showSelectedItems: false,
                      showSearchBox: true,
                      menuProps: MenuProps(borderRadius: BorderRadius.circular(10)),
                      searchFieldProps: const TextFieldProps(),
                    ),
                    items: authController.skillsDataList,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          // labelText: "Department *",
                          hintText: "Skills",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // authController.isDesignationSelected(false);
                        titleController.text = value!.name;
                      });
                    },
                    // selectedItem: selectedState,
                  ),
                ),
              );
            }
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(15.0),
          child: profileController.isLoading.isTrue
              ? Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: kblue, borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ))
              : InkWell(
                  onTap: () {
                    if (titleController.text.isEmpty) {
                      Get.rawSnackbar(
                          message: "Enter your skill",
                          backgroundColor: Colors.red);
                    } else {
                      profileController.addSkills(
                          skills: titleController.text,
                          isFromLogin: widget.isFromLogin,
                          useId: profileController.profileData.first.user.id
                              .toString());
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: kblue, borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    child: Text(
                      "Save",
                      style: primaryfont.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
