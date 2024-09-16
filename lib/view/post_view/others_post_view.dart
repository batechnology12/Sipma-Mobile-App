import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/posts_controller.dart';

class OtherPostView extends StatefulWidget {
  String image;
  OtherPostView({super.key, required this.image});

  @override
  State<OtherPostView> createState() => _PostViewState();
}

class _PostViewState extends State<OtherPostView> {
  final postsController = Get.find<PostsController>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
