import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'package:simpa/controllers/profile_controller.dart';

import 'package:simpa/view/login/login_view/loginpage.dart';

import 'package:simpa/view/register_details_page.dart';


class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    checkForAuth();
  }

  toHomePage() async {
    await Future.delayed(const Duration(milliseconds: 3900));

    Get.find<ProfileController>().checkWhetherHeGo();
  }

  toLoginPage() async {
    await Future.delayed(const Duration(milliseconds: 3900));
     
    Get.offAll(
      () => const loginpage(),
    );
  }

  toregisterDetailsPage() async {
    await Future.delayed(const Duration(milliseconds: 3900));
    Get.offAll(
      () => const RegisterDetailsView(),
    );
  }

  checkForAuth() async {
    final prefs = await SharedPreferences.getInstance();
    String? authtoken = prefs.getString("auth_token");
    String? verify = prefs.getString("verify");
    print("Token is here");
    print(authtoken);
    if (authtoken == "null" || authtoken == null) {
      toLoginPage();
    } else {
      print("---------inside login---------");
      if (verify == "true") {
        toHomePage();
      } else {
        print("---------verify false---------");
        toregisterDetailsPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Image.asset('assets/images/iPhone 14 Pro Max – 1.gif'),
        ),
      ),
    );
  }
}
