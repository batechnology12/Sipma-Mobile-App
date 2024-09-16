import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/posts_controller.dart';
import 'package:simpa/view/public_profle_view/public_user_profile_view.dart';
import 'package:simpa/widgets/bottumnavigationbar.dart';

import 'package:timeago/timeago.dart' as timeago;

class NotficationReactionView extends StatefulWidget {
  int likeCount;
  int postId;
  NotficationReactionView(
      {super.key, required this.likeCount, required this.postId});

  @override
  State<NotficationReactionView> createState() => _reacton_screenState();
}

class _reacton_screenState extends State<NotficationReactionView> {
  final postController = Get.find<PostsController>();

  @override
  void initState() {
    super.initState();
    postController.getLikesList(postId: widget.postId.toString());
  }

  getBack() {
    Get.offAll(() => BottomNavigationBarExample(
          index: 0,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            bottom: TabBar(
                isScrollable: false,
                labelColor: kblue,
                indicatorColor: kblue,
                tabs: [
                  const Tab(
                    text: 'ALL',
                  ),
                  Row(
                    children: [
                      kheartbutton,
                      const SizedBox(
                        width: 5,
                      ),
                      const Tab(
                        text: "",
                      ),
                    ],
                  )
                ]),
            title: const Text(
              'Reactions',
            ),
            backgroundColor: kwhite,
            leading: IconButton(
                onPressed: () {
                  Get.to(BottomNavigationBarExample());
                },
                icon: const Icon(Icons.arrow_back)),
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            return getBack();
          },
          child: TabBarView(children: [
            GetBuilder<PostsController>(builder: (_) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: postController.likesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => PublicUserProfilePage(
                            userId: int.parse(postController
                                .likesList[index].userId
                                .toString()),
                          ));
                    },
                    child: ListTile(
                        leading: postController.likesList[index].picture == ""
                            ? const CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/icons/profil_img.jpeg'),
                              )
                            : CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    postController.likesList[index].picture),
                              ),
                        title: Text(postController.likesList[index].userName),
                        subtitle:
                            Text(postController.likesList[index].userName),
                        trailing: Text(
                          timeago.format(
                              postController.likesList[index].createdAt),
                          style: const TextStyle(fontSize: 10),
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                  );
                },
              );
            }),
            GetBuilder<PostsController>(builder: (_) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: postController.likesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: ListTile(
                        leading: postController.likesList[index].picture == ""
                            ? InkWell(
                                onTap: () {
                                  Get.to(() => PublicUserProfilePage(
                                        userId: int.parse(postController
                                            .likesList[index].userId
                                            .toString()),
                                      ));
                                },
                                child: const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      'assets/icons/profil_img.jpeg'),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  Get.to(() => PublicUserProfilePage(
                                        userId: postController
                                            .likesList[index].userId,
                                      ));
                                },
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      postController.likesList[index].picture),
                                ),
                              ),
                        title: Text(postController.likesList[index].userName),
                        subtitle:
                            Text(postController.likesList[index].userName),
                        trailing: Text(
                          timeago.format(
                              postController.likesList[index].createdAt),
                          style: const TextStyle(fontSize: 10),
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                  );
                },
              );
            }),
          ]),
        ),
      ),
    );
  }
}
