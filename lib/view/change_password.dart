import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/controllers/profile_controller.dart';
import '../constands/constands.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _isObscure = true;
  bool _isvalue = true;
  bool _isvalue2 = true;
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confrmPasswordController = TextEditingController();

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: _isObscure,
              controller: oldPasswordController,
              decoration: InputDecoration(
                  hintText: 'Old Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: _isvalue,
              controller: newPasswordController,
              decoration: InputDecoration(
                  hintText: 'New Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isvalue = !_isvalue;
                      });
                    },
                    icon: _isvalue
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: _isvalue2,
              controller: confrmPasswordController,
              decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isvalue2 = !_isvalue2;
                        });
                      },
                      icon: _isvalue2
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),),),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(150, 45),
                backgroundColor: kblue),
            onPressed: () {
              if (oldPasswordController.text.isNotEmpty &&
                  newPasswordController.text.isNotEmpty &&
                  confrmPasswordController.text.isNotEmpty) {
                profileController.changePassword(
                    oldPassword: oldPasswordController.text,
                    currentPassword: newPasswordController.text,
                    condirmPassword: confrmPasswordController.text);
              }
            },
            child: const Text(
              'Update',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
