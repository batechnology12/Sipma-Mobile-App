import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/constands/message_types.dart';
import 'package:simpa/controllers/posts_controller.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/chat_models.dart';
import 'package:simpa/view/change_password.dart';
import 'package:simpa/view/chat_view/view_message_screen.dart';
import 'package:simpa/view/login/login_view/loginpage.dart';
import 'package:simpa/view/post_view/post_view.dart';
import 'package:simpa/view/setting_privacy.dart';
import 'package:simpa/view/setting_proifile_page.dart';
import 'package:simpa/view/setting_term_condition.dart';

class PublicProfilePageView extends StatefulWidget {
  int userId;
  PublicProfilePageView({super.key, required this.userId});

  @override
  State<PublicProfilePageView> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PublicProfilePageView> {
  List postimage = [
    'assets/images/searchimage.png',
    'assets/images/searchimage.png',
    'assets/images/searchimage.png',
    'assets/images/searchimage.png',
    'assets/images/searchimage.png',
    'assets/images/searchimage.png'
  ];
  void _showModalSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        context: context,
        builder: (builder) {
          return Container(
            height: 162,
            child: Column(
              children: [
                const SizedBox(
                  height: 28,
                ),
                const Center(
                    child: Text(
                  "Do you want to Logout?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 40),
                            backgroundColor: kblue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await FirebaseMessaging.instance.deleteToken();
                          await prefs.setString("auth_token", "null");
                          Get.to(loginpage());
                        },
                        child: Text(
                          'Log Out',
                          style: TextStyle(fontSize: 15, color: kwhite),
                        )),
                    const SizedBox(
                      width: 40,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: kblue, width: 1),
                            minimumSize: const Size(110, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 15, color: kblue),
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }

  void _showDeletePostOptions(String postId) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        context: context,
        builder: (builder) {
          return new Container(
            height: 162,
            child: Column(
              children: [
                SizedBox(
                  height: 28,
                ),
                Center(
                    child: Text(
                  "Do you want to Delete this post?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 40),
                            backgroundColor: kblue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        onPressed: () async {
                          Get.find<PostsController>()
                              .deletePost(postId: postId);
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 15, color: kwhite),
                        )),
                    SizedBox(
                      width: 40,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: kblue, width: 1),
                            minimumSize: Size(110, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 15, color: kblue),
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }

  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.getOtherProfile(userid: widget.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(child: GetBuilder<ProfileController>(builder: (_) {
        return profileController.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Stack(children: [
                      Container(
                        height: 112,
                        width: MediaQuery.of(context).size.width,
                        color: kblue,
                        child: Image.asset(
                          'assets/images/searchimage.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: profileController.isLoading.isTrue
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : profileController
                                          .otherUserProfileData.isEmpty
                                      ? Container()
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: profileController
                                                      .otherUserProfileData
                                                      .first
                                                      .user
                                                      .profilePicture ==
                                                  null
                                              ? Image.asset(
                                                  "assets/icons/profil_img.jpeg",
                                                )
                                              : Image.network(
                                                  profileController
                                                      .otherUserProfileData
                                                      .first
                                                      .user
                                                      .profilePicture,
                                                ),
                                        ),
                            ),
                          ),
                        ],
                      ),
                      // Positioned(
                      //     top: 168,
                      //     left: 50,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 155, top: 8),
                      //       child: InkWell(
                      //         onTap: () async {
                      //           final ImagePicker _picker = ImagePicker();
                      //           // Pick an image
                      //           final XFile? timage = await _picker.pickImage(
                      //               source: ImageSource.gallery);

                      //           profileController.updateProfilePic(
                      //               media: File(timage!.path));
                      //         },
                      //         child: Container(
                      //           height: 26.5,
                      //           child: const CircleAvatar(
                      //               radius: 30,
                      //               backgroundImage:
                      //                   AssetImage('assets/images/profileicon.png'),
                      //               backgroundColor: Colors.grey,
                      //               child: Icon(Icons.add)),
                      //         ),
                      //       ),
                      //     ))
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 2),
                      child: profileController.otherUserProfileData.isEmpty
                          ? Container()
                          : Text(
                              '${profileController.otherUserProfileData.first.user.name} ${profileController.otherUserProfileData.first.user.lastName}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ).animate().fade().scale(),
                    ),
                    // profileController.otherUserProfileData.isEmpty
                    //     ? Container()
                    //     : Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(profileController.otherUserProfileData.first
                    //                       .user.designation ??
                    //                   "")
                    //               .animate()
                    //               .fade()
                    //               .scale(),
                    //         ],
                    //       ),
                    if (profileController.otherUserProfileData.first.isFriend ==
                        0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  backgroundColor: kblue,
                                  minimumSize: Size(50, 40)),
                              onPressed: () async {
                                bool isRequested = await profileController
                                    .sendRequestFromProfile(
                                        userId: widget.userId.toString());

                                if (isRequested) {
                                  profileController
                                      .otherUserProfileData.first.isFriend = 2;
                                  profileController.update();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/iconimage.png'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Request',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ],
                      ),
                    if (profileController.otherUserProfileData.first.isFriend ==
                        1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  backgroundColor: kblue,
                                  minimumSize: Size(50, 40)),
                              onPressed: () {
                                final myprofileController =
                                    Get.find<ProfileController>();
                                String tchatId = "";

                                if (profileController
                                        .otherUserProfileData.first.user.id >
                                    myprofileController
                                        .profileData.first.user.id) {
                                  tchatId =
                                      "chatId${profileController.otherUserProfileData.first.user.id}0${myprofileController.profileData.first.user.id}";
                                } else {
                                  tchatId =
                                      "chatId${myprofileController.profileData.first.user.id}0${profileController.otherUserProfileData.first.user.id}";
                                }
                                ChatListModel chatListModel = ChatListModel(
                                    userId: profileController
                                        .otherUserProfileData.first.user.id,
                                    firstName: profileController
                                        .otherUserProfileData.first.user.name,
                                    lastName: "",
                                    photo: profileController
                                        .otherUserProfileData
                                        .first
                                        .user
                                        .profilePicture,
                                    pin: 0,
                                    isArchived: false,
                                    isBlocked: false,
                                    isMuted: false,
                                    userName: "",
                                    chatId: tchatId,
                                    message: "",
                                    messageType: MessageType().text,
                                    unreadCount: 1,
                                    readStatus: false,
                                    createdAt: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    updatedAt: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    users: [
                                      myprofileController
                                          .profileData.first.user.id
                                    ]);

                                Get.to(() => ViewMessageScreen(
                                      chatModel: chatListModel,
                                      peerId: widget.userId,
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Chat',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    profileController.otherUserProfileData.isEmpty
                        ? Container()
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    profileController
                                        .otherUserProfileData.first.totalFriends
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    profileController
                                        .otherUserProfileData.first.totalPosts
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    profileController
                                        .otherUserProfileData.first.totalLikes
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    'Connects',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'Posters',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'Likes',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 25),
                      child: Row(
                        children: const [
                          Text(
                            'Post',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    profileController.otherUserProfileData.isEmpty
                        ? Container()
                        : profileController
                                .otherUserProfileData.first.posts.isEmpty
                            ? Center(
                                child: Image.asset("assets/icons/no_post.png"),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount: profileController
                                    .otherUserProfileData.first.posts.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => PostView(
                                          isOtherProfile: true,
                                          postData: profileController
                                              .otherUserProfileData
                                              .first
                                              .posts[index]));
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Image.network(profileController
                                          .otherUserProfileData
                                          .first
                                          .posts[index]
                                          .body),
                                    ),
                                  );
                                })
                  ],
                ),
              );
      })),
    );
  }
}
