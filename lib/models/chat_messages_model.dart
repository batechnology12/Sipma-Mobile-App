import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simpa/constands/firestoreconsts.dart';

class ChatMessages {
  int idFrom;
  int idTo;
  String timestamp;
  String content;
  bool isReaded;
  int type;

  ChatMessages(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.isReaded,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      FireStoreConstants().idFrom: idFrom,
      FireStoreConstants().idTo: idTo,
      FireStoreConstants().timestamp: timestamp,
      FireStoreConstants().content: content,
      FireStoreConstants().type: type,
      FireStoreConstants().isReaded: isReaded,
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    int idFrom = documentSnapshot.get(FireStoreConstants().idFrom);
    int idTo = documentSnapshot.get(FireStoreConstants().idTo);
    String timestamp = documentSnapshot.get(FireStoreConstants().timestamp);
    String content = documentSnapshot.get(FireStoreConstants().content);
    int type = documentSnapshot.get(FireStoreConstants().type);
    bool isReaded = documentSnapshot.get(FireStoreConstants().isReaded);

    return ChatMessages(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        isReaded: isReaded,
        type: type);
  }
}
