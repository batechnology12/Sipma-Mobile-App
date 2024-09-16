import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/auth_controllers.dart';

class OnbordingStudent extends StatefulWidget {
  const OnbordingStudent({super.key});

  @override
  State<OnbordingStudent> createState() => _OnbordingStudentState();
}

class _OnbordingStudentState extends State<OnbordingStudent> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Student',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            // ksizedbox30,
            // const Text(
            //   'If it is a student, then the following update has to show in theirprofile to match the preference of the HR profession',
            //   style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.black54),
            // ),
            ksizedbox30,
            ksizedbox30,
            const Text(
              'Would you like to get a  _________________',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            ksizedbox40,
            ksizedbox30,
            Obx(
              () => Column(
                children: [
                  InkWell(
                    onTap: () {
                      authController.professinalindex(0);
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kgrey),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // kwidth10,
                            const Text(
                              'Mentor',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            authController.professinalindex.value == 0
                                ? Icon(
                                    Icons.check_circle,
                                    color: kblue,
                                    size: 30,
                                  )
                                : Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: kgrey,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  )
                            //   kwidth10
                          ],
                        ),
                      ),
                    ),
                  ),
                  ksizedbox30,
                  InkWell(
                    onTap: () {
                      authController.professinalindex(1);
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kgrey),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // kwidth10,
                            const Text(
                              'Training',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),

                            authController.professinalindex.value == 1
                                ? Icon(
                                    Icons.check_circle,
                                    color: kblue,
                                    size: 30,
                                  )
                                : Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: kgrey,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  )
                            //   kwidth10
                          ],
                        ),
                      ),
                    ),
                  ),
                  ksizedbox30,
                  InkWell(
                    onTap: () {
                      authController.professinalindex(2);
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kgrey),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // kwidth10,
                            const Text(
                              'Certification',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            authController.professinalindex.value == 2
                                ? Icon(
                                    Icons.check_circle,
                                    color: kblue,
                                    size: 30,
                                  )
                                : Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: kgrey,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  )
                            //   kwidth10
                          ],
                        ),
                      ),
                    ),
                  ),
                  ksizedbox10,
                  // InkWell(
                  //   onTap: () {
                  //     authController.professinalindex(3);
                  //   },
                  //   child: Container(
                  //     height: 40,
                  //     width: double.infinity,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 8),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           // kwidth10,
                  //           Text(
                  //             'Apprenticeship Opportunity',
                  //             style: TextStyle(
                  //                 fontSize: 16, fontWeight: FontWeight.w500),
                  //           ),
                  //           authController.professinalindex.value == 3
                  //               ? Icon(
                  //                   Icons.check_circle,
                  //                   color: kblue,
                  //                   size: 30,
                  //                 )
                  //               : Container(
                  //                   width: 25,
                  //                   height: 25,
                  //                   decoration: BoxDecoration(
                  //                     color: kgrey,
                  //                     borderRadius: BorderRadius.circular(25),
                  //                   ),
                  //                 )
                  //           //   kwidth10
                  //         ],
                  //       ),
                  //     ),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(width: 1, color: kgrey),
                  //         borderRadius: BorderRadius.circular(25)),
                  //   ),
                  // ),  ksizedbox10,
                  // InkWell(
                  //   onTap: () {
                  //     authController.professinalindex(4);
                  //   },
                  //   child: Container(
                  //     height: 40,
                  //     width: double.infinity,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 8),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           // kwidth10,
                  //           Text(
                  //             'Internship Opportunity',
                  //             style: TextStyle(
                  //                 fontSize: 16, fontWeight: FontWeight.w500),
                  //           ),
                  //           authController.professinalindex.value == 4
                  //               ? Icon(
                  //                   Icons.check_circle,
                  //                   color: kblue,
                  //                   size: 30,
                  //                 )
                  //               : Container(
                  //                   width: 25,
                  //                   height: 25,
                  //                   decoration: BoxDecoration(
                  //                     color: kgrey,
                  //                     borderRadius: BorderRadius.circular(25),
                  //                   ),
                  //                 )
                  //           //   kwidth10
                  //         ],
                  //       ),
                  //     ),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(width: 1, color: kgrey),
                  //         borderRadius: BorderRadius.circular(25)),
                  //   ),
                  // ),
                ],
              ),
            ),
            ksizedbox40,
            ksizedbox30,
            InkWell(
              onTap: () {
                String? type;
                if (authController.professinalindex.value == 0) {
                  type = "Mentor";
                } else if (authController.professinalindex.value == 1) {
                  type = "Training";
                } else if (authController.professinalindex.value == 2) {
                  type = "Certification";
                }
                authController.studentProfessionaltype(type: type!);
                //Get.offAll(const registersplash());
              },
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                    color: kblue, borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(
                  'Continue',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16, color: kwhite),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
