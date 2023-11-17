import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/constands/message_types.dart';
import 'package:simpa/controllers/posts_controller.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/chat_models.dart';
import 'package:simpa/view/chat_view/view_message_screen.dart';
import 'package:simpa/view/public_profle_view/public_profile_screen.dart';
import 'package:simpa/view/public_profle_view/public_user_profile_view.dart';
import 'package:simpa/view/search_page.dart';
import 'package:simpa/widgets/bottumnavigationbar.dart';
import 'package:simpa/widgets/home_containers.dart';
import 'package:simpa/widgets/search_field.dart';

//import '../widgets/appbar_friends.dart';
import '../widgets/coments_widget.dart';
import '../widgets/friend_request.dart';
import 'search_friends/search_friends_view.dart';

class Friends_screen extends StatefulWidget {
  Friends_screen({super.key});

  @override
  State<Friends_screen> createState() => _Friends_screenState();
}

class _Friends_screenState extends State<Friends_screen> {
  int index = 0;

  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getProfile();
    profileController.getMyFriendList();
    profileController.getMyFriendRequestList();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return GetBuilder<ProfileController>(builder: (_) {
      return DefaultTabController(
        length: 2,
        initialIndex: profileController.initialIndex.value,
        child: Scaffold(
          backgroundColor: kwhite,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(220),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Connects',
                    style: TextStyle(fontSize: 22),
                  ),
                  actions: [
                    GestureDetector(
                        onTap: () {
                          Get.to(SearchFriends());
                        },
                        child: ksearchblack),
                    kwidth10
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      GetBuilder<ProfileController>(builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your Connects',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            profileController.profileData.isNotEmpty
                                ? Text(
                                    '${profileController.profileData.first.totalFriends} Connects',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  )
                                : Container(),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                ksizedbox10,
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    height: 0,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                ksizedbox10,
                TabBar(
                    automaticIndicatorColorAdjustment: true,
                    //  isScrollable: true,
                    labelColor: kwhite,
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30), color: kblue),
                    onTap: (value) {
                      setState(() {
                        index = value;
                      });

                      if (index == 0) {
                        profileController.getMyFriendList();
                      } else {
                        profileController.getMyFriendRequestList();
                      }
                    },
                    tabs: [
                      Tab(
                        text: "Your Connects",
                      ),
                      // Tab(
                      //   text: "Friend Request",
                      // ),
                      Tab(
                        text: "Request",
                      )
                    ]),
              ],
            ),
          ),
          body: TabBarView(children: [
            GetBuilder<ProfileController>(builder: (_) {
              return profileController.myFriendList.isEmpty
                  ? const Center(
                      child: Text("No Connects"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: profileController.myFriendList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return profileController.myFriendList[index].status ==
                                "1"
                            ? GestureDetector(
                                onTap: () {
                                  // final myprofileController =
                                  //     Get.find<ProfileController>();
                                  // String tchatId = "";

                                  // if (profileController
                                  //         .myFriendList[index].friendId >
                                  //     myprofileController
                                  //         .profileData.first.user.id) {
                                  //   tchatId =
                                  //       "chatId${profileController.myFriendList[index].friendId}0${myprofileController.profileData.first.user.id}";
                                  // } else {
                                  //   tchatId =
                                  //       "chatId${myprofileController.profileData.first.user.id}0${profileController.myFriendList[index].friendId}";
                                  // }
                                  // ChatListModel chatListModel = ChatListModel(
                                  //     userId: profileController
                                  //         .myFriendList[index].friendId,
                                  //     firstName: profileController
                                  //         .myFriendList[index].name,
                                  //     lastName: "",
                                  //     photo: profileController
                                  //         .myFriendList[index].profile,
                                  //     pin: 0,
                                  //     isArchived: false,
                                  //     isBlocked: false,
                                  //     isMuted: false,
                                  //     userName: "",
                                  //     chatId: tchatId,
                                  //     message: "",
                                  //     messageType: MessageType().text,
                                  //     unreadCount: 1,
                                  //     readStatus: false,
                                  //     createdAt: DateTime.now()
                                  //         .millisecondsSinceEpoch
                                  //         .toString(),
                                  //     updatedAt: DateTime.now()
                                  //         .millisecondsSinceEpoch
                                  //         .toString(),
                                  //     users: [
                                  //       myprofileController
                                  //           .profileData.first.user.id
                                  //     ]);

                                  // Get.to(() => ViewMessageScreen(
                                  //       chatModel: chatListModel,
                                  //       peerId: profileController
                                  //           .myFriendList[index].friendId,
                                  //     ));

                                  Get.to(() => PublicUserProfilePage(
                                        userId: profileController
                                            .myFriendList[index].friendId,
                                      ));
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: profileController
                                                    .myFriendList[index]
                                                    .profile ==
                                                null ||
                                            profileController
                                                    .myFriendList[index]
                                                    .profile ==
                                                ""
                                        ? const CircleAvatar(
                                            radius: 40,
                                            backgroundImage: AssetImage(
                                                'assets/icons/profil_img.jpeg'),
                                          )
                                        : CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                profileController
                                                    .myFriendList[index]
                                                    .profile),
                                          ),
                                    title: Text(profileController
                                            .myFriendList[index].name)
                                        .animate()
                                        .fade()
                                        .scale(),
                                    subtitle: Text(profileController
                                            .myFriendList[index].designation)
                                        .animate()
                                        .fade()
                                        .scale(),
                                  ),
                                ),
                              )
                            : Container();
                      },
                    );
            }),
            // Center(
            //   child: friendrequest(
            //     text1: 'Add Friend',
            //     text2: 'Delete',
            //   ),
            // ),
            GetBuilder<ProfileController>(builder: (_) {
              return profileController.friendRequestList.isEmpty
                  ? const Center(
                      child: Text("No Requests"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: profileController.friendRequestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    profileController.friendRequestList[index]
                                                    .profile ==
                                                null ||
                                            profileController
                                                    .friendRequestList[index]
                                                    .profile ==
                                                ""
                                        ? Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: CircleAvatar(
                                              radius: 35.w,
                                              backgroundImage: const AssetImage(
                                                  'assets/icons/profil_img.jpeg'),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: CircleAvatar(
                                              radius: 35.w,
                                              backgroundImage: NetworkImage(
                                                  profileController
                                                      .friendRequestList[index]
                                                      .profile),
                                            ),
                                          ),
                                    Container(
                                      width: 110.h,
                                      height: 50,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            profileController
                                                .friendRequestList[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ).animate().fade().scale(),
                                          Text(
                                            profileController
                                                .friendRequestList[index]
                                                .designation,
                                            overflow: TextOverflow.ellipsis,
                                          ).animate().fade().scale(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print(
                                            "---------------------->>on request");
                                        profileController.respondRequest(
                                            userId: profileController
                                                .friendRequestList[index]
                                                .friendId
                                                .toString(),
                                            status: "1");
                                      },
                                      child: Container(
                                        child: Center(
                                            child: Text(
                                          "Accept",
                                          style: TextStyle(
                                              color: kwhite,
                                              fontWeight: FontWeight.w600),
                                        )),
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(17),
                                            color: kblue),
                                      ),
                                    ),
                                    kwidth10,
                                    ksizedbox10,
                                    InkWell(
                                      onTap: () {
                                        profileController.respondRequest(
                                            userId: profileController
                                                .friendRequestList[index]
                                                .friendId
                                                .toString(),
                                            status: "2");
                                      },
                                      child: Container(
                                        child: Center(
                                            child: Text(
                                          "Remove",
                                          style: TextStyle(
                                              color: kblue,
                                              fontWeight: FontWeight.w600),
                                        )),
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kblue, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(17),
                                            color: kwhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            })
          ]),
        ),
      );
    });
  }
}
