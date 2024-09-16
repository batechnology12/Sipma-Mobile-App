import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/controllers/posts_controller.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/view/alert_box/widgets/textfield.dart';
import 'package:simpa/view/coments.dart';
import 'package:simpa/view/create.dart';
import 'package:simpa/view/public_profle_view/public_user_profile_view.dart';
import 'package:simpa/view/reactions_page.dart';
import 'package:simpa/widgets/like.dart';
import '../constands/constands.dart';
import '../widgets/bottumnavigationbar.dart';
import 'package:timeago/timeago.dart' as timeago;

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final postsController = Get.find<PostsController>();
  final authController = Get.find<AuthController>();
  final profileController = Get.find<ProfileController>();

  var designation;
  var industries;
  var selectedCity;
  var selectedState;
  var stateSelected;
  var citySelected;
  var requiremtsSelected;
  var education;

  List<String> educationList = [
    "10th",
    "12th",
    "PUC",
    "UG",
    "PG",
    "Certificates / Others"
  ];

  var edHintText = "Education";
  bool isEdSelected = false;

  @override
  void initState() {
    super.initState();
    getValues();
    authController.getStateList();
    userTypeUpdate();
    //educationPopup();
  }

  educationPopup() async {
    await profileController.getEducationalSkillsApi();
    if (profileController.educationskillsData.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 50));
      _educationPopup();
    }
  }

  userTypeUpdate() async {
    await profileController.getProfile();
    if (profileController.profileData.isNotEmpty) {
      if (profileController.profileData.first.user.userType == "null") {
        await Future.delayed(const Duration(milliseconds: 50));
        _usertypPopup();
      } else {
        educationPopup();
      }
    }
  }

  // saveToken() async {
  //     var token = await FirebaseMessaging.instance.getToken();
  //     authController.fcmtoken(token: token.toString(), id: profileController.profileData.first.user.id.toString());
  //     print("............firebase token.......=====================>>>");
  //     print(token);
  // }

  getValues() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      postsController.getAllPost();
      profileController.getNotificationList();
      await postsController.getProfile();
    });
  }

  var reporingTextController = TextEditingController();

  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  String selectdt =
      formatDate(DateTime.now().subtract(const Duration(days: 0)), [
    yyyy,
    "-",
    mm,
    "-",
    dd,
  ]);

  String selectdt1 = formatDate(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      [yyyy, "-", mm, "-", dd]);

  _showStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
        builder: ((context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: kblue,
                onPrimary: Colors.white,
                onSurface: Colors.blue,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 42, 59, 158),
                ),
              ),
            ),
            child: child!,
          );
        }));

    if (picked != null) {
      setState(() {
        authController.date1 = picked;
        selectdt =
            formatDate(authController.date1.subtract(const Duration(days: 0)), [
          yyyy,
          "-",
          mm,
          "-",
          dd,
        ]);
      });
      authController.update();
    }
  }

  _showEndDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
        builder: ((context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: kblue,
                onPrimary: Colors.white,
                onSurface: Colors.blue,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 42, 59, 158),
                ),
              ),
            ),
            child: child!,
          );
        }));

    if (picked != null) {
      setState(() {
        authController.date = picked;
        selectdt1 =
            formatDate(authController.date.add(const Duration(days: 0)), [
          yyyy,
          "-",
          mm,
          "-",
          dd,
        ]);
      });
    }
    authController.update();
  }

  var institutenameController = TextEditingController();
  var certificateController = TextEditingController();
  var cCityController = TextEditingController();
  var cStateController = TextEditingController();
  var cDurationController = TextEditingController();
  var cCourseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.6],
              colors: [kblue, Colors.white])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: GetBuilder<PostsController>(
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postsController.profileData.isEmpty
                        ? ""
                        : postsController.profileData.first.name,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text(
                    postsController.profileData.isEmpty
                        ? ""
                        : '${postsController.profileData.first.designation ?? ""}',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ],
              );
            },
          ),
          //  toolbarHeight: 55,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GetBuilder<PostsController>(builder: (_) {
            return InkWell(
              onTap: () {
                Get.offAll(() => BottomNavigationBarExample(
                      index: 4,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 7, top: 5),
                child: postsController.profileData.isEmpty
                    ? Container()
                    : postsController.profileData.first.profilePicture == null
                        ? const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/icons/profil_img.jpeg'),
                            radius: 40,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(postsController
                                .profileData.first.profilePicture),
                            radius: 40,
                          ),
              ),
            );
          }),
          // title: const Image(
          //     height: 50, image: AssetImage("assets/images/title.jpg")),
          // centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: Row(
                children: [
                  // GestureDetector(
                  //     onTap: () {
                  //       //Get.to(const SearchPage());

                  //     },
                  //     child: ksearch),
                  const SizedBox(
                    width: 17,
                  ),
                  // GestureDetector(
                  //     onTap: () {
                  //       _showDialog();
                  //       //    Get.to(const FilterPage());
                  //     },
                  //     child:const Icon(Icons.format_list_bulleted_add,color: Colors.white,)),
                  const SizedBox(
                    width: 17,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(const createpost());
                      },
                      child: kimgadd),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GetBuilder<PostsController>(builder: (_) {
            print(
                "<<<<<<--------_______________getting re builded_______________----------->>>>>>>");
            return postsController.isLoading.isTrue
                ? Center(
                    child: CircularProgressIndicator(
                      color: kblue,
                    ),
                  )
                : postsController.allPostList.isEmpty
                    ? Center(
                        child: Image.asset("assets/icons/no_post.png"),
                      )
                    : RefreshIndicator(
                        onRefresh: () {
                          return postsController.getAllPost();
                        },
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: postsController.allPostList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                postsController
                                                            .allPostList[index]
                                                            .user
                                                            .profilePicture ==
                                                        null
                                                    ? InkWell(
                                                        onTap: () {
                                                          if (postsController
                                                                  .allPostList[
                                                                      index]
                                                                  .user
                                                                  .id ==
                                                              profileController
                                                                  .profileData
                                                                  .first
                                                                  .user
                                                                  .id) {
                                                            Get.offAll(() =>
                                                                BottomNavigationBarExample(
                                                                  index: 4,
                                                                ));
                                                          } else {
                                                            Get.to(() =>
                                                                PublicUserProfilePage(
                                                                  userId: postsController
                                                                      .allPostList[
                                                                          index]
                                                                      .user
                                                                      .id,
                                                                ));
                                                          }
                                                        },
                                                        child:
                                                            const CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/icons/profil_img.jpeg'),
                                                          radius: 25,
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          if (postsController
                                                                  .allPostList[
                                                                      index]
                                                                  .user
                                                                  .id ==
                                                              profileController
                                                                  .profileData
                                                                  .first
                                                                  .user
                                                                  .id) {
                                                            Get.offAll(() =>
                                                                BottomNavigationBarExample(
                                                                  index: 4,
                                                                ));
                                                          } else {
                                                            Get.to(() =>
                                                                PublicUserProfilePage(
                                                                  userId: postsController
                                                                      .allPostList[
                                                                          index]
                                                                      .user
                                                                      .id,
                                                                ));
                                                          }
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundImage: NetworkImage(
                                                              postsController
                                                                  .allPostList[
                                                                      index]
                                                                  .user
                                                                  .profilePicture),
                                                        ),
                                                      ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        if (postsController
                                                                .allPostList[
                                                                    index]
                                                                .user
                                                                .id ==
                                                            profileController
                                                                .profileData
                                                                .first
                                                                .user
                                                                .id) {
                                                          Get.offAll(() =>
                                                              BottomNavigationBarExample(
                                                                index: 4,
                                                              ));
                                                        } else {
                                                          Get.to(() =>
                                                              PublicUserProfilePage(
                                                                userId: postsController
                                                                    .allPostList[
                                                                        index]
                                                                    .user
                                                                    .id,
                                                              ));
                                                        }
                                                      },
                                                      child: Text(
                                                        postsController
                                                            .allPostList[index]
                                                            .user
                                                            .name,
                                                        style: ktextstyle22,
                                                      ),
                                                    ),
                                                    Text(postsController
                                                                .allPostList[
                                                                    index]
                                                                .user
                                                                .designation ??
                                                            postsController
                                                                .allPostList[
                                                                    index]
                                                                .user
                                                                .userName)
                                                        .animate()
                                                        .fade()
                                                        .scale(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  timeago.format(postsController
                                                      .allPostList[index]
                                                      .createdAt),
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                ).animate().fade().scale(),
                                                if (postsController
                                                        .allPostList[index]
                                                        .user
                                                        .id !=
                                                    profileController
                                                        .profileData
                                                        .first
                                                        .user
                                                        .id)
                                                  InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                            ),
                                                            context: context,
                                                            builder: (context) {
                                                              return Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <Widget>[
                                                                  Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(50),
                                                                        topRight:
                                                                            Radius.circular(50),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 20,
                                                                              top: 6),
                                                                          child:
                                                                              Text(
                                                                            'Post Settings',
                                                                            style:
                                                                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  ListTile(
                                                                    leading:
                                                                        const Icon(
                                                                            Icons.report),
                                                                    title:
                                                                        const Text(
                                                                      'Report',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    onTap: () {
                                                                      Get.back();
                                                                      reporingTextController
                                                                          .clear();
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return AlertDialog(
                                                                              title: const Text("Why are you reporting this post?"),
                                                                              content: TextField(
                                                                                controller: reporingTextController,
                                                                                onChanged: (value) {},
                                                                                // controller: _textFieldController,
                                                                                decoration: const InputDecoration(hintText: "Irrelevant or annoying"),
                                                                              ),
                                                                              actions: [
                                                                                TextButton(
                                                                                    onPressed: () {
                                                                                      if (reporingTextController.text.isNotEmpty) {
                                                                                        Get.back();
                                                                                        postsController.reportAPost(userId: postsController.profileData.first.id.toString(), postId: postsController.allPostList[index].id.toString(), comment: reporingTextController.text);
                                                                                      }
                                                                                    },
                                                                                    child: Text(
                                                                                      "Submit",
                                                                                      style: primaryfont.copyWith(color: Colors.blue),
                                                                                    ))
                                                                              ],
                                                                            );
                                                                          });
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      child: const Icon(Icons
                                                          .more_vert_rounded))
                                              ],
                                            ),
                                          ],
                                        ),
                                        ksizedbox10,
                                        // Text(postsController.allPostList[index].title)
                                        //     .animate()
                                        //     .fade()
                                        //     .scale(),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        ReadMoreText(
                                          postsController
                                              .allPostList[index].title,
                                          trimLines: 2,
                                          colorClickableText: Colors.black,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'show more',
                                          trimExpandedText: ' show less',
                                          lessStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          moreStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // Text(postsController
                                        //         .allPostList[index].title)
                                        //     .animate()
                                        //     .fade()
                                        //     .scale(),
                                        ksizedbox10,
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: postsController
                                                      .allPostList[index]
                                                      .body ==
                                                  ""
                                              ? Container(
                                                  height: 6,
                                                )
                                              : Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: postsController
                                                        .allPostList[index].body
                                                        .toString(),
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CupertinoActivityIndicator(),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Image(
                                                            image: AssetImage(
                                                                "assets/images/noimage.jpg")),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                        ksizedbox10,
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              postsController.allPostList[index]
                                                          .likeCount ==
                                                      0
                                                  ? Container(
                                                      width: 5,
                                                    )
                                                  : postsController
                                                              .allPostList[
                                                                  index]
                                                              .likeCount ==
                                                          1
                                                      ? InkWell(
                                                          onTap: () {
                                                            Get.to(
                                                              reacton_screen(
                                                                likeCount: postsController
                                                                    .allPostList[
                                                                        index]
                                                                    .likeCount,
                                                                postId: postsController
                                                                    .allPostList[
                                                                        index]
                                                                    .id,
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                              "${postsController.allPostList[index].likeCount.toString()} Likes"))
                                                      : InkWell(
                                                          onTap: () {
                                                            Get.to(
                                                                reacton_screen(
                                                              likeCount:
                                                                  postsController
                                                                      .allPostList[
                                                                          index]
                                                                      .likeCount,
                                                              postId:
                                                                  postsController
                                                                      .allPostList[
                                                                          index]
                                                                      .id,
                                                            ));
                                                          },
                                                          child: FutureBuilder(
                                                            future: postsController
                                                                .getLikedNames(
                                                                    postId: postsController
                                                                        .allPostList[
                                                                            index]
                                                                        .id
                                                                        .toString()),
                                                            builder: (context,
                                                                snapshot) {
                                                              // if (snapshot
                                                              //         .connectionState ==
                                                              //     ConnectionState
                                                              //         .waiting) {
                                                              //   return const Text(
                                                              //       "...");
                                                              // }
                                                              return Text(
                                                                "${snapshot.data ?? ""} and other ${(postsController.allPostList[index].likeCount - 1).toString()} Likes",
                                                                style: primaryfont
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(coments(
                                                    postId: postsController
                                                        .allPostList[index].id,
                                                  ));
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      postsController
                                                                  .allPostList[
                                                                      index]
                                                                  .comment >=
                                                              1000
                                                          ? '${(postsController.allPostList[index].comment / 1000.0).toStringAsFixed(1)}k'
                                                          : postsController
                                                              .allPostList[
                                                                  index]
                                                              .comment
                                                              .toString(),
                                                    ),
                                                    const Text(" Comments")
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
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

                                        Row(
                                          children: [
                                            LikeButtonWidget(
                                              isliked: postsController
                                                  .allPostList[index]
                                                  .likedByUser,
                                              postId: postsController
                                                  .allPostList[index].id,
                                              indexOfPost: index,
                                              likeCount: postsController
                                                  .allPostList[index].likeCount,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                postsController.commentsList
                                                    .clear();
                                                postsController.update();
                                                Get.to(coments(
                                                  postId: postsController
                                                      .allPostList[index].id,
                                                ));
                                              },
                                              child: kcomentbutton,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                postsController.commentsList
                                                    .clear();
                                                postsController.update();
                                                Get.to(coments(
                                                  postId: postsController
                                                      .allPostList[index].id,
                                                ));
                                              },
                                              child: ksharebutton,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
          }),
        ),
      ),
    );
  }

  var schoolController = TextEditingController();
  var standardsController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var startdateController = TextEditingController();
  var enddateController = TextEditingController();

  var univercitynameController = TextEditingController();
  var collageugController = TextEditingController();
  var ugcityController = TextEditingController();
  var stateugController = TextEditingController();
  var specialiseddegreeController = TextEditingController();
  var starttdateugController = TextEditingController();
  var enddateugController = TextEditingController();

  var univercitynamepgController = TextEditingController();
  var collagepgController = TextEditingController();
  var pgcityController = TextEditingController();
  var statepgController = TextEditingController();
  var pgspecialiseddegreeController = TextEditingController();
  var starttdatepgController = TextEditingController();
  var enddatepgController = TextEditingController();
  var courseController = TextEditingController();
  var durationController = TextEditingController();

  _educationPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(18.0), // Adjust the radius as needed
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Fill Your Education Details'),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red[500],
                    ))
              ],
            ),
            content: const Text(
                'Choose your education and update the required details.'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Column(
                  children: [
                    //  ksizedbox10,
                    SizedBox(
                      height: 56,
                      child: DropdownSearch<String>(
                        itemAsString: (String u) => u,
                        popupProps: PopupProps.menu(
                          showSelectedItems: false,
                          showSearchBox: true,
                          menuProps: MenuProps(
                              borderRadius: BorderRadius.circular(10)),
                          searchFieldProps: const TextFieldProps(),
                        ),
                        items: educationList,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              // labelText: "Department *",
                              hintText: "Select education",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        onChanged: (value) {
                          setState(() {
                            profileController.educationlist(value);
                            standardsController.text = value.toString();
                          });
                        },
                        // selectedItem: selectedState,
                      ),
                    ),
                    if (profileController.educationlist.value == "10th" ||
                        profileController.educationlist.value == "12th")
                      ksizedbox10,
                    if (profileController.educationlist.value == "10th" ||
                        profileController.educationlist.value == "12th")
                      TextFormFieldWidget(
                        labeltext: 'School name',
                        controller: schoolController,
                      ),
                    if (profileController.educationlist.value == "UG" ||
                        profileController.educationlist.value == "PG" ||
                        profileController.educationlist.value == "PUC")
                      ksizedbox10,
                    if (profileController.educationlist.value == "UG" ||
                        profileController.educationlist.value == "PG" ||
                        profileController.educationlist.value == "PUC")
                      TextFormFieldWidget(
                        controller: schoolController,
                        labeltext: 'University name',
                      ),
                    if (profileController.educationlist.value == "UG" ||
                        profileController.educationlist.value == "PG")
                      ksizedbox10,
                    if (profileController.educationlist.value == "UG" ||
                        profileController.educationlist.value == "PG")
                      TextFormFieldWidget(
                        controller: collagepgController,
                        labeltext: 'College',
                      ),
                    if (profileController.educationlist.value ==
                        "Certificates / Others")
                      ksizedbox10,
                    if (profileController.educationlist.value ==
                        "Certificates / Others")
                      TextFormFieldWidget(
                        controller: schoolController,
                        labeltext: 'Institution Name',
                      ),
                    if (profileController.educationlist.value ==
                        "Certificates / Others")
                      ksizedbox10,
                    if (profileController.educationlist.value ==
                        "Certificates / Others")
                      TextFormFieldWidget(
                        controller: courseController,
                        labeltext: 'Course Name',
                      ),
                    if (profileController.educationlist.value ==
                        "Certificates / Others")
                      ksizedbox10,
                    if (profileController.educationlist.value ==
                        "Certificates / Others")
                      TextFormFieldWidget(
                        controller: durationController,
                        labeltext: 'Duration',
                      ),
                    if (profileController.educationlist.value ==
                        "Certificates / Others")
                      ksizedbox10,
                    if (profileController.educationlist.value ==
                        "Certificates / Others")
                      TextFormFieldWidget(
                        labeltext: 'Course / Certificate',
                        controller: certificateController,
                      ),
                    // TextFormFieldWidget(
                    //   labeltext: 'Standards',
                    //   controller: standardsController,
                    // ),
                    // ksizedbox10,
                    ksizedbox10,
                    TextFormFieldWidget(
                      labeltext: 'City',
                      controller: cityController,
                    ),
                    ksizedbox10,
                    TextFormFieldWidget(
                      labeltext: ' State',
                      controller: stateController,
                    ),
                    ksizedbox10,
                    GetBuilder<AuthController>(builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              _showStartDate(context);
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(selectdt),
                              ),
                            ),
                          ),
                          Text(
                            'To',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: kgrey),
                          ),
                          InkWell(
                            onTap: () {
                              _showEndDate(context);
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: selectdt1 ==
                                        formatDate(
                                            DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                                DateTime.now().day),
                                            [yyyy, "-", mm, "-", dd])
                                    ? const Text("Till Date")
                                    : Text(selectdt1),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    ksizedbox10,
                    InkWell(
                      onTap: () {
                        var flag = "";
                        if (standardsController.text == "10th" ||
                            standardsController.text == "12th") {
                          flag = "student";
                        } else if (standardsController.text == "UG" ||
                            standardsController.text == "PG" ||
                            standardsController.text == "PUC") {
                          flag = "college";
                        } else {
                          flag = "institute";
                        }

                        print("-------->> chack values <<---------");
                        print(schoolController.text);
                        print(standardsController.text);
                        authController.addEducationalSkills(
                            flag: flag,
                            institutionname: schoolController.text,
                            userId: "",
                            educationtitle: standardsController.text,
                            city: cityController.text,
                            state: stateController.text,
                            frombatch: selectdt,
                            tilldate: selectdt1 ==
                                    formatDate(
                                        DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day),
                                        [yyyy, "-", mm, "-", dd])
                                ? "Till Date"
                                : selectdt,
                            educationdescription: certificateController.text);
                        //   Get.back();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                            color: kblue,
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                            child: Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: kwhite),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _usertypPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Obx(
          () => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(18.0), // Adjust the radius as needed
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    authController.wayIndex(0);
                  },
                  child: Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                      color:
                          authController.wayIndex.value == 0 ? kblue : kwhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Student",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: authController.wayIndex.value == 0
                                ? kwhite
                                : kblue),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    authController.wayIndex(1);
                  },
                  child: Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                      color:
                          authController.wayIndex.value == 0 ? kwhite : kblue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Professional",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: authController.wayIndex.value == 0
                                ? kblue
                                : kwhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            content: const Text(
              'Would you like to be a  __________',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        authController.professinalindex(0);
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: kgrey),
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // kwidth10,
                              const Text(
                                'Mentor',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              authController.professinalindex.value == 0
                                  ? Icon(
                                      Icons.check_circle,
                                      color: kblue,
                                      size: 28,
                                    )
                                  : Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    )
                              //   kwidth10
                            ],
                          ),
                        ),
                      ),
                    ),
                    ksizedbox10,
                    ksizedbox10,
                    if (authController.wayIndex == 1)
                      InkWell(
                        onTap: () {
                          authController.professinalindex(1);
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kgrey),
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // kwidth10,
                                const Text(
                                  'Trainer',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                authController.professinalindex.value == 1
                                    ? Icon(
                                        Icons.check_circle,
                                        color: kblue,
                                        size: 28,
                                      )
                                    : Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      )
                                //   kwidth10
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (authController.wayIndex == 0)
                      InkWell(
                        onTap: () {
                          authController.professinalindex(1);
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kgrey),
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // kwidth10,
                                const Text(
                                  'Training',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                authController.professinalindex.value == 1
                                    ? Icon(
                                        Icons.check_circle,
                                        color: kblue,
                                        size: 28,
                                      )
                                    : Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      )
                                //   kwidth10
                              ],
                            ),
                          ),
                        ),
                      ),
                    ksizedbox10,
                    ksizedbox10,
                    if (authController.wayIndex == 0)
                      InkWell(
                        onTap: () {
                          authController.professinalindex(2);
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kgrey),
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // kwidth10,
                                const Text(
                                  'Certification',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                authController.professinalindex.value == 2
                                    ? Icon(
                                        Icons.check_circle,
                                        color: kblue,
                                        size: 28,
                                      )
                                    : Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      )
                                //   kwidth10
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (authController.wayIndex == 1)
                      InkWell(
                        onTap: () {
                          authController.professinalindex(2);
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kgrey),
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // kwidth10,
                                const Text(
                                  'Guide',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                authController.professinalindex.value == 2
                                    ? Icon(
                                        Icons.check_circle,
                                        color: kblue,
                                        size: 28,
                                      )
                                    : Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      )
                                //   kwidth10
                              ],
                            ),
                          ),
                        ),
                      ),
                    ksizedbox30,
                    InkWell(
                      onTap: () {
                        String? type;
                        if (authController.wayIndex.value == 0) {
                          if (authController.professinalindex.value == 0) {
                            type = "Mentor";
                          } else if (authController.professinalindex.value ==
                              1) {
                            type = "Training";
                          } else if (authController.professinalindex.value ==
                              2) {
                            type = "Certification";
                          }
                          authController.eStudentProfessionaltype(type: type!);
                        } else {
                          if (authController.professinalindex.value == 0) {
                            type = "Mentor";
                          } else if (authController.professinalindex.value ==
                              1) {
                            type = "Trainer";
                          } else if (authController.professinalindex.value ==
                              2) {
                            type = "Guide";
                          }
                          authController.eStudentProfessionaltype(type: type!);
                        }
                        authController.updateUserType(
                            userType: authController.wayIndex.value == 0
                                ? "Student"
                                : "Professional");
                        educationPopup();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                            color: kblue,
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                            child: Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: kwhite),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
