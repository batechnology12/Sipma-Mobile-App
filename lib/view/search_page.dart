import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/posts_controller.dart';
import 'package:simpa/view/post_view/others_post_view.dart';

import '../widgets/bottumnavigationbar.dart';
import '../widgets/search_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchtextController = TextEditingController();

  final postsController = Get.find<PostsController>();

  @override
  void initState() {
    super.initState();
    searchtextController.addListener(searchUsers);
  }

  searchUsers() {
    if (searchtextController.text.trim().isNotEmpty) {
      postsController.searchPost(keyWord: searchtextController.text);
    } else {
      postsController.searchPosts.clear();
      postsController.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kwhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(BottomNavigationBarExample());
          },
        ),
        title: const Text('Search'),
        actions: const [],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: search(
                textController: searchtextController,
              )),
        ),
      ),
      backgroundColor: kwhite,
      body: GetBuilder<PostsController>(builder: (_) {
        return postsController.searchPosts.isEmpty &&
                searchtextController.text.isNotEmpty
            ? const Center(
                child: Text("No data"),
              )
            : GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: postsController.searchPosts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      //  postsController.getAllPost();
                      Get.to(() => OtherPostView(
                          image: postsController.searchPosts[index].mediaUrl));
                    },
                    child: Card(
                      child: Image.network(
                          postsController.searchPosts[index].mediaUrl),
                    ),
                  );
                },
              );
      }),
    );
  }
}

final List<String> images = [
  "assets/images/searchimage.png",
  "assets/images/postsplashimage.png",
  "assets/images/postsplashimage.png",
  "assets/images/postsplashimage.png",
  "assets/images/postsplashimage.png",
  "assets/images/postsplashimage.png",
  "assets/images/postsplashimage.png",
  "assets/images/postsplashimage.png",
  "assets/images/postsplashimage.png",
];
