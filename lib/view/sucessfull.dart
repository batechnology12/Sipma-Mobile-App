import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/widgets/bottumnavigationbar.dart';

class Sucessfullscreen extends StatefulWidget {
  const Sucessfullscreen({super.key});

  @override
  State<Sucessfullscreen> createState() => _SucessfullscreenState();
}

class _SucessfullscreenState extends State<Sucessfullscreen> {

  @override
  void initState() {
    super.initState();
    toHomePage();
  }

  toHomePage() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.offAll(() => BottomNavigationBarExample());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ksucessfullforgotimage,
      ),
    );
  }
}