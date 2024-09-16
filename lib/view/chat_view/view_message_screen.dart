import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/constands/firestoreconsts.dart';
import 'package:simpa/constands/message_types.dart';
import 'package:simpa/controllers/chat_controller.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/chat_messages_model.dart';
import 'package:simpa/models/chat_models.dart';
import 'package:simpa/view/public_profle_view/public_user_profile_view.dart';
import 'package:simpa/widgets/chat_widget/image_view_in_chat.dart';
import 'package:simpa/widgets/chat_widget/my_chat_container.dart';
import 'package:simpa/widgets/chat_widget/other_chat_bubble.dart';
import 'package:simpa/widgets/chat_widget/recived_image_view.dart';
import 'package:simpa/widgets/chat_widget/send_image_container.dart';

class ViewMessageScreen extends StatefulWidget {
  int peerId;
  ChatListModel chatModel;
  ViewMessageScreen({
    Key? key,
    required this.peerId,
    required this.chatModel,
  }) : super(key: key);

  @override
  State<ViewMessageScreen> createState() => _ViewMessageScreenState();
}

class _ViewMessageScreenState extends State<ViewMessageScreen> {
  final myProfileController = Get.find<ProfileController>();
  final chatController = Get.find<ChatController>();

  late ScrollController scrollController;
  var textEditingController = TextEditingController();

  bool emojiShowing = false;

  final StreamController<QuerySnapshot> chatStramController =
      StreamController<QuerySnapshot>.broadcast();

  List<int> indexList = [];

  bool isRealtime = true;

  bool isBlocked = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    chatController.listMessages.clear();
    scrollController.addListener(_scrollListener);

