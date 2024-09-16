
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/notification_model.dart';
import 'package:simpa/view/from_notification_view/notification_comment_view.dart';
import 'package:simpa/view/from_notification_view/notification_reaction_screen_view.dart';
import 'package:simpa/view/public_profle_view/public_user_profile_view.dart';
import 'package:simpa/widgets/bottumnavigationbar.dart';

class Notificaton_screen extends StatefulWidget {
  const Notificaton_screen({super.key});

  @override
  State<Notificaton_screen> createState() => _Notificaton_screenState();
}

class _Notificaton_screenState extends State<Notificaton_screen> {
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.getNotificationList();
  }

  redirectToPages({dynamic response}) async {
    NotificationDataModel notificationModel =
        NotificationDataModel.fromJson(response);

    if (notificationModel.type == "like_Post") {
      Get.offAll(NotficationReactionView(
        likeCount: 100,
        postId: int.parse(notificationModel.id.toString()),
      ));
    } else if (notificationModel.type == "comment_Post") {
      Get.offAll(() => NotoficationCommentView(
            postId: int.parse(notificationModel.id.toString()),
          ));
    } else if (notificationModel.type == "Friend_Request") {
      Get.offAll(() => BottomNavigationBarExample(
            index: 1,
          ));
    } else if (notificationModel.type == "Friend_Request_accepted") {
      Get.offAll(() => BottomNavigationBarExample(
            index: 1,
          ));
    } else {
      Get.offAll(() => BottomNavigationBarExample());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,
        title: const Text(
          'Notification',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: GetBuilder<ProfileController>(builder: (_) {
        return profileController.notificationList.isEmpty
            ? const Center(
                child: Text("No Data"),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: profileController.notificationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          var data = profileController
                              .notificationList[index].data
                              .toJson();

                          profileController.mmarkNotificationAsRead(
                              notificationId:
                                  profileController.notificationList[index].id);

                          redirectToPages(response: data);
                        },
                        child: ListTile(
                          leading: profileController.notificationList[index]
                                      .data.profilePicture ==
                                  ""
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => PublicUserProfilePage(
                                          userId: profileController
                                              .notificationList[index].data.id,
                                        ));
                                  },
                                  child: const CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage(
                                          'assets/icons/profil_img.jpeg')),
                                )
                              : CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      profileController.notificationList[index]
                                          .data.profilePicture)),
                          // title: Row(
                          //   children: [
                          //     Text(
                          //       profileController.notificationList[index].title,
                          //       style: const TextStyle(
                          //           fontWeight: FontWeight.w700),
                          //     ).animate().fade().scale(),
                          //   ],
                          // ),
                          title: Text(
                            profileController.notificationList[index].message,
                            style: primaryfont.copyWith(
                                fontSize: 14, color: Colors.black54),
                          ),
                          trailing: const Text(
                            '',
                            style: TextStyle(fontSize: 10),
                          ).animate().fade().scale(),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                ),
              );
      }),
    );
  }
}
