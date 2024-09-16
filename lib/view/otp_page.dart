import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/controllers/profile_controller.dart';


import '../constands/constands.dart';

class OtpScreen extends StatefulWidget {
  String phoneNumber;
  String otp;
  OtpScreen({super.key, required this.phoneNumber, required this.otp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final authController = Get.find<AuthController>();
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
  }

  String otpValue = "";

  int _start = 60; // Timer duration in seconds
  bool _isActive = false;
  late Timer _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 1) {
          _isActive = false;
          timer.cancel();
          _start = 60;
        } else {
          _start--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
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
          Padding(
            padding:
                const EdgeInsets.only(left: 37, right: 37, top: 40, bottom: 40),
            child: Center(
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ]),
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'OTP Verification',
                    style: ktextstyle22,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Enter the OTP sent to',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.phoneNumber,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: const Icon(Icons.edit,size: 14,color: Colors.blue)),
                      )
                    ],
                  ),
                  // Text(
                  //   "OTP is -  ${widget.otp}",
                  //   style: const TextStyle(fontSize: 12),
                  // ),
                  ksizedbox10,
                  ksizedbox10,
                  OtpTextField(
                    numberOfFields: 4,
                    borderColor: const Color(0xFF512DA8),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      setState(() {
                        otpValue = verificationCode;
                      });
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         title: const Text("Verification Code"),
                      //         content:
                      //             Text('Code entered is $verificationCode'),
                      //       );
                      //     });
                    }, // end onSubmit
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't you receive the OTP? "),
                      _isActive
                          ? Text(
                              "Resend in $_start",
                              style: const TextStyle(color: Colors.blue),
                            )
                          : InkWell(
                              onTap: () async {
                                profileController.resendOtp(
                                    mobile: widget.phoneNumber);
                                setState(() {
                                  _isActive = true;
                                  // widget.otp = tempOtp;
                                });
                                startTimer();
                              },
                              child: const Text(
                                "Resend OTP",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                      // TextButton(
                      //     onPressed: () {},
                      //     child: const Text(
                      //       'Resend OTP',
                      //       style: TextStyle(color: Colors.blue),
                      //     ))
                    ],
                  ),
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
                                onPressed: () {
                                  // authController.otpVerify(widget.otp);
                                },
                                child: const CircularProgressIndicator(),
                              )
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
                                  print(otpValue);
                                  authController.registerOtpVerify(otpValue);
                                },
                                child: const Text(
                                  'Submit',
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
        ],
      ),
    );
  }
}