    // getBlockedState();
  }

  // getBlockedState() async {
  //   final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   DocumentSnapshot<
  //       Map<String,
  //           dynamic>> documentReference = await firebaseFirestore
  //       .collection(FireStoreConstants().pathChatListcollection)
  //       .doc("${myProfileController.profileDatas.id}${widget.chatModel.userId}")
  //       .get();

  //   setState(() {
  //     isBlocked = documentReference.get(ChatListConstants().isBlocked);
  //   });
  // }

  addToTheList() {
    chatController.addToChatList(widget.chatModel);
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // setState(() {
      //   message = "reach the bottom";
      // });
      print("Reached The Bottom...");
      setState(() {
        isRealtime = false;
      });
      fetchData();
      // if (activityController.totalPages.value !=
      //     activityController.currentPage.value) {
      //   int page = activityController.currentPage.value + 1;
      //   print("Next Page >>>>>>>>>>>>>>>>$page");
      //   if (activityController.isFilterEnabled.isTrue) {
      //     activityController.getNextPageFilterActivity(page);
      //   } else {
      //     activityController.getNextPageActivityByLocation(page);
      //   }
      // }
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      // setState(() {
      //   message = "reach the top";
      // });
      // fetchData();
      setState(() {
        isRealtime = true;
      });
      print("Reached The Top");
    }
  }

  fetchData() {
    print("Entering to next page ${chatController.listMessages.last.id}");
    Stream<QuerySnapshot<Object?>> stream = chatController.getMoreChatMessage(
        widget.chatModel.chatId, 20, chatController.listMessages.last);
    stream.listen((event) {
      print(event.docs.length);
      for (var element in event.docs) {
        chatController.listMessages.add(element);
      }
    });
    chatController.update();
  }

  getBack() {
    chatController.makeActiveUser(
        chatId: widget.chatModel.chatId,
        userId: myProfileController.profileData.first.user.id.toString(),
        status: false);

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 240, 240, 240),
            elevation: 0,
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            centerTitle: true,
            title: Text(
              "${widget.chatModel.firstName} ${widget.chatModel.lastName}",
              style: primaryfont.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
            actions: [
              Row(
                children: [
                  InkWell(
                      onTap: () async {
                        // usermodel.UserData userModel =
                        //     await Get.find<SearchController>()
                        //         .getUserDetailsById(
                        //             widget.chatModel.userId.toString());
                        // chatController.getSharedActivtys(
                        //     widget.chatModel.chatId, 30);
                        // chatController.getSharedMedia(
                        //     widget.chatModel.chatId, 30);
                        // myProfileController.getfollowingTags();
                        // bool isContains = myProfileController.followingTags
                        //     .contains(userModel.username);
                        // myProfileController.isfollowing(isContains);
                        // Get.to(ProfileViewFromChat(
                        //   chatModel: widget.chatModel,
                        //   userModel: userModel,
                        // ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: widget.chatModel.photo == ""
                            ? InkWell(
                                onTap: () {
                                  Get.to(() => PublicUserProfilePage(
                                        userId: widget.peerId,
                                      ));
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.asset(
                                      "assets/icons/profil_img.jpeg",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  Get.to(() => PublicUserProfilePage(
                                        userId: widget.peerId,
                                      ));
                                },
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.network(
                                          widget.chatModel.photo,
                                          height: 40,
                                          width: 40,
                                        ))),
                              ),
                      )),
                ],
              )
            ],
          ),
          body: WillPopScope(
            onWillPop: () {
              return getBack();
            },
            child: GetBuilder<ChatController>(
                builder: (_) => SizedBox(
                      height: size.height - 50,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: chatController.getChatMessage(
                              widget.chatModel.chatId, 25),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            chatController.updateReadStatus(
                                widget.chatModel.chatId,
                                myProfileController.profileData.first.user.id);
                            chatController.makeActiveUser(
                                chatId: widget.chatModel.chatId,
                                userId: myProfileController
                                    .profileData.first.user.id
                                    .toString(),
                                status: true);
                            if (snapshot.hasData) {
                              if (isRealtime) {
                                chatController.listMessages =
                                    snapshot.data!.docs;
                              }
                              if (chatController.listMessages.isNotEmpty) {
                                return ListView.builder(
                                    padding: const EdgeInsets.all(10),
                                    itemCount:
                                        chatController.listMessages.length,
                                    reverse: true,
                                    controller: scrollController,
                                    itemBuilder: (context, index) => buildItem(
                                        index,
                                        chatController.listMessages[index]));
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Container(
                                      height: 70,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.blue[300],
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            "Send a new message now",
                                            style: primaryfont.copyWith(
                                                color: kwhite),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    )),
          ),
          bottomNavigationBar: Container(
            width: size.width,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: size.width * 0.83,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    padding: const EdgeInsets.only(left: 15),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 5,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      controller: textEditingController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          hintText: 'Type here',
                          hintStyle: primaryfont,
                          // prefixIcon: InkWell(
                          //     onTap: () {
                          //       // _modalBottomSheetMoreActions(size, context);
                          //     },
                          //     child:
                          //         Image.asset("assets/icons/More Button.png")),
                          // suffixIcon: Image.asset("assets/icons/GIF Icon.png"),
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onChanged: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15, left: 15, top: 6, bottom: 10),
                    child: InkWell(
                        onTap: () async {
                          onSendMessage(
                              textEditingController.text, MessageType().text);
                        },
                        child: const Icon(Icons.send)),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  // checking if received message
  bool isMessageReceived(int index) {
    if ((index > 0 &&
            chatController.listMessages[index - 1]
                    .get(FireStoreConstants().idFrom) ==
                myProfileController.profileData.first.user.id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isMessageSent(int index) {
    if ((index > 0 &&
            chatController.listMessages[index - 1]
                    .get(FireStoreConstants().idFrom) !=
                myProfileController.profileData.first.user.id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  void onSendMessage(String content, int type) async {
    if (content.trim().isNotEmpty) {
      print("<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>1");
      textEditingController.clear();
      chatController.sendChatMessage(content, type, widget.chatModel.chatId,
          myProfileController.profileData.first.user.id, widget.peerId);
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      print("<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>2");

      ChatListModel othetrUserchatModel = ChatListModel(
          userId: widget.chatModel.userId,
          firstName: widget.chatModel.firstName,
          lastName: widget.chatModel.lastName,
          photo: widget.chatModel.photo,
          pin: widget.chatModel.pin == 3 ? 0 : widget.chatModel.pin,
          isArchived: widget.chatModel.isArchived,
          isBlocked: widget.chatModel.isBlocked,
          isMuted: widget.chatModel.isMuted,
          userName: widget.chatModel.userName,
          chatId: widget.chatModel.chatId,
          unreadCount: 1,
          message: content,
          messageType: type,
          readStatus: false,
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
          users: [
            myProfileController.profileData.first.user.id,
          ]);
      // chatController.checkAlreadyChated(
      //     widget.chatModel.chatId, widget.chatModel, currentUserchatModel);
      print("<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>3");

      chatController.updateTheChatList(othetrUserchatModel);
      print("<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>4");

      ChatListModel currentUserchatModel = ChatListModel(
          userId: myProfileController.profileData.first.user.id,
          firstName: myProfileController.profileData.first.user.name,
          lastName: myProfileController.profileData.first.user.lastName,
          photo:
              myProfileController.profileData.first.user.profilePicture ?? "",
          pin: 0,
          isArchived: false,
          isBlocked: false,
          isMuted: false,
          userName: myProfileController.profileData.first.user.userName,
          chatId: widget.chatModel.chatId,
          unreadCount: 1,
          message: content,
          messageType: type,
          readStatus: true,
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
          users: [
            widget.chatModel.userId,
          ]);
      print("<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>5");

      chatController.updateCurrentTheChatList(currentUserchatModel);

      String message = "";
      if (type == MessageType().text) {
        message = content;
      } else if (type == MessageType().activity) {
        message = "Shared an activity";
      } else if (type == MessageType().image) {
        message = "Shared an image";
      }
      // if (documentReference.exists == true) {
      //   if (documentReference.get(ChatListConstants().isMuted) == false) {
      //     // chatController.sendNotification(
      //     //     widget.chatModel.userId.toString(),
      //     //     "${myProfileController.profileDatas.firstName} ${myProfileController.profileDatas.lastName}",
      //     //     message,
      //     //     widget.chatModel.chatId);
      //   }
      // } else {

      // }

      chatController.sendNotification(
          widget.chatModel.userId.toString(),
          "${myProfileController.profileData.first.user.name} ${myProfileController.profileData.first.user.lastName}",
          message,
          widget.chatModel.chatId);
    } else {
      print("nothing to send");
    }
  }

  // Future<ShowActivityData> getActivity(String activityId) async {
  //   String link = "https://dev.thecodedemo.com/api/v1/activity/$activityId";
  //   ShowActivityData activityData =
  //       await activityController.dynamicLinkActivity(link);
  //   return activityData;
  // }

  Widget buildItem(int index, DocumentSnapshot? documentSnapshot) {
    if (documentSnapshot != null) {
      ChatMessages chatMessages = ChatMessages.fromDocument(documentSnapshot);

      // if (chatMessages.type == MessageType().profile) {
      //   Map<String, dynamic> activityResponse =
      //       json.decode(chatMessages.content);
      //   userData = FollowUserData.fromJson(activityResponse);
      // }

      // ignore: unrelated_type_equality_checks
      if (chatMessages.idFrom ==
          myProfileController.profileData.first.user.id) {
        // right side (my message)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                chatMessages.type == MessageType().text
                    ? MyChatContainers(
                        chat: chatMessages.content,
                        chatMessgae: chatMessages,
                        time: DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            int.parse(chatMessages.timestamp),
                          ),
                        ),
                      )
                    : chatMessages.type == MessageType().image
                        ? InkWell(
                            onTap: () {
                              Get.to(() => ChatImageView(
                                    image: chatMessages.content,
                                  ));
                            },
                            child: SendedImageView(
                                image: chatMessages.content,
                                timestamp: chatMessages.timestamp),
                          )
                        : Container(
                            height: 2,
                          ),
                // isMessageSent(index)
                //     ? Container(
                //         height: 30,
                //         width: 30,
                //         decoration: BoxDecoration(
                //             color: Colors.red,
                //             borderRadius: BorderRadius.circular(20)),
                //       )
                //     : Container(
                //         width: 35,
                //       ),
              ],
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                isMessageReceived(index)
                    // left side (received message)
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: widget.chatModel.photo == ""
                            ? SizedBox(
                                height: 25,
                                width: 25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                      "assets/icons/profil_img.jpeg"),
                                ),
                              )
                            : SizedBox(
                                height: 25,
                                width: 25,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      widget.chatModel.photo,
                                      height: 25,
                                      width: 25,
                                    ))),
                      )
                    : Container(
                        width: 25,
                      ),
                chatMessages.type == MessageType().text
                    ? OthersChatBubble(
                        chat: chatMessages.content,
                        time: DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            int.parse(chatMessages.timestamp),
                          ),
                        ),
                      )
                    : chatMessages.type == MessageType().image
                        ? InkWell(
                            onTap: () {
                              Get.to(() => ChatImageView(
                                    image: chatMessages.content,
                                  ));
                            },
                            child: RecivedImageView(
                                image: chatMessages.content,
                                timestamp: chatMessages.timestamp),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
          ],
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  // void _modalBottomSheetMoreActions(size, context) {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20.0),
  //     ),
  //     backgroundColor: Colors.white,
  //     context: context,
  //     // Also default
  //     builder: (context) {
  //       return SizedBox(
  //           height: size.height * 0.45,
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 const SizedBox(
  //                   height: 15,
  //                 ),

  //                 LightColoredSingleChildButton(
  //                     alignment: Alignment.center,
  //                     color: const Color.fromARGB(255, 250, 248, 248),
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     onTap: () {
  //                       final newcontroller = Get.find<NewActivityController>();
  //                       Navigator.of(context).pop();
  //                       newcontroller.setToDefault();
  //                       newcontroller.followingUsersListforShare.add(
  //                           FollowUserData(
  //                               createdAt: DateTime.now(),
  //                               firstName: widget.chatModel.firstName,
  //                               lastName: widget.chatModel.lastName,
  //                               id: widget.chatModel.userId,
  //                               photo: widget.chatModel.photo,
  //                               sports: [],
  //                               username: widget.chatModel.userName,
  //                               isSelected: true));
  //                       newcontroller.sharedUsred++;
  //                       newcontroller.update();
  //                       Get.to(const NewActivityView());
  //                     },
  //                     height: 50,
  //                     radious: 10,
  //                     leftpadding: 10,
  //                     rightpadding: 10,
  //                     width: size.width,
  //                     text: Padding(
  //                       padding: const EdgeInsets.only(left: 10),
  //                       child: Row(
  //                         children: [
  //                           const Icon(Icons.add_circle_outline),
  //                           const SizedBox(
  //                             width: 10,
  //                           ),
  //                           Text(
  //                             "New Activity",
  //                             style:
  //                                 primaryfont.copyWith(color: Colors.black45),
  //                           ),
  //                         ],
  //                       ),
  //                     )),
  //                 const SizedBox(
  //                   height: 15,
  //                 ),
  //                 LightColoredSingleChildButton(
  //                     alignment: Alignment.center,
  //                     color: const Color.fromARGB(255, 250, 248, 248),
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                       Get.to(ShareActivity(
  //                         chatModel: widget.chatModel,
  //                         peerId: widget.peerId,
  //                         type: MessageType().activity,
  //                       ));
  //                     },
  //                     height: 50,
  //                     radious: 10,
  //                     leftpadding: 10,
  //                     rightpadding: 10,
  //                     width: size.width,
  //                     text: Padding(
  //                       padding: const EdgeInsets.only(left: 10),
  //                       child: Row(
  //                         children: [
  //                           const Icon(Icons.person_add_alt_outlined),
  //                           const SizedBox(
  //                             width: 10,
  //                           ),
  //                           Text(
  //                             "Share an Activity",
  //                             style:
  //                                 primaryfont.copyWith(color: Colors.black45),
  //                           ),
  //                         ],
  //                       ),
  //                     )),
  //                 const SizedBox(
  //                   height: 15,
  //                 ),
  //                 LightColoredSingleChildButton(
  //                     alignment: Alignment.center,
  //                     color: const Color.fromARGB(255, 250, 248, 248),
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     onTap: () async {
  //                       final ImagePicker _picker = ImagePicker();
  //                       final XFile? image = await _picker.pickImage(
  //                           source: ImageSource.gallery);
  //                       File chatimg = File(image!.path);

  //                       String chatImages =
  //                           await chatController.uploadChatImage(chatimg);

  //                       onSendMessage(chatImages, MessageType().image);
  //                       Navigator.of(context).pop();
  //                     },
  //                     height: 50,
  //                     radious: 10,
  //                     leftpadding: 10,
  //                     rightpadding: 10,
  //                     width: size.width,
  //                     text: Padding(
  //                       padding: const EdgeInsets.only(left: 10),
  //                       child: Row(
  //                         children: [
  //                           const Icon(Icons.photo_library_rounded),
  //                           const SizedBox(
  //                             width: 10,
  //                           ),
  //                           Text(
  //                             "Photo",
  //                             style:
  //                                 primaryfont.copyWith(color: Colors.black45),
  //                           ),
  //                         ],
  //                       ),
  //                     )),
  //               ],
  //             ),
  //           ));
  //     },
  //   );
  // }
}
