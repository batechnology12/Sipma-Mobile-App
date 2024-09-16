import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/models/register_model.dart';
import 'package:simpa/widgets/password_text_field.dart';
import 'package:simpa/widgets/phone_number_text_field.dart';
import '../widgets/textfield.dart';
import '../constands/constands.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var userNameController = TextEditingController();
  var emailIdController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var createPassWordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    userNameController.addListener(checkUser);
  }

  var primaryFont = const TextStyle();

  bool isEmailVerified = false;
  Timer? emailVerificationTimer;
  Timer? checkStatusTimer;

  popupClose() {}

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return popupClose();
          },
          child: AlertDialog(
            key: _dialogKey,
            title: const Text('Verify your email'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Please check your email for confirmation mail.',
                    style: primaryfont.copyWith(fontSize: 13),
                  ),
                  Text(
                    'Click link in email to verify',
                    style: primaryfont.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  authController.isShowDialogActive(false);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Refresh'),
                onPressed: () {
                  authController.checkEmailVerification(
                      emailId: emailIdController.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void checkForEmailVerify() async {
    const onsec = Duration(seconds: 5);
    Timer timer = Timer.periodic(onsec, (timer) async {
      bool tempIsEmailVerified = await authController.checkEmailVerification(
          emailId: emailIdController.text);

      if (tempIsEmailVerified == true) {
        setState(() {
          isEmailVerified = true;
        });
        // timer.cancel();
        if (authController.isShowDialogActive.isTrue) {
          authController.isShowDialogActive(false);
          print("-------------------------closing>//");
          Get.back(closeOverlays: true, canPop: false);
        }
      } else {
        authController.isShowDialogActive(false);
        print("-------------------------closing2time>//");
      }
    });
  }

  // Start timer to delay API call
  void startEmailVerificationTimer() {
    // Cancel previous timer if already active
    if (emailVerificationTimer != null) {
      emailVerificationTimer!.cancel();
    }

    emailVerificationTimer = Timer(const Duration(seconds: 1), () {
      sendVerificationEmail();
    });
  }

  // Call the API to send verification email
  void sendVerificationEmail() async {
    if (emailIdController.text.isEmail) {
      bool isEmailSent = await authController.sendEmailVerification(
        emailId: emailIdController.text,
      );

      if (isEmailSent) {
        startStatusCheckTimer();
      }
    } else {
      Get.rawSnackbar(message: "Enter a valid Email ID");
    }
  }

  // Start checking the verification status every 5 seconds
  void startStatusCheckTimer() {
    checkStatusTimer =
        Timer.periodic(const Duration(seconds: 5), (timer) async {
      bool tempIsEmailVerified = await authController.checkEmailVerification(
        emailId: emailIdController.text,
      );

      if (tempIsEmailVerified) {
        setState(() {
          isEmailVerified = true;
        });
        timer.cancel(); // Stop the timer once verified
      }
    });
  }

  @override
  void dispose() {
    emailVerificationTimer?.cancel();
    checkStatusTimer?.cancel();
    super.dispose();
  }

  checkUser() {
    authController.checkUserName(userName: userNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            child: Image.asset(
              'assets/images/Ellipse 1.png',
              fit: BoxFit.contain,
            ),
          ),
          ListView(physics: const BouncingScrollPhysics(), children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 37, right: 37, top: 40, bottom: 40),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/title.jpg',
                      ),
                    ),
                    ksizedbox10,
                    Text(
                      'Welcome to SIPMAA',
                      style: ktextstyle22,
                    ),
                    Text(
                      'HR community',
                      style: ktextstyle,
                    ),
                    ksizedbox30,

                    // Obx(
                    //   () => Container(
                    //     height: 50,
                    //     width: size.width * 0.7,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       color: kwhite,
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 2, right: 2, top: 2, bottom: 2),
                    //           child: InkWell(
                    //             onTap: () {
                    //               authController.wayIndex(0);
                    //             },
                    //             child: Container(
                    //               height: 50,
                    //               width: 110,
                    //               decoration: BoxDecoration(
                    //                   color: authController.wayIndex.value == 0
                    //                       ? kblue
                    //                       : Colors.white,
                    //                   borderRadius: BorderRadius.circular(20)),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(right: 7),
                    //                 child: Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     // Image.asset(
                    //                     //   "assets/images/flight_booking/Group.png",
                    //                     //   height: 20,
                    //                     //   color:
                    //                     //       authController.wayIndex.value ==
                    //                     //               0
                    //                     //           ? kwhite
                    //                     //           : kblue,
                    //                     // ),
                    //                     Text(
                    //                       "Student",
                    //                       style: primaryFont.copyWith(
                    //                         fontSize: 14,
                    //                         color:
                    //                             authController.wayIndex.value ==
                    //                                     0
                    //                                 ? kwhite
                    //                                 : kblue,
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 2, right: 2, top: 2, bottom: 2),
                    //           child: InkWell(
                    //             onTap: () {
                    //               authController.wayIndex(1);
                    //             },
                    //             child: Container(
                    //               height: 50,
                    //               width: 110,
                    //               decoration: BoxDecoration(
                    //                   color: authController.wayIndex.value == 1
                    //                       ? kblue
                    //                       : Colors.white,
                    //                   borderRadius: BorderRadius.circular(20)),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(right: 7),
                    //                 child: Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     // Image.asset(
                    //                     //   "assets/images/flight_booking/Swap.png",
                    //                     //   height: 20,
                    //                     //   color:
                    //                     //       authController.wayIndex.value ==
                    //                     //               1
                    //                     //           ? kwhite
                    //                     //           : kblue,
                    //                     // ),
                    //                     Text(
                    //                       "Professional",
                    //                       style: primaryFont.copyWith(
                    //                         fontSize: 14,
                    //                         color:
                    //                             authController.wayIndex.value ==
                    //                                     1
                    //                                 ? kwhite
                    //                                 : kblue,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    TextformfieldWidget(
                        controller: firstNameController,
                        validationText: "First name can't be empty",
                        text: 'First Name',
                        textt: 'First Name'),
                    TextformfieldWidget(
                        controller: lastNameController,
                        validationText: "Last name can't be empty",
                        text: 'Last Name',
                        textt: 'Last Name'),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "User Name",
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                controller: userNameController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "User Name can't be empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor: Colors.grey[250],
                                  labelText: 'User Name',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(0, 158, 158, 158),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(0, 158, 158, 158),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(0, 158, 158, 158),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      17.0, 8.0, 17.0, 7.0),
                                ),
                              ),
                              if (userNameController.text.isNotEmpty)
                                Obx(
                                  () =>
                                      authController.isUserNameAvailable.isFalse
                                          ? const Text(
                                              'Not Available',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : const Text(
                                              'Available',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Email ID",
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailIdController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ""; //Email ID can't be empty
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    isEmailVerified =
                                        false; // Reset verification status on change
                                  });
                                  startEmailVerificationTimer(); // Start the timer when email is changed
                                },
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor: Colors.grey[250],
                                  labelText: '', //Enter Email ID
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(0, 158, 158, 158),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  filled: true,
                                  suffixIcon: emailIdController.text.length > 3
                                      ? isEmailVerified
                                          ? const SizedBox(
                                              width: 30,
                                              child: Icon(
                                                Icons.verified,
                                                color: Colors.green,
                                              ),
                                            )
                                          : const SizedBox(
                                              width: 30,
                                              child: Icon(
                                                Icons.hourglass_empty,
                                                color: Colors.orange,
                                              ),
                                            )
                                      : Container(width: 5),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(0, 158, 158, 158),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(0, 158, 158, 158),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      17.0, 8.0, 17.0, 7.0),
                                ),
                              ),
                            ],
                          )
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     TextFormField(
                          //       keyboardType: TextInputType.emailAddress,
                          //       controller: emailIdController,
                          //       autovalidateMode:
                          //           AutovalidateMode.onUserInteraction,
                          //       validator: (value) {
                          //         if (value!.isEmpty) {
                          //           return "Email ID can't be empty";
                          //         }
                          //         return null;
                          //       },
                          //       onChanged: (val) {
                          //         print("changes-------------------------");
                          //         setState(() {
                          //           isEmailVerified = false;
                          //         });
                          //       },
                          //       decoration: InputDecoration(
                          //         floatingLabelBehavior:
                          //             FloatingLabelBehavior.never,
                          //         fillColor: Colors.grey[250],
                          //         labelText: 'Enter Email ID',
                          //         hintStyle: TextStyle(
                          //           color: Colors.grey[500],
                          //         ),
                          //         border: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //               color: Color.fromARGB(0, 158, 158, 158),
                          //               width: 2.0),
                          //           borderRadius: BorderRadius.circular(16.0),
                          //         ),
                          //         filled: true,
                          //         suffixIcon: emailIdController.text.length > 3
                          //             ? isEmailVerified
                          //                 ? const SizedBox(
                          //                     width: 30,
                          //                     child: Icon(
                          //                       Icons.verified,
                          //                       color: Colors.green,
                          //                     ),
                          //                   )
                          //                 : InkWell(
                          //                     onTap: () async {
                          //                       if (emailIdController
                          //                           .text.isEmail) {
                          //                         bool isEmailSent =
                          //                             await authController
                          //                                 .sendEmailVerification(
                          //                                     emailId:
                          //                                         (emailIdController
                          //                                             .text));

                          //                         if (isEmailSent == true) {
                          //                           checkForEmailVerify();
                          //                           authController
                          //                               .isShowDialogActive(
                          //                                   true);
                          //                           _showMyDialog();
                          //                         }
                          //                       } else {
                          //                         Get.rawSnackbar(
                          //                             message:
                          //                                 "Enter a valid Email Id");
                          //                       }
                          //                     },
                          //                     child: SizedBox(
                          //                       width: 60,
                          //                       child: Row(
                          //                         children: [
                          //                           Padding(
                          //                             padding:
                          //                                 const EdgeInsets.only(
                          //                                     left: 3,
                          //                                     right: 3),
                          //                             child: Container(
                          //                                 height: 25,
                          //                                 decoration: BoxDecoration(
                          //                                     color:
                          //                                         Colors.green,
                          //                                     borderRadius:
                          //                                         BorderRadius
                          //                                             .circular(
                          //                                                 20)),
                          //                                 alignment:
                          //                                     Alignment.center,
                          //                                 child: Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                           .only(
                          //                                           left: 10,
                          //                                           right: 10),
                          //                                   child: Text(
                          //                                     "Verify",
                          //                                     style: primaryfont
                          //                                         .copyWith(
                          //                                             fontSize:
                          //                                                 13,
                          //                                             color: Colors
                          //                                                 .white),
                          //                                   ),
                          //                                 )),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   )
                          //             : Container(
                          //                 width: 5,
                          //               ),
                          //         enabledBorder: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //               color: Color.fromARGB(0, 158, 158, 158),
                          //               width: 2.0),
                          //           borderRadius: BorderRadius.circular(16.0),
                          //         ),
                          //         focusedBorder: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //               color: Color.fromARGB(0, 158, 158, 158),
                          //               width: 2.0),
                          //           borderRadius: BorderRadius.circular(16.0),
                          //         ),
                          //         contentPadding: const EdgeInsets.fromLTRB(
                          //             17.0, 8.0, 17.0, 7.0),
                          //       ),
                          //     ),
                          //     // const Text(
                          //     //   'Verify',
                          //     //   style: TextStyle(
                          //     //       color: Colors.green,
                          //     //       fontSize: 12,
                          //     //       fontWeight: FontWeight.w600),
                          //     // )
                          //   ],
                          // ),
                        ],
                      ),
                    ),

                    TextPhoneformfieldWidget(
                        controller: phoneNumberController,
                        text: 'Phone Number',
                        textt: 'Phone Number'),
                    PassWordTextformfieldWidget(
                        controller: createPassWordController,
                        validationText: "Create Password can't be empty",
                        text: 'Create Password',
                        textt: 'Create Password'),
                    // TextformfieldWidget(
                    //     text: 'Enter Email Id', textt: 'Email Id'),
                    PassWordTextformfieldWidget(
                        controller: confirmPasswordController,
                        validationText: "Conform Password can't be empty",
                        text: 'Confirm Password',
                        textt: 'Confirm Password'),
                    ksizedbox10,
                    ksizedbox10,
                    ksizedbox10,
                    Obx(
                      () => SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: authController.isLoading.isTrue
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                      0xFF3C73B1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const CircularProgressIndicator())
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                      0xFF3C73B1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // _lastNameKey.currentState!.validate();
                                      // if (firstNameController.text.isEmpty) {
                                      //   Get.rawSnackbar(
                                      //     messageText: const Text(
                                      //       "Confirm password must match the new password.",
                                      //       style: TextStyle(color: Colors.white),
                                      //     ),
                                      //     backgroundColor: Colors.red,
                                      //   );
                                      // } else if (lastNameController.text.isEmpty) {
                                      // } else if (userNameController.text.isEmpty) {
                                      // } else if (emailIdController.text.isEmpty) {
                                      // } else if (phoneNumberController.text.isEmpty) {
                                      // } else if (createPassWordController
                                      //     .text.isEmpty) {
                                      // } else if (confirmPasswordController
                                      //     .text.isEmpty) {
                                      // } else {

                                      // }

                                      if (isEmailVerified) {
                                        if (createPassWordController.text ==
                                            confirmPasswordController.text) {
                                          //register here

                                          RegisterModel registerModel =
                                              RegisterModel(
                                            email: emailIdController.text,
                                            lastname: lastNameController.text,
                                            mobile: phoneNumberController.text,
                                            name: firstNameController.text,
                                            username: userNameController.text,
                                            passwordConfirmation:
                                                confirmPasswordController.text,
                                            password:
                                                createPassWordController.text,
                                            usertype:
                                                authController.wayIndex.value ==
                                                        0
                                                    ? "Student"
                                                    : "Professional",
                                          );
                                          authController
                                              .registerUser(registerModel);
                                          print(
                                              '---<<<<<<<<<<<<<<<<<<<------------------------------${registerModel.usertype}---------------------------------------->>>>>>>>>>>.---------------------------');
                                          print('');
                                        } else {
                                          Get.rawSnackbar(
                                            messageText: const Text(
                                              "Confirm password mu st match the new password.",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.red,
                                          );
                                        }
                                      } else {
                                        Get.rawSnackbar(
                                          messageText: const Text(
                                            "Verify your email to continue.",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                        );
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    ksizedbox10,
                  ]),
                ),
              ),
            )
          ])
        ],
      ),
    );
  }
}
