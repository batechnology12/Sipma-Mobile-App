import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simpa/constands/chat_list_constants.dart';

class ChatListModel {
  int userId;
  String userName;
  String firstName;
  String photo;
  String lastName;
  String chatId;
  String message;
  int messageType;
  int pin;
  bool isArchived;
  int unreadCount;
  bool readStatus;
  String updatedAt;
  String createdAt;
  bool isMuted;
  bool isBlocked;
  List<dynamic> users;

  ChatListModel({
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.chatId,
    required this.message,
    required this.messageType,
    required this.pin,
    required this.isArchived,
    required this.unreadCount,
    required this.readStatus,
    required this.updatedAt,
    required this.createdAt,
    required this.isBlocked,
    required this.isMuted,
    required this.users,
  });

  Map<String, dynamic> toJson() {
    return {
      ChatListConstants().userId: userId,
      ChatListConstants().userName: userName,
      ChatListConstants().firstName: firstName,
      ChatListConstants().lastName: lastName,
      ChatListConstants().photo: photo,
      ChatListConstants().chatId: chatId,
      ChatListConstants().message: message,
      ChatListConstants().messageType: messageType,
      ChatListConstants().pin: pin,
      ChatListConstants().isArchived: isArchived,
      ChatListConstants().unreadCount: unreadCount,
      ChatListConstants().readStatus: readStatus,
      ChatListConstants().updatedAt: updatedAt,
      ChatListConstants().createdAt: createdAt,
      ChatListConstants().isBlocked: isBlocked,
      ChatListConstants().isMuted: isMuted,
      ChatListConstants().users: users,
    };
  }

  factory ChatListModel.fromDocument(DocumentSnapshot documentSnapshot) {
    int userId = documentSnapshot.get(ChatListConstants().userId);
    String userName = documentSnapshot.get(ChatListConstants().userName);
    String firstName = documentSnapshot.get(ChatListConstants().firstName);
    String lastName = documentSnapshot.get(ChatListConstants().lastName);
    String photo = documentSnapshot.get(ChatListConstants().photo);
    String chatId = documentSnapshot.get(ChatListConstants().chatId);
    String message = documentSnapshot.get(ChatListConstants().message);
    int messageType = documentSnapshot.get(ChatListConstants().messageType);
    int pin = documentSnapshot.get(ChatListConstants().pin);
    bool isArchived = documentSnapshot.get(ChatListConstants().isArchived);
    int unreadCount = documentSnapshot.get(ChatListConstants().unreadCount);
    bool readStatus = documentSnapshot.get(ChatListConstants().readStatus);
    String createdAt = documentSnapshot.get(ChatListConstants().createdAt);
    String updatedAt = documentSnapshot.get(ChatListConstants().updatedAt);
    bool isBlocked = documentSnapshot.get(ChatListConstants().isBlocked);
    bool isMuted = documentSnapshot.get(ChatListConstants().isMuted);
    List<dynamic> users = documentSnapshot.get(ChatListConstants().users);

    return ChatListModel(
        userId: userId,
        userName: userName,
        firstName: firstName,
        lastName: lastName,
        photo: photo,
        chatId: chatId,
        messageType: messageType,
        message: message,
        pin: pin,
        isArchived: isArchived,
        unreadCount: unreadCount,
        readStatus: readStatus,
        createdAt: createdAt,
        users: users,
        isBlocked: isBlocked,
        isMuted: isMuted,
        updatedAt: updatedAt);
  }
}
