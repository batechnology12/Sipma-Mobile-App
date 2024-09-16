import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:simpa/constands/constands.dart';

class friendrequest extends StatelessWidget {
  const friendrequest({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            child: Stack(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/img.jpg'),
                  ),
                  title: const Text("Riyas").animate().fade().scale(),
                  subtitle: const Text("HR Communityy").animate().fade().scale(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: kblue),
                      child: Center(
                          child: Text(
                        text1,
                        style: TextStyle(
                            color: kwhite, fontWeight: FontWeight.w600),
                      )),
                    ),kwidth10,
                    ksizedbox10,
                    Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: kblue, width: 1),
                          borderRadius: BorderRadius.circular(17),
                          color: kwhite),
                      child: Center(
                          child: Text(
                        text2,
                        style: TextStyle(
                            color: kblue, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
