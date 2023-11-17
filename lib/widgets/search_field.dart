import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/constands/constands.dart';

import '../constands/constands.dart';

class search extends StatelessWidget {
  TextEditingController textController;
  search({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color:
                      const Color.fromARGB(255, 216, 216, 216).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 5))
            ]),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset('assets/images/Vector.svg'),
            // Image(image: kimgsearch),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                  controller: textController,
                  decoration: InputDecoration.collapsed(hintText: "Search")),
            ),
          ],
        ),
      ),
    );
  }
}
