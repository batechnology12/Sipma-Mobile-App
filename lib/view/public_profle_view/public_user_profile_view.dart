
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/constands/message_types.dart';
import 'package:simpa/controllers/posts_controller.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/chat_models.dart';
import 'package:simpa/view/chat_view/view_message_screen.dart';
import 'package:simpa/view/login/login_view/loginpage.dart';
import 'package:simpa/view/post_view/post_view.dart';

class PublicUserProfilePage extends StatefulWidget {
  int userId;
  PublicUserProfilePage({super.key, required this.userId});

  @override
  State<PublicUserProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PublicUserProfilePage> {
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
          return SizedBox(
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
                          Get.to(const loginpage());
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
          return SizedBox(
            height: 162,
            child: Column(
              children: [
                const SizedBox(
                  height: 28,
                ),
                const Center(
                    child: Text(
                  "Do you want to Delete this post?",
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
                          Get.find<PostsController>()
                              .deletePost(postId: postId);
                        },
                        child: Text(
                          'Delete',
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

  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.getOtherProfile(userid: widget.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
        return SingleChildScrollView(
          child: profileController.otherUserProfileData.isEmpty
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Column(
                  children: [
                    Stack(children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 150,
                            width: size.width,
                            child: Row(
                              children: [
                                Container(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  color: kblue,
                                  child: profileController.otherUserProfileData
                                              .first.user.backgroundImage !=
                                          null
                                      ? Image.network(
                                          profileController.otherUserProfileData
                                              .first.user.backgroundImage,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/searchimage.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Color.fromARGB(
                                                255, 228, 227, 227))
                                      ],
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
                                                      fit: BoxFit.fill,
                                                    ),
                                            ),
                                ),
                                SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                            "assets/icons/silver_badge.png")))
                              ],
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

                      //           final croppedImage = await ImageCropper().cropImage(
                      //             sourcePath: timage!.path,
                      //             cropStyle: CropStyle.circle,
                      //             aspectRatioPresets: [
                      //               CropAspectRatioPreset.ratio5x4
                      //             ],
                      //             uiSettings: [
                      //               AndroidUiSettings(
                      //                   toolbarTitle: 'Cropper',
                      //                   toolbarColor: kblue,
                      //                   toolbarWidgetColor: Colors.white,
                      //                   initAspectRatio:
                      //                       CropAspectRatioPreset.ratio5x4,
                      //                   lockAspectRatio: false),
                      //               IOSUiSettings(
                      //                 title: 'Cropper',
                      //               ),
                      //               WebUiSettings(
                      //                 context: context,
                      //               ),
                      //             ],
                      //           );

                      //           if (croppedImage == null) return;

                      //           final croppedFile = File(croppedImage.path);

                      //           print(
                      //               "---------------------->->->->->->->_The file path after crope------>->->->->->->->${croppedFile.path}");

                      //           profileController.updateProfilePic(
                      //               media: File(croppedFile.path));
                      //         },
                      //         child: Container(
                      //           height: 24.5,
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
                    profileController.otherUserProfileData.isEmpty
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              profileController
                                          .profileData.first.departmentName ==
                                      "Others"
                                  ? Text(profileController.otherUserProfileData
                                              .first.user.otherDepartment ??
                                          "")
                                      .animate()
                                      .fade()
                                      .scale()
                                  : Text(profileController.otherUserProfileData
                                          .first.departmentName)
                                      .animate()
                                      .fade()
                                      .scale(),
                            ],
                          ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 15, left: 120, right: 135),
                    //   child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(18)),
                    //           backgroundColor: kblue,
                    //           minimumSize: Size(50, 40)),
                    //       onPressed: () {},
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset('assets/images/iconimage.png'),
                    //           const SizedBox(
                    //             width: 5,
                    //           ),
                    //           const Text(
                    //             'Request',
                    //             style: TextStyle(color: Colors.white),
                    //           )
                    //         ],
                    //       )),
                    // ),
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
                                  minimumSize: const Size(50, 40)),
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
                                  minimumSize: const Size(100, 35)),
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
                                            .profilePicture ??
                                        "",
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
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
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
                                  InkWell(
                                    onTap: () {
                                      // Get.offAll(() => BottomNavigationBarExample(
                                      //       index: 1,
                                      //     ));
                                    },
                                    child: Text(
                                      profileController.otherUserProfileData
                                          .first.totalFriends
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
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
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Get.offAll(() => BottomNavigationBarExample(
                                      //       index: 1,
                                      //     ));
                                    },
                                    child: const Text(
                                      'Connects',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  const Text(
                                    'Posters',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const Text(
                                    'Likes',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "About me",
                            style: primaryfont.copyWith(
                                color: const Color.fromARGB(214, 19, 18, 18),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          width: size.width,
                          alignment: Alignment.centerLeft,
                          child: ReadMoreText(
                            profileController
                                    .otherUserProfileData.first.user.bio ??
                                "",
                            trimLines: 2,
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'show more',
                            trimExpandedText: ' show less',
                            lessStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            moreStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "Current Company",
                            style: primaryfont.copyWith(
                                color: const Color.fromARGB(214, 19, 18, 18),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(profileController.otherUserProfileData.first
                                    .user.currentCompany ??
                                ""),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "Designation",
                            style: primaryfont.copyWith(
                                color: const Color.fromARGB(214, 19, 18, 18),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(profileController.otherUserProfileData.first
                                    .user.designation ??
                                ""),
                          ],
                        )),
                        const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 5),
                    child: Text(
                      "Education",
                      style: primaryfont.copyWith(
                          color: const Color.fromARGB(214, 19, 18, 18),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profileController
                              .otherUserProfileData.first.user.education ??
                          ""),
                    ],
                  )),

                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "Previous Company",
                            style: primaryfont.copyWith(
                                color: const Color.fromARGB(214, 19, 18, 18),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: SizedBox(
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i <
                                      profileController.otherUserProfileData
                                          .first.positions.length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profileController.otherUserProfileData
                                            .first.positions[i].companyName
                                            .toUpperCase(),
                                        style: primaryfont.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        profileController
                                                    .otherUserProfileData
                                                    .first
                                                    .positions[i]
                                                    .departmentName ==
                                                "Others"
                                            ? profileController
                                                .otherUserProfileData
                                                .first
                                                .positions[i]
                                                .otherDepartmentName
                                            : profileController
                                                .otherUserProfileData
                                                .first
                                                .positions[i]
                                                .departmentName,
                                        style: primaryfont.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${profileController.otherUserProfileData.first.positions[i].location}.",
                                        style: primaryfont.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${profileController.otherUserProfileData.first.positions[i].startDate} - ${profileController.otherUserProfileData.first.positions[i].endDate == "" ? "On going" : profileController.otherUserProfileData.first.positions[i].endDate} ",
                                        style: primaryfont.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${profileController.otherUserProfileData.first.positions[i].employmentType}.",
                                        style: primaryfont.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Divider(
                                        thickness: 0.5,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "Skills",
                            style: primaryfont.copyWith(
                                color: const Color.fromARGB(214, 19, 18, 18),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.only(left: 20, right: 10),
                    //     child: Container(
                    //       width: size.width,
                    //       child: GridView.builder(
                    //           shrinkWrap: true,
                    //           gridDelegate:
                    //               const SliverGridDelegateWithFixedCrossAxisCount(
                    //                   crossAxisCount: 2, childAspectRatio: 6),
                    //           itemCount: profileController
                    //               .otherUserProfileData.first.skills.length,
                    //           itemBuilder: (context, index) {
                    //             return Text(
                    //                 "${profileController.otherUserProfileData.first.skills[index].name},");
                    //           }),
                    //     )),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount:
                              profileController.profileData.first.skills.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 3, crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 3, left: 3, bottom: 5),
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    color: kblue.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(50)),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    profileController
                                        .profileData.first.skills[index].name,
                                    style: primaryfont.copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 25),
                      child: Row(
                        children: [
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
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: profileController
                                        .otherUserProfileData
                                        .first
                                        .posts
                                        .length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 15),
                                    itemBuilder: (context, index) {
                                      return profileController
                                                  .otherUserProfileData
                                                  .first
                                                  .posts[index]
                                                  .body ==
                                              ""
                                          ? InkWell(
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
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    profileController
                                                        .otherUserProfileData
                                                        .first
                                                        .posts[index]
                                                        .title,
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
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
                                                child: Image.network(
                                                    profileController
                                                        .otherUserProfileData
                                                        .first
                                                        .posts[index]
                                                        .body),
                                              ),
                                            );
                                    }),
                              )
                  ],
                ),
        );
      })),
    );
  }
}
