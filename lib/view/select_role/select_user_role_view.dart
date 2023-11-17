import 'package:flutter/material.dart';
import 'package:simpa/constands/constands.dart';

class SelectUserRoleView extends StatefulWidget {
  const SelectUserRoleView({super.key});

  @override
  State<SelectUserRoleView> createState() => _SelectUserRoleViewState();
}

class _SelectUserRoleViewState extends State<SelectUserRoleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
         const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Are you a...?",
              style: primaryfont.copyWith(fontWeight: FontWeight.w500, fontSize: 26),
            ),
          )
        ],
      ),
    );
  }
}
