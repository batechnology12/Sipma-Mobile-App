import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/view/register_page1.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:const Center(child: Image(image: AssetImage('assets/images/title.jpg'))),
      bottomNavigationBar: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kblue,
              borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Are You?",
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          authController.wayIndex(0);
                          Get.to(const RegisterScreen());
                        },
                        child: Container(
                          height: 110,
                          width: 150,
                          decoration:const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Image(image: AssetImage("assets/icons/cap.png"),
                                  height: 50,width: 50,),
                                  Text("Student",style: TextStyle(color: kblue,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          authController.wayIndex(1);
                          Get.to(const RegisterScreen());
                        },
                        child: Container(
                          height: 110,
                          width: 150,
                          decoration:const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Image(image: AssetImage("assets/icons/suitcase.png"),
                                  height: 50,width: 50,),
                                  Text("Professional",style: TextStyle(color: kblue,fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
    );
  }
}