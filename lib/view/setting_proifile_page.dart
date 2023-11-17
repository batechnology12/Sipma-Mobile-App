import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/get_education_list_model.dart';
import 'package:simpa/view/change_password.dart';
import 'package:simpa/view/profile_sccuessful_page.dart';
import 'package:simpa/view/profile_settings_view/add_new_skills_page.dart';
import 'package:simpa/view/profile_settings_view/profile_add_new_possition_view.dart';
import 'package:simpa/widgets/bottumnavigationbar.dart';
import 'package:simpa/widgets/common_appbar.dart';
import 'package:simpa/searchable_dropdown-master/lib/dropdown_search.dart'
    as dp;

class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({super.key});

  @override
  State<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  bool _value = false;
  var nameController = TextEditingController();
  var lastNameController = TextEditingController();
  var bioTextControllerk = TextEditingController();
  var positionController = TextEditingController();
  var emailController = TextEditingController();
  var numberController = TextEditingController();
  var interestController = TextEditingController();
  var genderController = TextEditingController();
  var birthdayController = TextEditingController();
  final profileController = Get.find<ProfileController>();

    var educationController = TextEditingController();
  final authController = Get.find<AuthController>();

  var education;
  var edHintText = "Education";
  bool isEdSelected = false;

  @override
  void initState() {
    super.initState();
    setDefaullt();
    authController.education();
  }

  setDefaullt() async {
    if (profileController.profileData.isNotEmpty) {
      nameController.text = profileController.profileData.first.user.name;

      lastNameController.text =
          profileController.profileData.first.user.lastName ?? "";

      bioTextControllerk.text =
          profileController.profileData.first.user.bio ?? "";
      // selectedCategory =
      //     profileController.profileData.first.user. ?? "";
      positionController.text =
          profileController.profileData.first.user.designation ?? "";
      numberController.text = profileController.profileData.first.user.mobile;
      emailController.text =
          profileController.profileData.first.user.officialEmail ?? "";
      setState(() {
        selectedCategory = profileController.profileData.first.user.hisHer == "His"? "Mr": profileController.profileData.first.user.hisHer == "Her"? "Miss" : profileController.profileData.first.user.hisHer;
        edHintText =
            profileController.profileData.first.user.education ?? "Education";
      });
    }
  }

  var selectedCategory;

  bool isNewPossitionEnabled = false;

  Widget _buildDropDownButton() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            iconEnabledColor: Colors.grey,
            style: const TextStyle(
              color: Colors.grey,
            ),
            dropdownColor: Colors.white,
            value: selectedCategory,
            hint: const Text("Select"),
            items: ['Mr', 'Mrs', 'Dr', 'Miss']
                .map((String value) => DropdownMenuItem(
                      value: value,
                      child: Row(
                        children: <Widget>[
                          Text(
                            value,
                            style: primaryfont.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
          ),
        ),
      ),
    );
  }

  getBack() {
    Get.offAll(() => BottomNavigationBarExample(
          index: 4,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              getBack();
            },
            child: const Icon(Icons.arrow_back)),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                _value = !_value;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: GetBuilder<ProfileController>(builder: (_) {
                return Row(
                  children: [
                    Container(
                      height: 40,
                      width: 42,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: kblue),
                      child: profileController.isLoading.isTrue
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: IconButton(
                                  onPressed: () {
                                    if (nameController.text.isNotEmpty &&
                                        lastNameController.text.isNotEmpty &&
                                        emailController.text.isNotEmpty &&
                                        numberController.text.isNotEmpty) {
                                      profileController.updateUserDetails(
                                          name: nameController.text,
                                          lastName: lastNameController.text,
                                          bio: bioTextControllerk.text,
                                          designation: positionController.text,
                                          education: educationController.text,
                                          hisOrHer: selectedCategory ?? "",
                                          email: emailController.text,
                                          mobile: numberController.text);
                                    } else {
                                      Get.rawSnackbar(
                                        messageText: const Text(
                                          "Fill All the fields",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ))),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          return getBack();
        },
        child: Container(
          child: GetBuilder<ProfileController>(builder: (_) {
            return Column(
              children: [
                const SizedBox(
                  height: 28,
                ),
                GetBuilder<ProfileController>(builder: (_) {
                  return profileController.isLoading.isTrue
                      ? Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: const CircularProgressIndicator(),
                        )
                      : profileController.profileData.isEmpty
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                profileController.profileData.first.user
                                            .profilePicture ==
                                        null
                                    ? const CircleAvatar(
                                        radius: 60,
                                        backgroundImage: AssetImage(
                                            'assets/icons/profil_img.jpeg'))
                                    : CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(
                                            profileController.profileData.first
                                                .user.profilePicture),
                                      ),
                              ],
                            );
                }),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final XFile? timage =
                        await _picker.pickImage(source: ImageSource.gallery);

                    profileController.updateProfilePic(
                        media: File(timage!.path));
                  },
                  child: Text(
                    'Edit Profile Image',
                    style: TextStyle(fontSize: 17, color: kblue),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView(shrinkWrap: true, children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'First Name',
                                  labelText: 'First Name',
                                  prefixIcon: _buildDropDownButton(),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black))),
                              controller: nameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  labelText: 'Last Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black))),
                              controller: lastNameController,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Email Address',
                                  labelText: 'Email Address',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black))),
                              controller: emailController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText:
                                      'Describe yourself in less than 100 words',
                                  labelText: 'About me',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black))),
                              controller: bioTextControllerk,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  labelText: 'Phone Number',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black))),
                              controller: numberController,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // GetBuilder<AuthController>(builder: (_) {
                          //   return Padding(
                          //     padding:
                          //         const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: Row(
                          //             children: [
                          //               const Text(
                          //                 "Education",
                          //               ),
                          //               Text(
                          //                 "*",
                          //                 style: primaryfont.copyWith(
                          //                     color: Colors.red),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 0, right: 0),
                          //           child: Container(
                          //             height: 56,
                          //             child: authController
                          //                     .educationData.isEmpty
                          //                 ? Container(
                          //                     height: 10,
                          //                   )
                          //                 : dp.DropdownSearch<
                          //                     Educationlistdata>(
                          //                     itemAsString:
                          //                         (Educationlistdata u) =>
                          //                             u.title,
                          //                     popupProps: dp.PopupProps.menu(
                          //                       showSelectedItems: false,
                          //                       showSearchBox: true,
                          //                       itemBuilder:
                          //                           (context, item, isSelcted) {
                          //                         return Padding(
                          //                           padding:
                          //                               const EdgeInsets.all(
                          //                                   10.0),
                          //                           child: Column(
                          //                             crossAxisAlignment:
                          //                                 CrossAxisAlignment
                          //                                     .start,
                          //                             children: [
                          //                               Text(
                          //                                 item.title,
                          //                                 style: primaryfont
                          //                                     .copyWith(
                          //                                         fontWeight:
                          //                                             FontWeight
                          //                                                 .bold,
                          //                                         color: Colors
                          //                                             .black),
                          //                               ),
                          //                               for (int i = 0;
                          //                                   i <
                          //                                       item.educationlist
                          //                                           .length;
                          //                                   i++)
                          //                                 Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                               .symmetric(
                          //                                           vertical:
                          //                                               5),
                          //                                   child: InkWell(
                          //                                     onTap: () {
                          //                                       print(
                          //                                           "-<->-<->-<->-<->changes<->-<->-<->-<->-<->");
                          //                                       setState(
                          //                                         () {
                          //                                           authController
                          //                                               .isEducationSelected(
                          //                                                   false);
                          //                                           isEdSelected =
                          //                                               true;
                          //                                           education =
                          //                                               "${item.title} ${item.educationlist[i].name}";
                          //                                           edHintText =
                          //                                               "${item.title} ${item.educationlist[i].name}";
                          //                                           educationController
                          //                                                   .text =
                          //                                               "${item.title} ${item.educationlist[i].name}";
                          //                                           // requiremtsSelected = null;
                          //                                         },
                          //                                       );
                          //                                       Navigator.pop(
                          //                                           context);
                          //                                     },
                          //                                     child: Container(
                          //                                       height: 30,
                          //                                       // color: Colors.red,
                          //                                       child: Text(
                          //                                         item
                          //                                             .educationlist[
                          //                                                 i]
                          //                                             .name,
                          //                                         style: primaryfont
                          //                                             .copyWith(
                          //                                                 fontSize:
                          //                                                     13),
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //                                 )
                          //                             ],
                          //                           ),
                          //                         );
                          //                       },
                          //                       menuProps: dp.MenuProps(
                          //                           borderRadius:
                          //                               BorderRadius.circular(
                          //                                   10)),
                          //                       searchFieldProps:
                          //                           const dp.TextFieldProps(),
                          //                     ),
                          //                     items:
                          //                         authController.educationData,

                          //                     dropdownDecoratorProps:
                          //                         dp.DropDownDecoratorProps(
                          //                       dropdownSearchDecoration:
                          //                           InputDecoration(
                          //                         hintText: edHintText,
                          //                         hintStyle: TextStyle(
                          //                             color: isEdSelected
                          //                                 ? Colors.black
                          //                                 : Colors.black45),
                          //                         border: OutlineInputBorder(
                          //                           borderRadius:
                          //                               BorderRadius.circular(
                          //                                   15),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     // onChanged: (value) {
                          //                     //   setState(
                          //                     //     () {
                          //                     //       authController
                          //                     //           .isEducationSelected(false);
                          //                     //       education = value!;
                          //                     //       educationController.text =
                          //                     //           value.title;
                          //                     //       // requiremtsSelected = null;
                          //                     //     },
                          //                     //   );
                          //                     // },
                          //                   ),
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           height: 5,
                          //         ),
                          //         // Obx(
                          //         //   () => authController
                          //         //           .isEducationSelected.isTrue
                          //         //       ? const Padding(
                          //         //           padding: EdgeInsets.only(left: 15),
                          //         //           child: Text(
                          //         //             "Please select education",
                          //         //             style: TextStyle(
                          //         //                 color: Color.fromARGB(
                          //         //                     255, 230, 46, 33),
                          //         //                 fontSize: 12),
                          //         //           ),
                          //         //         )
                          //         //       : Container(),
                          //         // )
                          //       ],
                          //     ),
                          //   );
                          // }),
                         const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Current Position",
                                  style: primaryfont.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profileController.profileData.first.user
                                          .currentCompany,
                                      style: primaryfont.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      profileController.profileData.first
                                                  .departmentName ==
                                              "Others"
                                          ? profileController.profileData.first
                                              .user.otherDepartment
                                          : profileController
                                              .profileData.first.departmentName,
                                      style: primaryfont.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      profileController
                                          .profileData.first.user.designation,
                                      style: primaryfont.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      profileController
                                          .profileData.first.user.officialEmail,
                                      style: primaryfont.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const Divider(
                            thickness: 0.5,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                           const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Previous Company",
                                  style: primaryfont.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          for (int i = 0;
                              i <
                                  profileController
                                      .profileData.first.positions.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profileController.profileData.first
                                          .positions[i].companyName
                                          .toUpperCase(),
                                      style: primaryfont.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      profileController
                                                  .profileData
                                                  .first
                                                  .positions[i]
                                                  .departmentName ==
                                              "Others"
                                          ? profileController.profileData.first
                                              .positions[i].otherDepartmentName
                                          : profileController.profileData.first
                                              .positions[i].departmentName,
                                      style: primaryfont.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "${profileController.profileData.first.positions[i].location}.",
                                      style: primaryfont.copyWith(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "${profileController.profileData.first.positions[i].startDate} - ${profileController.profileData.first.positions[i].endDate == "" ? "On going" : profileController.profileData.first.positions[i].endDate} ",
                                      style: primaryfont.copyWith(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "${profileController.profileData.first.positions[i].employmentType}.",
                                      style: primaryfont.copyWith(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    const Divider(
                                      thickness: 0.5,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextButton(
                                    onPressed: () {
                                      Get.to(ProfileAddNewPossitonView());
                                    },
                                    child: Text(
                                      "+ Add new position",
                                      style: primaryfont.copyWith(
                                          color: Colors.blue),
                                    )),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Skills",
                                  style: primaryfont.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: profileController
                                    .profileData.first.skills.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 3, crossAxisCount: 3),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 3, left: 3, bottom: 5),
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: kblue.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          profileController.profileData.first
                                              .skills[index].name,
                                          style: primaryfont.copyWith(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextButton(
                                    onPressed: () {
                                      Get.to(AddNewSkillsView());
                                    },
                                    child: Text(
                                      "+ Add new Skills",
                                      style: primaryfont.copyWith(
                                          color: Colors.blue),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.all(10.0),
                          //   child: TextField(
                          //     decoration: InputDecoration(
                          //       hintText: 'Gender',
                          //     ),
                          //     controller: genderController,
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(10.0),
                          //   child: TextField(
                          //     decoration: InputDecoration(
                          //       hintText: 'Birthday',
                          //     ),
                          //     controller: birthdayController,
                          //   ),
                          // )
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
