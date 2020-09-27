import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  uploadUserInfo({String uid, userMap}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  updateUserStatusByUid({String uid, statusMap}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update(statusMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      e.toString();
    });
  }

  getChatRooms(String username) async {
    return await FirebaseFirestore.instance
        .collection("chatroom")
        .where("users", arrayContains: username)
        .snapshots();
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      e.toString();
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }
}
