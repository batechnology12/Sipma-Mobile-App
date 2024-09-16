import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../widgets/bottumnavigationbar.dart';



class ProfileSuccessfullPage extends StatefulWidget {
  const ProfileSuccessfullPage({super.key});

  @override
  State<ProfileSuccessfullPage> createState() => _ProfileSuccessfullPageState();
}

class _ProfileSuccessfullPageState extends State<ProfileSuccessfullPage> {
  @override
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
            Image.asset('assets/images/successimage.png',),
            const SizedBox(
              height: 20,
            ),
           const Padding(
             padding: EdgeInsets.only(left: 17),
             child: Text( 'Your Profile has been',style: TextStyle(fontSize: 18),),
           ),
           const SizedBox(
            height: 2,
           ),
            const Padding(
              padding: EdgeInsets.only(left: 17),
              child: Text('Changes Successfully',style: TextStyle(fontSize: 18),),
            )
          ],
        ),
      ),
    );
  }
}
