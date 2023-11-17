

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../widgets/bottumnavigationbar.dart';


class postsplash extends StatefulWidget {
  const postsplash({super.key});

  @override
  State<postsplash> createState() => _postsplashState();
}

class _postsplashState extends State<postsplash> {
  @override
  void initState() {
    super.initState();
    toHomePage();
  }

  toHomePage() async {
    await Future.delayed(const Duration(seconds: 2));

    Get.offAll(() => BottomNavigationBarExample());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Character (1).png',
            height: 250,
            width: 250,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Your Post has Successfully Posted',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ));
  }
}
