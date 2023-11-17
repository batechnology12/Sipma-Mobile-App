import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/controllers/profile_controller.dart';
import '../constands/constands.dart';
import '../widgets/bottumnavigationbar.dart';



class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() =>
      _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {

  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    //toHomePage();
  }

   String otpValue = "";

  toHomePage() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.offAll(() => BottomNavigationBarExample());
  }

   var passwordController = TextEditingController();
   var confirmpasswordController = TextEditingController();
   final textFieldFocusNode = FocusNode();
   final textFieldFocusNode1 = FocusNode();

  bool _obscured = false;
   bool _obscured1 = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  void _toggleObscured2() {
    setState(() {
      _obscured1 = !_obscured1;
      if (textFieldFocusNode1.hasPrimaryFocus) return;
      textFieldFocusNode1.canRequestFocus = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kwhite,
        // title:const Text(
        //   'Forget Password',
        //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               // kverifiyforgotimage,
                Text(
                  'Create New Password',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                SizedBox(height: 5,),
                Text(
                  'create a new password',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30,bottom: 30),
                  child: Center(child: kcreatenewpwdimage),
                ),
                TextFormField(
                                    // autofocus: true,
                                    controller: passwordController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: !_obscured,
                                    focusNode: textFieldFocusNode,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior: FloatingLabelBehavior
                                          .never, //Hides label on focus or if filled
                                      labelText: "Enter New Password",
                                      filled: true,
                                      //  border: InputBorder.none,
                                      fillColor: Colors.grey[250],
                                      isDense: true, // Reduces height a bit
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                0, 158, 158, 158),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                0, 158, 158, 158),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                0, 158, 158, 158),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 0),
                                        child: GestureDetector(
                                          onTap: _toggleObscured,
                                          child: Icon(
                                            _obscured
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                            color: Colors.grey,
                                            size: 23,
                                          ),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Password can't be empty";
                                      } else if (value.length < 8) {
                                        return "Password must be of 8 characters";
                                      }
                                      return null;
                                    },
                                  ),
                                  ksizedbox10,
                                  ksizedbox10,
                                  TextFormField(
                                    // autofocus: true,
                                    controller: confirmpasswordController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: !_obscured1,
                                    focusNode: textFieldFocusNode1,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior: FloatingLabelBehavior
                                          .never, //Hides label on focus or if filled
                                      labelText: "Enter Confirm Password",
                                      filled: true,
                                      //  border: InputBorder.none,
                                      fillColor: Colors.grey[250],
                                      isDense: true, // Reduces height a bit
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                0, 158, 158, 158),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                0, 158, 158, 158),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                0, 158, 158, 158),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 0),
                                        child: GestureDetector(
                                          onTap: _toggleObscured2,
                                          child: Icon(
                                            _obscured1
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                            color: Colors.grey,
                                            size: 23,
                                          ),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Password can't be empty";
                                      } else if (value.length < 8) {
                                        return "Password must be of 8 characters";
                                      }
                                      return null;
                                    },
                                  ),
               
              ],
            ),
            ksizedbox30,
            ksizedbox30,
            Column(
              children: [
                SizedBox(
              height: 45,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color(
                      0xFF3C73B1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    profileController.resetPassword(
                      password: passwordController.text,
                      confirmPassword: confirmpasswordController.text);
                    // Get.to(const Sucessfullscreen());
                  },
                  child:const Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
