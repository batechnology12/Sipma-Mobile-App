import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/auth_controllers.dart';
import 'package:simpa/controllers/posts_controller.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/view/coments.dart';
import 'package:simpa/view/public_profle_view/public_user_profile_view.dart';
import 'package:simpa/view/reactions_page.dart';
import 'package:simpa/widgets/bottumnavigationbar.dart';
import 'package:simpa/widgets/like.dart';
import 'package:timeago/timeago.dart' as timeago;

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool _allTap = false;
  bool _hrTap = false;
  bool _salesTap = false;
  bool _marketTap = false;
  bool _addTap = false;

  final authController = Get.find<AuthController>();
  final postsController = Get.find<PostsController>();

  @override
  void initState() {
    super.initState();
    authController.getDepartmentList();
    postsController.getAllInFilterPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(125),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.white,
              title: const Text('Filter'),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 45,
              child: GetBuilder<AuthController>(builder: (_) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 3, bottom: 3),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  authController.selctedIndex.value == 100
                                      ? const Color(0xff3C73B1)
                                      : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            // setState(() {
                            //   _salesTap = !_salesTap;
                            // });
                            postsController.getAllInFilterPost();
                            authController.selctedIndex(100);
                            authController.update();
                          },
                          child: Text(
                            "All",
                            style: TextStyle(
                                color: authController.selctedIndex.value == 100
                                    ? kwhite
                                    : Colors.black),
                          ),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: authController.departments.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 3, bottom: 3),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        authController.selctedIndex.value ==
                                                index
                                            ? Color(0xff3C73B1)
                                            : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    // setState(() {
                                    //   _salesTap = !_salesTap;
                                    // });
                                    postsController.filterPosts(
                                        departmentId: authController
                                            .departments[index].id);
                                    authController.selctedIndex(index);
                                    authController.update();
                                  },
                                  child: Text(
                                    authController.departments[index].title,
                                    style: TextStyle(
                                        color:
                                            authController.selctedIndex.value ==
                                                    index
                                                ? kwhite
                                                : Colors.black),
                                  )),
                            );
                          }),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GetBuilder<PostsController>(builder: (_) {
          return postsController.filterList.isEmpty
              ? Center(
                  child: Image.asset("assets/icons/no_post.png"),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: postsController.filterList.length,
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
                                  color: Colors.grey.withOpacity(0.5)),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (postsController
                                              .filterList[index].user.id ==
                                          Get.find<ProfileController>()
                                              .profileData
                                              .first
                                              .user
                                              .id) {
                                        Get.offAll(
                                            () => BottomNavigationBarExample(
                                                  index: 4,
                                                ));
                                      } else {
                                        Get.to(() => PublicUserProfilePage(
                                              userId: postsController
                                                  .filterList[index].user.id,
                                            ));
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        postsController.filterList[index].user
                                                    .profilePicture ==
                                                null
                                            ? const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/icons/profil_img.jpeg'),
                                                radius: 25,
                                              )
                                            : CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    postsController
                                                        .filterList[index]
                                                        .user
                                                        .profilePicture),
                                                radius: 25,
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              postsController
                                                  .filterList[index].user.name,
                                              style: ktextstyle22,
                                            ),
                                            Text(postsController
                                                        .filterList[index]
                                                        .user
                                                        .designation ??
                                                    postsController
                                                        .filterList[index]
                                                        .user
                                                        .userName)
                                                .animate()
                                                .fade()
                                                .scale(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    timeago.format(postsController
                                        .filterList[index].createdAt),
                                    style: const TextStyle(fontSize: 10),
                                  ).animate().fade().scale(),
                                ],
                              ),
                              ksizedbox10,
                              // Text(postsController.filterList[index].title)
                              //     .animate()
                              //     .fade()
                              //     .scale(),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              ReadMoreText(
                                postsController.filterList[index].title,
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
                              // Text(postsController.filterList[index].title)
                              //     .animate()
                              //     .fade()
                              //     .scale(),
                              ksizedbox10,
                              postsController.filterList[index].body == ""
                                  ? Container()
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        postsController.filterList[index].body
                                            .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              ksizedbox10,
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    postsController
                                                .filterList[index].likeCount ==
                                            0
                                        ? Container(
                                            width: 5,
                                          )
                                        : postsController.filterList[index]
                                                    .likeCount ==
                                                1
                                            ? InkWell(
                                                onTap: () {
                                                  Get.to(reacton_screen(
                                                    likeCount: postsController
                                                        .filterList[index]
                                                        .likeCount,
                                                    postId: postsController
                                                        .filterList[index].id,
                                                  ));
                                                },
                                                child: Text(
                                                  "${postsController.filterList[index].likeCount} Likes",
                                                  style: primaryfont.copyWith(
                                                      fontSize: 12),
                                                ))
                                            : InkWell(
                                                onTap: () {
                                                  Get.to(reacton_screen(
                                                    likeCount: postsController
                                                        .filterList[index]
                                                        .likeCount,
                                                    postId: postsController
                                                        .filterList[index].id,
                                                  ));
                                                },
                                                child: FutureBuilder(
                                                    future: postsController
                                                        .getLikedNames(
                                                            postId:
                                                                postsController
                                                                    .filterList[
                                                                        index]
                                                                    .id
                                                                    .toString()),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Text(
                                                            "...");
                                                      }
                                                      return Text(
                                                        "${snapshot.data} and other ${(postsController.filterList[index].likeCount - 1).toString()} Likes",
                                                        style: primaryfont
                                                            .copyWith(
                                                                fontSize: 12),
                                                      );
                                                    })),
                                    InkWell(
                                        onTap: () {
                                          Get.to(coments(
                                            postId: postsController
                                                .filterList[index].id,
                                          ));
                                        },
                                        child: Text(
                                          '${postsController.filterList[index].comment} comments',
                                        ))
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
                                    isNormal: 1,
                                    isliked: postsController
                                        .filterList[index].likedByUser,
                                    postId:
                                        postsController.filterList[index].id,
                                    indexOfPost: index,
                                    likeCount: postsController
                                        .filterList[index].likeCount,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      postsController.commentsList.clear();
                                      postsController.update();
                                      Get.to(coments(
                                        postId: postsController
                                            .filterList[index].id,
                                      ));
                                    },
                                    child: kcomentbutton,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
        }),
      ),
    );
  }
}
