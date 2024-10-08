import 'package:date_format/date_format.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/add_positions_model.dart';
import 'package:simpa/models/city_list_model.dart';
import 'package:simpa/models/department_model.dart';
import 'package:simpa/models/requiremets_models.dart';

class EditProfilePreviouscompanyDetails extends StatefulWidget {
  String postionlistid;
  EditProfilePreviouscompanyDetails({super.key, required this.postionlistid});

  @override
  State<EditProfilePreviouscompanyDetails> createState() =>
      _EditProfilePreviouscompanyDetailsState();
}

class _EditProfilePreviouscompanyDetailsState
    extends State<EditProfilePreviouscompanyDetails> {
  final authController = Get.find<AuthController>();
  final profileController = Get.find<ProfileController>();
  var industries;
  var employement;
  CityList? selectedCity;
  var designation;
  var department;
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  var titleController = TextEditingController();
  var locationController = TextEditingController();
  var companyNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var othersController = TextEditingController();
  var othersDepartmentController = TextEditingController();
  var designationControllers = TextEditingController();
  var requiremtsSelected;

  @override
  void initState() {
    super.initState();
    authController
        .getpostionList(postionid: widget.postionlistid)
        .then((value) {
      companyNameController.text =
          authController.getpostionDataList.first.companyName;
      descriptionController.text =
          authController.getpostionDataList.first.description;
      startDateController.text =
          authController.getpostionDataList.first.startDate;
      endDateController.text = authController.getpostionDataList.first.endDate;
    });
    authController.getIndustriesList();
    authController.getCityList(1141);
    authController.getDepartmentList();
    authController.getRequiremetList();
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
                foregroundColor: kblue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        date = picked;
        startDateController.text = formatDate(date, [dd, "-", mm, "-", yyyy]);
      });
    }
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
                foregroundColor: kblue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        date2 = picked;
        endDateController.text = formatDate(date2, [dd, "-", mm, "-", yyyy]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Profile'),
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<AuthController>(builder: (_) {
        if (authController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: [
              //dropdown
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Company Name',
                      labelText: "Company Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black))),
                  controller: companyNameController,
                ),
              ),

              // GetBuilder<AuthController>(builder: (_) {
              //   return Padding(
              //     padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         // Padding(
              //         //   padding: const EdgeInsets.all(8.0),
              //         //   child: Row(
              //         //     children: [
              //         //       const Text(
              //         //         "Industries",
              //         //       ),
              //         //       Text(
              //         //         "*",
              //         //         style: primaryfont.copyWith(color: Colors.red),
              //         //       ),
              //         //     ],
              //         //   ),
              //         // ),
              //         // Container(
              //         //   height: 50,
              //         //   width: 330,
              //         //   decoration: BoxDecoration(
              //         //       borderRadius: BorderRadius.circular(10),
              //         //       border: Border.all(
              //         //           color: const Color.fromARGB(
              //         //                   255, 158, 158, 158)
              //         //               .withOpacity(0.2))),
              //         //   child: Padding(
              //         //     padding: const EdgeInsets.only(
              //         //         left: 10, right: 10, top: 10),
              //         //     child: DropdownButton<Department>(
              //         //       value: designation,
              //         //       isExpanded: true,
              //         //       icon: const Icon(
              //         //           Icons.keyboard_arrow_down_outlined),
              //         //       elevation: 0,
              //         //       itemHeight: 55,
              //         //       isDense: true,
              //         //       dropdownColor: Colors.grey[250],
              //         //       style: const TextStyle(color: Colors.black54),
              //         //       hint: const Text(
              //         //         "Department",
              //         //         style: TextStyle(fontSize: 14),
              //         //       ),
              //         //       onChanged: (Department? value) {
              //         //         // This is called when the user selects an item.
              //         //         setState(() {
              //         //           authController
              //         //               .isDesignationSelected(false);
              //         //           designation = value!;
              //         //         });
              //         //       },
              //         //       items: authController.departments
              //         //           .map<DropdownMenuItem<Department>>(
              //         //               (Department value) {
              //         //         return DropdownMenuItem<Department>(
              //         //           value: value,
              //         //           child: Text(value.title),
              //         //         );
              //         //       }).toList(),
              //         //     ),
              //         //   ),
              //         // ),
              //         Padding(
              //           padding: const EdgeInsets.only(left: 0, right: 0),
              //           child: Container(
              //             height: 56,
              //             child: DropdownSearch<Industry>(
              //               itemAsString: (Industry u) => u.name,
              //               popupProps: PopupProps.menu(
              //                 showSelectedItems: false,
              //                 showSearchBox: true,
              //                 menuProps: MenuProps(
              //                     borderRadius: BorderRadius.circular(10)),
              //                 searchFieldProps: const TextFieldProps(),
              //               ),
              //               items: authController.industriesList,
              //               dropdownDecoratorProps: DropDownDecoratorProps(
              //                 dropdownSearchDecoration: InputDecoration(
              //                     // labelText: "Department *",
              //                     hintText: "Industries",
              //                     border: OutlineInputBorder(
              //                         borderRadius: BorderRadius.circular(15))),
              //               ),
              //               onChanged: (value) {
              //                 setState(() {
              //                   authController.isInduaturesSelected(false);
              //                   industries = value!;
              //                 });
              //               },
              //               // selectedItem: selectedState,
              //             ),
              //           ),
              //         ),

              //         const SizedBox(
              //           height: 5,
              //         ),
              //         Obx(
              //           () => authController.isInduaturesSelected.isTrue
              //               ? const Padding(
              //                   padding: EdgeInsets.only(left: 15),
              //                   child: Text(
              //                     "Please select Industries",
              //                     style: TextStyle(
              //                         color: Color.fromARGB(255, 230, 46, 33),
              //                         fontSize: 12),
              //                   ),
              //                 )
              //               : Container(),
              //         )
              //       ],
              //     ),
              //   );
              // }),

              GetBuilder<AuthController>(builder: (_) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: SizedBox(
                          height: 56,
                          child: DropdownSearch<Department>(
                            itemAsString: (Department u) => u.title,
                            popupProps: PopupProps.menu(
                              showSelectedItems: false,
                              showSearchBox: true,
                              menuProps: MenuProps(
                                  borderRadius: BorderRadius.circular(10)),
                              searchFieldProps: const TextFieldProps(),
                            ),
                            items: authController.departments,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  // labelText: "Department *",
                                  hintText: authController.getpostionDataList
                                              .first.department.title ==
                                          "Others"
                                      ? authController.getpostionDataList.first
                                          .otherDepartment
                                      : authController.getpostionDataList.first
                                          .department.title,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                            onChanged: (value) {
                              setState(() {
                                authController.isDesignationSelected(false);
                                department = value!;
                              });
                            },
                            // selectedItem: selectedState,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => authController.isDesignationSelected.isTrue
                            ? const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Please select Department",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 230, 46, 33),
                                      fontSize: 12),
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                );
              }),
              if (department != null && department.title == "Others")
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter Department',
                        labelText: "Others",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black))),
                    controller: othersDepartmentController,
                  ),
                ),
              if (department != null && department.title == "HR Department")
                const SizedBox(
                  height: 10,
                ),
              if (department != null && department.title == "HR Department")
                Column(
                  children: [
                    GetBuilder<AuthController>(builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 56,
                          child: DropdownSearch<Requirement>(
                            itemAsString: (Requirement u) => u.name,
                            popupProps: PopupProps.menu(
                              showSelectedItems: false,
                              showSearchBox: true,
                              menuProps: MenuProps(
                                  borderRadius: BorderRadius.circular(10)),
                              searchFieldProps: const TextFieldProps(),
                            ),
                            items: authController.requirementList,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  // labelText: "Recruitment",
                                  hintText: "Category",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                            onChanged: (value) {
                              setState(() {
                                requiremtsSelected = value!;
                              });
                            },
                            // selectedItem: selectedState,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              if (requiremtsSelected != null &&
                  requiremtsSelected.name == "Others")
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter Others',
                        labelText: "Others",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black))),
                    controller: locationController,
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter Designation',
                      labelText: "Designation",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black))),
                  controller: descriptionController,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: SizedBox(
                  height: 56,
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSelectedItems: false,
                      showSearchBox: true,
                      menuProps:
                          MenuProps(borderRadius: BorderRadius.circular(10)),
                      searchFieldProps: const TextFieldProps(),
                    ),
                    items: employementType,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          // labelText: "Department *",
                          hintText: authController
                              .getpostionDataList.first.employmentType,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    onChanged: (value) {
                      setState(() {
                        employement = value!;
                      });
                    },
                    // selectedItem: selectedState,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, right: 10),
              //   child: Container(
              //     height: 60,
              //     width: 330,
              //     // padding: EdgeInsets.all(2),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border.all(
              //             color: const Color.fromARGB(255, 12, 12, 12)
              //                 .withOpacity(0.4))),
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
              //       child: DropdownButton<String>(
              //         value: employement,
              //         isExpanded: true,
              //         icon: const Icon(Icons.keyboard_arrow_down_outlined),
              //         elevation: 0,
              //         itemHeight: 55,
              //         isDense: true,
              //         dropdownColor: Colors.grey[250],
              //         style: const TextStyle(color: Colors.black54),
              //         hint: const Text(
              //           "Employment Type",
              //           style: TextStyle(fontSize: 14),
              //         ),
              //         onChanged: (String? value) {
              //           // This is called when the user selects an item.
              //           setState(() {
              //             employement = value!;
              //           });
              //         },
              //         items: employementType
              //             .map<DropdownMenuItem<String>>((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(value),
              //           );
              //         }).toList(),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15, bottom: 8, top: 3),
                  //   child: Row(
                  //     children: [
                  //       const Text(
                  //         "Location",
                  //       ),
                  //       Text(
                  //         "*",
                  //         style: primaryfont.copyWith(color: Colors.red),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  GetBuilder<AuthController>(builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: DropdownSearch<CityList>(
                        itemAsString: (CityList u) => u.city,
                        popupProps: PopupProps.menu(
                          showSelectedItems: false,
                          showSearchBox: true,
                          menuProps: MenuProps(
                              borderRadius: BorderRadius.circular(10)),
                          searchFieldProps: const TextFieldProps(),
                        ),
                        items: authController.cityList,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              // labelText: "City",
                              hintText: authController
                                  .getpostionDataList.first.location,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value!;
                            locationController.text = value.city;
                            // citySelected = value.id;
                            // cityController.text = value.city;
                          });
                        },
                        // selectedItem: selectedCity,
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(
                height: 5,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onTap: () {
                    _selectDate(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Start Date',
                      labelText: "Start Date",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black))),
                  controller: startDateController,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onTap: () {
                    _selectDate2(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'End Date',
                      labelText: "End Date",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black))),
                  controller: endDateController,
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         hintText: 'Description',
              //         labelText: "Description",
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //             borderSide: const BorderSide(color: Colors.black))),
              //     controller: descriptionController,
              //   ),
              // ),
            ],
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        if (profileController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: InkWell(
              onTap: department != null ||
                      requiremtsSelected != null ||
                      employement != null ||
                      othersController.text.isNotEmpty ||
                      companyNameController.text.isNotEmpty ||
                      locationController.text.isNotEmpty ||
                      startDateController.text.isNotEmpty
                  ? () {
                      AddPositonsModel addPositonsModel = AddPositonsModel(
                          department: department == null
                              ? ""
                              : department.id.toString(),
                          designation: designationControllers.text,
                          requireMents: requiremtsSelected == null
                              ? ""
                              : requiremtsSelected.id.toString(),
                          others: othersController.text,
                          company_name: companyNameController.text,
                          employment_type:
                              employement == null ? "" : employement,
                          end_date: endDateController.text.isEmpty
                              ? "null"
                              : endDateController.text,
                          industry_name: "",
                          location: locationController.text,
                          othersdepartment: othersDepartmentController.text,
                          start_date: startDateController.text);
                      print(addPositonsModel);
                      profileController.updatePositions(
                          isFromLogin: false,
                          addPostionsModel: addPositonsModel,
                          useId: profileController.profileData.first.user.id
                              .toString(),
                          id: widget.postionlistid);
                    }
                  : null,
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
          );
        }
      }),
    );
  }
}
