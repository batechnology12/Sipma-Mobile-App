import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simpa/constands/chat_list_constants.dart';
import 'package:simpa/constands/firestoreconsts.dart';
import 'package:simpa/constands/message_types.dart';
import 'package:simpa/controllers/profile_controller.dart';
import 'package:simpa/models/chat_messages_model.dart';
import 'package:simpa/models/chat_models.dart';
import 'package:http/http.dart' as http;
import 'package:simpa/models/get_fcm_token_model.dart';
import 'package:simpa/services/network_api_services/auth_api_services/get_fcm_token_api_services.dart';

class ChatController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  GetFcmTokenApiService getFcmTokenApiService = GetFcmTokenApiService();

  List<String> mediaList = [];
  List<QueryDocumentSnapshot<Object?>> listMessages = [];
  List<QueryDocumentSnapshot<Object?>> chatListUsers = [];

  RxBool isPinChatIsEmpty = false.obs;
  RxBool isChatIsEmpty = false.obs;

  bool checkForEmptyChatList() {
    bool isEmpty = false;
    if (isPinChatIsEmpty.isTrue && isChatIsEmpty.isTrue) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }
    return isEmpty;
  }

  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
    return firebaseFirestore
        .collection(FireStoreConstants().pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FireStoreConstants().timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  Stream<QuerySnapshot> getMoreChatMessage(
      String groupChatId, int limit, QueryDocumentSnapshot<Object?> doc) {
    return firebaseFirestore
        .collection(FireStoreConstants().pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FireStoreConstants().timestamp, descending: true)
        .startAfterDocument(doc)
        .limit(limit)
        .snapshots();
  }

  void sendChatMessage(String content, int type, String groupChatId,
      int currentUserId, int peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    ChatMessages chatMessages = ChatMessages(
        isReaded: false,
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatMessages.toJson());
    });
  }

  updateReadStatus(String groupChatId, int peerId) async {
    var snapshots = firebaseFirestore
        .collection(FireStoreConstants().pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .where(FireStoreConstants().idTo, isEqualTo: peerId)
        .where(FireStoreConstants().isReaded, isEqualTo: false)
        .get();

    await snapshots.then((value) {
      if (value.docs.isNotEmpty) {
        String docId = value.docs[0].id;
        DocumentReference documentReference = firebaseFirestore
            .collection(FireStoreConstants().pathMessageCollection)
            .doc(groupChatId)
            .collection(groupChatId)
            .doc(docId);

        FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction
              .update(documentReference, {FireStoreConstants().isReaded: true});
        });
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUnReadCountStatus(
      String groupChatId, int peerId) {
    var snapshots = firebaseFirestore
        .collection(FireStoreConstants().pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .where(FireStoreConstants().idTo, isEqualTo: peerId)
        .where(FireStoreConstants().isReaded, isEqualTo: false)
        .snapshots();

    return snapshots;
  }

  void addToChatList(ChatListModel chatList) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatList.toJson());
    });
  }

  void updateTheChatList(ChatListModel chatList) {
    firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}")
        .set(chatList.toJson());
  }

  void updateCurrentTheChatList(ChatListModel chatList) {
    firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}")
        .set(chatList.toJson());
  }

  void makeActiveUser(
      {required String chatId, required String userId, required bool status}) {
    firebaseFirestore
        .collection(FireStoreConstants().pathActiveUserCollection)
        .doc(chatId)
        .collection(userId)
        .doc(chatId)
        .set({
      FireStoreConstants().isUserActive: status,
      FireStoreConstants().timestamp: DateTime.now().toIso8601String(),
    });
  }

  makeAsRead(int fromId, int toId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("$fromId$toId");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction
          .update(documentReference, {ChatListConstants().readStatus: false});
    });
  }

  acceptRequest(int fromId, int toId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("$fromId$toId");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(documentReference, {ChatListConstants().pin: 0});
    });
  }

  archiveChat(ChatListModel chatList) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction
          .update(documentReference, {ChatListConstants().isArchived: true});
    });
  }

  muteChat(ChatListModel chatList, bool isMuted) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction
          .update(documentReference, {ChatListConstants().isMuted: isMuted});
    });
  }

  blockUser(ChatListModel chatList, bool isBlocked) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(
          documentReference, {ChatListConstants().isBlocked: isBlocked});
    });
  }

  unArchiveChat(ChatListModel chatList) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction
          .update(documentReference, {ChatListConstants().isArchived: false});
    });
  }

  pinChat(ChatListModel chatList) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(documentReference, {ChatListConstants().pin: 1});
    });
  }

  acceptChatreq(ChatListModel chatList) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}");
    print("Id Hereererererererererererererererererererererere");
    print("${chatList.userId}${chatList.users.first}");
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(documentReference, {ChatListConstants().pin: 0});
    });
  }

  unpinChat(ChatListModel chatList) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(documentReference, {ChatListConstants().pin: 0});
    });
  }

  deleteChat(ChatListModel chatList) {
    DocumentReference cdocumentReference = firebaseFirestore
        .collection(FireStoreConstants().pathMessageCollection)
        .doc(chatList.chatId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.delete(cdocumentReference);
    });

    DocumentReference documentReference = firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .doc("${chatList.userId}${chatList.users.first}");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.delete(documentReference);
    });
  }

  Stream<QuerySnapshot> getChatList(int currentUserId, int limit) {
    return firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .where(ChatListConstants().users, arrayContains: currentUserId)
        .orderBy(ChatListConstants().updatedAt, descending: true)
        .limit(limit)
        .snapshots();
  }

  Stream<QuerySnapshot> getUnreadCound(int currentUserId) {
    return firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .where(ChatListConstants().users, arrayContains: currentUserId)
        .where(ChatListConstants().readStatus, isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getMoreChatList(
      int currentUserId, int limit, QueryDocumentSnapshot<Object?> doc) {
    return firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .where(ChatListConstants().users, arrayContains: currentUserId)
        .orderBy(ChatListConstants().updatedAt, descending: true)
        .startAfterDocument(doc)
        .limit(limit)
        .snapshots();
  }

  Stream<QuerySnapshot> getChatUnreadCount(int currentUserId) {
    return firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .where(ChatListConstants().users, arrayContains: currentUserId)
        .where(ChatListConstants().isArchived, isEqualTo: false)
        .where(ChatListConstants().readStatus, isEqualTo: true)
        .orderBy(ChatListConstants().updatedAt, descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getPinned(int currentUserId, int limit) {
    return firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .where(ChatListConstants().users, arrayContains: currentUserId)
        .where(ChatListConstants().isArchived, isEqualTo: false)
        .where(ChatListConstants().pin, isEqualTo: 1)
        .orderBy(ChatListConstants().updatedAt, descending: true)
        .limit(limit)
        .snapshots();
  }

  Stream<QuerySnapshot> getChatRequest(int currentUserId, int limit) {
    return firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .where(ChatListConstants().users, arrayContains: currentUserId)
        .where(ChatListConstants().isArchived, isEqualTo: false)
        .where(ChatListConstants().pin, isEqualTo: 3)
        .orderBy(ChatListConstants().updatedAt, descending: true)
        .limit(limit)
        .snapshots();
  }

  Stream<QuerySnapshot> getArchivedChatList(int currentUserId, int limit) {
    return firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .where(ChatListConstants().users, arrayContains: currentUserId)
        .where(ChatListConstants().isArchived, isEqualTo: true)
        .orderBy(ChatListConstants().updatedAt, descending: true)
        .orderBy(ChatListConstants().pin, descending: true)
        .limit(limit)
        .snapshots();
  }

  Future checkAlreadyChated(
    String chatId,
    ChatListModel chatList,
    ChatListModel mychatList,
  ) async {
    var docs = await firebaseFirestore
        .collection(FireStoreConstants().pathChatListcollection)
        .where(ChatListConstants().chatId, isEqualTo: chatId)
        .get();

    print(docs.docs.length);
    if (docs.docs.isEmpty) {
      addToChatList(chatList);
      addToChatList(mychatList);
    }
  }

  void onSendMessage(String content, int type,
      {required ChatListModel chatModel, required int peerId}) {
    final myProfileController = Get.find<ProfileController>();
    if (content.trim().isNotEmpty) {
      sendChatMessage(content, type, chatModel.chatId,
          myProfileController.profileData.first.user.id, peerId);

      ChatListModel currentUserchatModel = ChatListModel(
          userId: myProfileController.profileData.first.user.id,
          firstName: myProfileController.profileData.first.user.name,
          lastName: myProfileController.profileData.first.user.lastName,
          photo: myProfileController.profileData.first.user.profilePicture,
          pin: chatModel.pin,
          isArchived: chatModel.isArchived,
          userName: myProfileController.profileData.first.user.userName,
          chatId: chatModel.chatId,
          unreadCount: 1,
          message: content,
          messageType: type,
          readStatus: true,
          isBlocked: chatModel.isBlocked,
          isMuted: chatModel.isMuted,
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
          users: [
            chatModel.userId,
          ]);

      // chatController.checkAlreadyChated(
      //     widget.chatModel.chatId, widget.chatModel, currentUserchatModel);
      updateTheChatList(chatModel);
      updateTheChatList(currentUserchatModel);

      String message = "";

      if (type == MessageType().text) {
        message = content;
      } else if (type == MessageType().activity) {
        message = "Shared an activity";
      } else if (type == MessageType().image) {
        message = "Shared an image";
      } else if (type == MessageType().reserved) {
        message = "Reserved an activity";
      }

      sendNotification(
          peerId.toString(),
          "${myProfileController.profileData.first.user.name} ${myProfileController.profileData.first.user.lastName}",
          message,
          chatModel.chatId);
    } else {
      print("nothing to send");
    }
  }

  sendNotification(
      String userId, String title, String message, String chatId) async {
    var response =
        await getFcmTokenApiService.fcmTokenStoreApiService(id: userId);

    var docs = await firebaseFirestore
        .collection(FireStoreConstants().pathActiveUserCollection)
        .doc(chatId)
        .collection(userId)
        .doc(chatId)
        .get();

    if (docs.exists) {
      if (docs[FireStoreConstants().isUserActive] == false &&
          docs[FireStoreConstants().timestamp] !=
              DateTime.now().toIso8601String()) {
        print("printing response >>>>>>>>>>>>");
        print(response);

        GetFcmModel getFcmModel = GetFcmModel.fromJson(response.data);

        sendPushMessage(message, title, getFcmModel.list.first, userId, chatId);
      }
    } else {
      print("printing response >>>>>>>>>>>>");
      print(response);

      GetFcmModel getFcmModel = GetFcmModel.fromJson(response.data);

      sendPushMessage(message, title, getFcmModel.list.first, userId, chatId);
    }
  }

  // Future<String> uploadChatImage(File image) async {
  //   var response = await updateChatImageApi.updatechatImageApi(image);

  //   String chatImage = response["chat_image"];
  //   return chatImage;
  // }

  void sendPushMessage(String body, String title, String token, String peerId,
      String chatId) async {
    try {
      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAANHrN_50:APA91bEIWgf8ELvUnLQfZZOvFaijGm3q2mj2Sgg8LfmKY7QfyDNU36LYUWUrxKUu4uoHui2tPU3SH3Wr64o0kx-5huPIN0cmXLqiQiPtYAXtxIj-acv1a4WXVse6vpcT-i1dDu-m25do',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'type': 'chat',
              'model': 'Chat',
              'id': chatId,
              "from_id": peerId,
              "to_id": "1",
              'body': body,
              'title': title,
            },
            "to": token,
          },
        ),
      );

      print("-------------------notification send----------------------");
      print(response.statusCode);
      print(response.body);

      // NotificationData notificationData = NotificationData(
      //     createdAt: DateTime.now(),
      //     id: 0,
      //     message: Message(
      //         data: Data(
      //           fromId: peerId,
      //           model: 'Chat',
      //           modelId: chatId,
      //           toId: "1",
      //           type: 'chat',
      //         ),
      //         notification: nt.Notification(
      //             body: body,
      //             title: title + " Sended you a message",
      //             image: Get.find<MyProfileContainer>().profileDatas.photo),
      //         token: token),
      //     readed: false,
      //     updatedAt: DateTime.now(),
      //     userId: peerId);
      // var reposne = await sendNotificationApi.sendNotificationService(
      //     notification: notificationData);
      // print(reposne);
    } catch (e) {
      print("error push notification");
    }
    // }

    // blockUserInApp(int userId) async {
    //   var response = await blockUserApi.blockUserApi(userId);
    //   print(response);
    // }

    // unBlockUserApi(int userId) async {
    //   var response = await unblockUserApi.unblockUserApi(userId);
    //   print(response);
    // }
  }
}
