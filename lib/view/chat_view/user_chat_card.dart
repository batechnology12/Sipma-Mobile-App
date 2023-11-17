import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/constands/message_types.dart';
import 'package:simpa/controllers/chat_controller.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/chat_models.dart';

class UserChatCard extends StatefulWidget {
  ChatListModel chatUser;
  UserChatCard({
    required this.chatUser,
  });

  @override
  State<UserChatCard> createState() => _UserChatCardState();
}

class _UserChatCardState extends State<UserChatCard> {
  final chatController = Get.find<ChatController>();
  final myProfileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: size.width,
          child: Slidable(
            key: ValueKey(widget.chatUser.chatId),
            // startActionPane: ActionPane(
            //   extentRatio: 0.2,
            //   motion: const ScrollMotion(),
            //   children: [
            //     Expanded(
            //       child: InkWell(
            //         onTap: () {
            //           if (widget.chatUser.pin == 0) {
            //             chatController.pinChat(widget.chatUser);
            //           } else {
            //             chatController.unpinChat(widget.chatUser);
            //           }
            //           Slidable.of(context);
            //         },
            //         child: Container(
            //           height: 65,
            //           color: const Color.fromARGB(255, 66, 207, 10),
            //           alignment: Alignment.center,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               widget.chatUser.pin == 0
            //                   ? const Icon(CupertinoIcons.pin_fill,
            //                       color: Colors.white)
            //                   : const Icon(CupertinoIcons.pin_slash,
            //                       color: Colors.white),
            //               widget.chatUser.pin == 0
            //                   ? Text(
            //                       "Pin",
            //                       style: primaryfont.copyWith(
            //                           color: Colors.white, fontSize: 12),
            //                     )
            //                   : Text(
            //                       "Unpin",
            //                       style: primaryfont.copyWith(
            //                           color: Colors.white, fontSize: 12),
            //                     ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // endActionPane: ActionPane(
            //   extentRatio: 0,
            //   motion: const ScrollMotion(),
            //   children: [
            //     // Expanded(
            //     //   child: InkWell(
            //     //     onTap: () {
            //     //       chatController.muteChat(
            //     //           widget.chatUser, !widget.chatUser.isMuted);
            //     //       Slidable.of(context);
            //     //     },
            //     //     child: Container(
            //     //       height: 65,
            //     //       color: const Color.fromARGB(255, 250, 173, 30),
            //     //       alignment: Alignment.center,
            //     //       child: widget.chatUser.isMuted
            //     //           ? Column(
            //     //               crossAxisAlignment: CrossAxisAlignment.center,
            //     //               mainAxisAlignment: MainAxisAlignment.center,
            //     //               children: [
            //     //                 SvgPicture.asset(
            //     //                   "assets/icons/Moon.svg",
            //     //                   height: 20,
            //     //                   width: 20,
            //     //                   fit: BoxFit.contain,
            //     //                 ),
            //     //                 Text(
            //     //                   "Unmute",
            //     //                   style: primaryfont.copyWith(
            //     //                       color: Colors.white, fontSize: 12),
            //     //                 ),
            //     //               ],
            //     //             )
            //     //           : Column(
            //     //               crossAxisAlignment: CrossAxisAlignment.center,
            //     //               mainAxisAlignment: MainAxisAlignment.center,
            //     //               children: [
            //     //                 const Icon(CupertinoIcons.moon_fill,
            //     //                     color: Colors.white),
            //     //                 Text(
            //     //                   "Mute",
            //     //                   style: primaryfont.copyWith(
            //     //                       color: Colors.white, fontSize: 12),
            //     //                 ),
            //     //               ],
            //     //             ),
            //     //     ),
            //     //   ),
            //     // ),
            //     // Expanded(
            //     //   child: InkWell(
            //     //     onTap: () {
            //     //       // Slidable.of(context);
            //     //       // modalBottomSheetDeleteChat(
            //     //       //     size, context, widget.chatUser);
            //     //     },
            //     //     child: Container(
            //     //       height: 65,
            //     //       color: const Color.fromARGB(255, 250, 30, 30),
            //     //       alignment: Alignment.center,
            //     //       child: Column(
            //     //         crossAxisAlignment: CrossAxisAlignment.center,
            //     //         mainAxisAlignment: MainAxisAlignment.center,
            //     //         children: [
            //     //           const Icon(Icons.delete, color: Colors.white),
            //     //           Text(
            //     //             "Delete",
            //     //             style: primaryfont.copyWith(
            //     //                 color: Colors.white, fontSize: 12),
            //     //           ),
            //     //         ],
            //     //       ),
            //     //     ),
            //     //   ),
            //     // ),
            //     // Expanded(
            //     //   child: InkWell(
            //     //     onTap: () {
            //     //       chatController.archiveChat(widget.chatUser);
            //     //       Slidable.of(context);
            //     //     },
            //     //     child: Container(
            //     //       height: 65,
            //     //       color: const Color.fromARGB(255, 159, 160, 160),
            //     //       alignment: Alignment.center,
            //     //       child: Column(
            //     //         crossAxisAlignment: CrossAxisAlignment.center,
            //     //         mainAxisAlignment: MainAxisAlignment.center,
            //     //         children: [
            //     //           const Icon(CupertinoIcons.archivebox_fill,
            //     //               color: Colors.white),
            //     //           Text(
            //     //             "Archive",
            //     //             style: primaryfont.copyWith(
            //     //                 color: Colors.white, fontSize: 12),
            //     //           ),
            //     //         ],
            //     //       ),
            //     //     ),
            //     //   ),
            //     // ),
            //   ],
            // ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.chatUser.photo == ""
                          ? Container(
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.asset(
                                      "assets/icons/profil_img.jpeg")),
                            )
                          : Container(
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network(
                                  widget.chatUser.photo,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 170,
                            child: Text(
                              "${widget.chatUser.firstName} ${widget.chatUser.lastName}",
                              overflow: TextOverflow.ellipsis,
                              style: primaryfont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (widget.chatUser.messageType == MessageType().text)
                            SizedBox(
                                width: size.width * 0.63,
                                child: Text(
                                  widget.chatUser.message,
                                  style: primaryfont.copyWith(
                                      color: Colors.black45, fontSize: 12),
                                )),
                          if (widget.chatUser.messageType ==
                              MessageType().activity)
                            SizedBox(
                                width: size.width * 0.63,
                                child: Text(
                                  "Shared an Activity",
                                  style: primaryfont.copyWith(
                                      color: Colors.black45, fontSize: 12),
                                )),
                          if (widget.chatUser.messageType ==
                              MessageType().reserved)
                            SizedBox(
                                width: size.width * 0.63,
                                child: Text(
                                  "Reserved an Activity",
                                  style: primaryfont.copyWith(
                                      color: Colors.black45, fontSize: 12),
                                )),
                          if (widget.chatUser.messageType ==
                              MessageType().image)
                            SizedBox(
                                width: size.width * 0.63,
                                child: Text(
                                  "Image",
                                  style: primaryfont.copyWith(
                                      color: Colors.black45, fontSize: 12),
                                )),
                          if (widget.chatUser.messageType ==
                              MessageType().profile)
                            SizedBox(
                                width: size.width * 0.63,
                                child: Text(
                                  "Shared a profile",
                                  style: primaryfont.copyWith(
                                      color: Colors.black45, fontSize: 12),
                                ))
                        ],
                      ),
                    ],
                  ),
                  //////
                  Column(
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            int.parse(widget.chatUser.updatedAt),
                          ),
                        ),
                        style: primaryfont.copyWith(
                            color: Colors.black45, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.chatUser.readStatus)
                        StreamBuilder<QuerySnapshot>(
                            stream: chatController.getUnReadCountStatus(
                                widget.chatUser.chatId,
                                myProfileController.profileData.first.user.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.docs.isNotEmpty) {
                                  return Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: kblue),
                                    alignment: Alignment.center,
                                    child: Text(
                                        snapshot.data!.docs.length.toString(),
                                        style: primaryfont.copyWith(
                                            color: Colors.white, fontSize: 13)),
                                  );
                                } else {
                                  return Container(
                                    height: 22,
                                    width: 22,
                                  );
                                }
                              } else {
                                return Container(
                                  height: 22,
                                  width: 22,
                                );
                              }
                            })
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(),
      ],
    );
  }
}
