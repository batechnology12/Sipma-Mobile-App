import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/posts_controller.dart';
import '../widgets/bottumnavigationbar.dart';
import 'package:timeago/timeago.dart' as timeago;



class reacton_screen extends StatefulWidget {
  int likeCount;
  int postId;
  reacton_screen({super.key, required this.likeCount, required this.postId});

  @override
  State<reacton_screen> createState() => _reacton_screenState();
}

class _reacton_screenState extends State<reacton_screen> {
  final postController = Get.find<PostsController>();

  @override
  void initState() {
    super.initState();
    postController.getLikesList(postId: widget.postId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            bottom: TabBar(
                isScrollable: false,
                labelColor: kblue,
                indicatorColor: kblue,
                tabs: [
                  Tab(
                    text: 'ALL',
                  ),
                  Row(
                    children: [
                      kheartbutton,
                      SizedBox(
                        width: 5,
                      ),
                      Tab(
                        text: widget.likeCount.toString(),
                      ),
                    ],
                  )
                ]),
            title: Text(
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
        body: TabBarView(children: [
          GetBuilder<PostsController>(builder: (_) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: postController.likesList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
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
                      subtitle: Text(postController.likesList[index].userName),
                      trailing: Text(
                        timeago
                            .format(postController.likesList[index].createdAt),
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
              physics: BouncingScrollPhysics(),
              itemCount: postController.likesList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: ListTile(
                      leading: postController.likesList[index].picture == ""
                          ? CircleAvatar(
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
                      subtitle: Text(postController.likesList[index].userName),
                      trailing: Text(
                        timeago
                            .format(postController.likesList[index].createdAt),
                        style: const TextStyle(fontSize: 10),
                      )),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                );
              },
            );
          }),
        ]),
      ),
    );
  }
}
