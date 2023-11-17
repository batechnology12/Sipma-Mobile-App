import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simpa/controllers/profile_controller.dart';
import '../constands/constands.dart';


class DeleteUserScreen extends StatefulWidget {
  const DeleteUserScreen({super.key});

  @override
  State<DeleteUserScreen> createState() =>
      _DeleteUserScreenState();
}

class _DeleteUserScreenState extends State<DeleteUserScreen> {

  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    //toHomePage();
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

   final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 // kverifiyforgotimage,
                  Text(
                    'Delete your account',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Confirm your password',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30,bottom: 30),
                    child: Container(
                      height: 300.h,
                      width: size.width,
                      child: Center(child: kdeleteUserimage)),
                  ),
                  TextFormField(
                                      // autofocus: true,
                                      controller: passwordController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: !_obscured,
                                      // focusNode: textFieldFocusNode,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior
                                            .never, //Hides label on focus or if filled
                                        labelText: "Enter your password",
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
                                      // focusNode: textFieldFocusNode1,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior
                                            .never, //Hides label on focus or if filled
                                        labelText: "Confirm your password",
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
                   ksizedbox10,
                   ksizedbox10,
                   TextFormField(
                                      // autofocus: true,
                                      // controller: passwordController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.visiblePassword,
                                      
                                      
                                    maxLines: 3,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior
                                            .never, //Hides label on focus or if filled
                                        labelText: "Reason (optional)",
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
                                        
                                      ),
                                     
                                    ),
                ],
              ),
            ),
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
                    backgroundColor:Color.fromARGB(255, 223, 48, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if(confirmpasswordController.text == passwordController.text){
                        _showMyDialog();
                      }else{
                        Get.rawSnackbar(
                          message: "Passwords do not match.",
                          backgroundColor: Colors.red,
                          

                        );
                      }
}
                  },
                  child:const Text(
                    'Delete',
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




  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Account'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to delete your account?'),
            
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Keep my account'),
            onPressed: () {
               
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete my account'),
            onPressed: () {
             
                     profileController.deleteYourAccount(
                      password: passwordController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}
