import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/chat_controller.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/view/chat_view/chat_list_view.dart';
import 'package:simpa/view/home_page.dart';
import 'package:simpa/view/profile_page.dart';

import '../view/friends.dart';
import '../view/notification_screen.dart';

class BottomNavigationBarExample extends StatefulWidget {
  int index;
  BottomNavigationBarExample({this.index = 0});
  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _currentIndex = 0;

  //controllers

  final profileController = Get.find<ProfileController>();
  final chatController = Get.find<ChatController>();

  // List of pages to be displayed in the bottom navigation bar
  final List<Widget> _pages = [
    Homepage(), // Replace with your own widget
    Friends_screen(),
    ChatListView(),
    Notificaton_screen(),
    ProfilePage(), // Replace with your own widget
  ];

  @override
  void initState() {
    super.initState();
    setValues();
    profileController.getProfile();
    profileController.getNotificationList();
  }

  setValues() {
    setState(() {
      _currentIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          fixedColor: kblue,
          // unselectedLabelStyle: TextStyle(color: kgrey),
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('assets/images/home.svg'),
              icon: SvgPicture.asset('assets/images/a.svg'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon:
                  SvgPicture.asset('assets/images/friends_selected.svg'),
              icon: SvgPicture.asset('assets/images/frinds_unselected.svg'),
              label: 'Connects',
            ),
            BottomNavigationBarItem(
              activeIcon: GetBuilder<ProfileController>(builder: (_) {
                return profileController.profileData.isEmpty
                    ? Icon(
                        Icons.chat_bubble_rounded,
                        color: kblue.withOpacity(0.5),
                      )
                    : StreamBuilder<QuerySnapshot>(
                        stream: Get.find<ChatController>().getUnreadCound(
                            profileController.profileData.first.user.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Icon(
                              Icons.chat_bubble_rounded,
                              color: kblue.withOpacity(0.5),
                            );
                          } else if (snapshot.data == null) {
                            return Icon(
                              Icons.chat_bubble_rounded,
                              color: kblue.withOpacity(0.5),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Icon(
                              Icons.chat_bubble_rounded,
                              color: kblue.withOpacity(0.5),
                            );
                          } else {
                            return Stack(
                              children: [
                                Icon(
                                  Icons.chat_bubble_rounded,
                                  color: kblue.withOpacity(0.5),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data!.docs.length > 9
                                          ? "+9"
                                          : "${snapshot.data!.docs.length}",
                                      style: primaryfont.copyWith(
                                          color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        });
              }),
              icon: GetBuilder<ProfileController>(builder: (_) {
                return profileController.profileData.isEmpty
                    ? Icon(
                        Icons.chat_bubble_rounded,
                        color: kblue.withOpacity(0.5),
                      )
                    : StreamBuilder<QuerySnapshot>(
                        stream: Get.find<ChatController>().getUnreadCound(
                            profileController.profileData.first.user.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Icon(
                              Icons.chat_bubble_rounded,
                              color: kblue.withOpacity(0.5),
                            );
                          } else if (snapshot.data == null) {
                            return Icon(
                              Icons.chat_bubble_rounded,
                              color: kblue.withOpacity(0.5),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Icon(
                              Icons.chat_bubble_rounded,
                              color: kblue.withOpacity(0.5),
                            );
                          } else {
                            return Stack(
                              children: [
                                Icon(
                                  Icons.chat_bubble_rounded,
                                  color: kblue.withOpacity(0.5),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data!.docs.length > 9
                                          ? "+9"
                                          : "${snapshot.data!.docs.length}",
                                      style: primaryfont.copyWith(
                                          color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        });
              }),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              activeIcon: GetBuilder<ProfileController>(builder: (_) {
                return Stack(
                  children: [
                    SvgPicture.asset('assets/images/notification_selected.svg'),
                    if (profileController.notificationCount.value != 0)
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text(
                            profileController.notificationCount.value > 9
                                ? "+9"
                                : "${profileController.notificationCount.value}",
                            style: primaryfont.copyWith(
                                color: Colors.white, fontSize: 8),
                          ),
                        ),
                      )
                  ],
                );
              }),
              icon: GetBuilder<ProfileController>(builder: (_) {
                return Stack(
                  children: [
                    SvgPicture.asset(
                        'assets/images/notification_unselected.svg'),
                    if (profileController.notificationCount.value != 0)
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text(
                            profileController.notificationCount.value > 9
                                ? "+9"
                                : "${profileController.notificationCount.value}",
                            style: primaryfont.copyWith(
                                color: Colors.white, fontSize: 8),
                          ),
                        ),
                      )
                  ],
                );
              }),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              activeIcon:
                  SvgPicture.asset('assets/images/profilecircle_selected.svg'),
              icon: SvgPicture.asset('assets/images/profilecircle_unslct.svg'),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  //exit popup

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit ?"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(
                              textStyle:
                                  primaryfont.copyWith(color: Colors.white),
                              primary: Colors.red.shade800),
                          child: Text(
                            "Yes",
                            style: primaryfont.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

// Replace these PageOne, PageTwo, PageThree widgets with your own widgets
class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page One').animate().fade().scale(),
    );
  }
}

// class Pagefour extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Page four')
//     );
//   }
// }
