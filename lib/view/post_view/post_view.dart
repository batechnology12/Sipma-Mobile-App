import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/posts_controller.dart';
import 'package:simpa/models/get_all_post_modals.dart';
import 'package:simpa/view/coments.dart';
import 'package:simpa/view/reactions_page.dart';
import 'package:simpa/widgets/like.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostView extends StatefulWidget {
  Post postData;
  bool isOtherProfile;
  PostView({super.key, required this.postData, this.isOtherProfile = false});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final postsController = Get.find<PostsController>();

  void _toggleLike(bool liked) {
    setState(() {
      if (widget.postData.likedByUser == false) {
        widget.postData.likeCount = widget.postData.likeCount + 1;
      } else {
        widget.postData.likeCount = widget.postData.likeCount - 1;
      }
      widget.postData.likedByUser = !widget.postData.likedByUser;
    });

    postsController.postLike(
        postId: widget.postData.id.toString(),
        isLiked: liked ? "1" : "0",
        index: 0);
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
    _toggleLike(!isLiked);

    return !isLiked;
  }

  void _showDeletePostOptions(String postId) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        context: context,
        builder: (builder) {
          return Container(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 50, right: 10, left: 10, bottom: 30),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5, color: Colors.grey.withOpacity(0.5)),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            widget.postData.user.profilePicture == null
                                ? const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/icons/profil_img.jpeg'),
                                    radius: 25,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        widget.postData.user.profilePicture),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.postData.user.name,
                                  style: ktextstyle22,
                                ),
                                Text(widget.postData.user.designation ??
                                        widget.postData.user.userName)
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
                              timeago.format(widget.postData.createdAt),
                              style: const TextStyle(fontSize: 10),
                            ).animate().fade().scale(),
                            if (widget.isOtherProfile == false)
                              InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                  topLeft: Radius.circular(50),
                                                  topRight: Radius.circular(50),
                                                )),
                                                child: const Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20, top: 6),
                                                      child: Text(
                                                        'Post Settings',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ListTile(
                                                leading:
                                                    const Icon(Icons.delete),
                                                title: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  _showDeletePostOptions(widget
                                                      .postData.id
                                                      .toString());
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Icon(Icons.more_vert_rounded))
                          ],
                        ),
                      ],
                    ),
                    ksizedbox10,
                    // Text(widget.postData.title)
                    //     .animate()
                    //     .fade()
                    //     .scale(),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    if (widget.postData.title != "")
                      Text(widget.postData.title).animate().fade().scale(),
                    ksizedbox10,
                    if (widget.postData.body != "")
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.postData.body.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ksizedbox10,
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.to(reacton_screen(
                                  likeCount: widget.postData.likeCount,
                                  postId: widget.postData.id,
                                ));
                              },
                              child:
                                  Text(widget.postData.likeCount.toString())),
                          InkWell(
                              onTap: () {
                                Get.to(coments(
                                  postId: widget.postData.id,
                                ));
                              },
                              child: Text(
                                '${widget.postData.comment} comments',
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          height: 1,
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        // LikeButtonWidget(
                        //   isliked: widget.postData.likedByUser,
                        //   postId: widget.postData.id,
                        //   indexOfPost: 0,
                        //   likeCount: widget.postData.likeCount,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: LikeButton(
                            size: 22,
                            onTap: onLikeButtonTapped,
                            isLiked: widget.postData.likedByUser,
                            circleColor: CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked
                                    ? Icons.thumb_up_alt_rounded
                                    : Icons.thumb_up_alt_outlined,
                                color: isLiked
                                    ? kblue
                                    : const Color.fromARGB(255, 110, 109, 109),
                                size: 22,
                              );
                            },
                            likeCount: widget.postData.likeCount,
                            likeCountAnimationType: LikeCountAnimationType.part,
                            countBuilder:
                                (int? count, bool isLiked, String text) {
                              final ColorSwatch<int> color =
                                  isLiked ? Colors.blue : Colors.grey;
                              Widget result;
                              if (count == 0) {
                                result = Text(
                                  'Like',
                                  style: TextStyle(color: color),
                                );
                              } else
                                result = Text(
                                  count! >= 1000
                                      ? (count / 1000.0).toStringAsFixed(1) +
                                          'k'
                                      : text,
                                  style: TextStyle(color: color),
                                );
                              return result;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            postsController.commentsList.clear();
                            postsController.update();
                            Get.to(coments(
                              postId: widget.postData.id,
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
          ),
        ),
      ),
    );
  }
}
