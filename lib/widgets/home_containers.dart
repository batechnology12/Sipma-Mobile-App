//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:simpa/view/coments.dart';

import '../constands/constands.dart';
import '../view/reactions_page.dart';
import 'like.dart';

class container extends StatelessWidget {
  const container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 479,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.grey.withOpacity(0.5)),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/img.jpg'),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Riyas',
                          style: ktextstyle22,
                        ),
                        const Text('Chennai').animate().fade().scale(),
                      ],
                    ),
                  ],
                ),
                const Text(
                  '2 hours ago',
                  style: TextStyle(fontSize: 10),
                ).animate().fade().scale(),
              ],
            ),
            ksizedbox10,
            const Text('Flutter is an open-source UI software development kit\ncreated by Google.It is used to develop cross-platform applications fLinux, macOS, Windows, Google\nFuchsia, web from a single')
                .animate()
                .fade()
                .scale(),
            ksizedbox10,
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/Opioids_New_Comp_Digital_1080x600px.jpg',
                fit: BoxFit.cover,
              ),
            ),
            ksizedbox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Get.to(reacton_screen(
                        likeCount: 0,
                        postId: 0,
                      ));
                    },
                    child: const Text('80k')),
                InkWell(
                    onTap: () {
                      Get.off(coments(
                        postId: 0,
                      ));
                    },
                    child: const Text(
                      '80k comments',
                    ))
              ],
            ),
            ksizedbox10,
            const Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  height: 1,
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                LikeButtonWidget(
                  likeCount: 11,
                  isliked: false,
                  postId: 0,
                  indexOfPost: 0,
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(coments(
                      postId: 0,
                    ));
                  },
                  child: kcomentbutton,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
