import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/view/public_profle_view/public_user_profile_view.dart';
import 'package:simpa/widgets/search_field.dart';

class SearchFriends extends StatefulWidget {
  const SearchFriends({super.key});

  @override
  State<SearchFriends> createState() => _SearchFriendsState();
}

class _SearchFriendsState extends State<SearchFriends> {
  var searchtextController = TextEditingController();

  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    clearInitilDatas();
    profileController.searchUser("");
    searchtextController.addListener(searchUsers);
  }

  clearInitilDatas() async {
    profileController.searchFriendsList.clear();
    profileController.update();
  }

  searchUsers() {
    if (searchtextController.text.isNotEmpty) {
      profileController.searchUser(searchtextController.text);
    } else {
      // profileController.searchFriendsList.clear();
      profileController.searchUser("");
    }
    profileController.update();
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
            Get.back();
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
      body: GetBuilder<ProfileController>(builder: (_) {
        return profileController.friendsearchLoading.value
            ? Center(child: CircularProgressIndicator())
            : profileController.searchFriendsList.isEmpty
                ? Center(child: Text("No Data"))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: profileController.searchFriendsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => PublicUserProfilePage(
                                userId: profileController
                                    .searchFriendsList[index].friendId,
                              ));
                        },
                        child: Card(
                          child: Stack(
                            children: [
                              ListTile(
                                leading: profileController
                                            .searchFriendsList[index].profile ==
                                        null
                                    ? const CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(
                                            'assets/icons/profil_img.jpeg'),
                                      )
                                    : CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            profileController
                                                .searchFriendsList[index]
                                                .profile),
                                      ),
                                title: Text(profileController
                                        .searchFriendsList[index].name)
                                    .animate()
                                    .fade()
                                    .scale(),
                                subtitle: Text(profileController
                                            .searchFriendsList[index]
                                            .designation ??
                                        "")
                                    .animate()
                                    .fade()
                                    .scale(),
                              ),
                              if (profileController
                                      .searchFriendsList[index].isFriend ==
                                  false)
                                Positioned(
                                  bottom: 15,
                                  right: 6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          profileController.sendRequest(
                                              userId: profileController
                                                  .searchFriendsList[index]
                                                  .friendId
                                                  .toString(),
                                              index: index);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              color: kblue),
                                          child: Center(
                                              child: Text(
                                            "Add Friend",
                                            style: TextStyle(
                                                color: kwhite,
                                                fontWeight: FontWeight.w600),
                                          )),
                                        ),
                                      ),
                                      kwidth10,
                                      // ksizedbox10,
                                      // Container(
                                      //   child: Center(
                                      //       child: Text(
                                      //     "Remove",
                                      //     style: TextStyle(
                                      //         color: kblue,
                                      //         fontWeight: FontWeight.w600),
                                      //   )),
                                      //   height: 30,
                                      //   width: 80,
                                      //   decoration: BoxDecoration(
                                      //       border: Border.all(color: kblue, width: 1),
                                      //       borderRadius: BorderRadius.circular(17),
                                      //       color: kwhite),
                                      // ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  );
      }),
    );
  }
}
