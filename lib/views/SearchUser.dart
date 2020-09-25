import 'package:chatapp/services/DatabaseMethods.dart';
import 'package:chatapp/views/Coversation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchUserDelegate extends SearchDelegate {
  QuerySnapshot _users;
  final databaseMethods = DatabaseMethods();

  createChatRoomAndStartConversation(BuildContext context, String username) {
    String myName = FirebaseAuth.instance.currentUser.displayName;
    String chatRoomId = getChatRoomId(username, myName);
    List<String> users = [username, myName];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Conversation(),
        ));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > a.substring(0, 1).codeUnitAt(0))
      return "$b\_$a";
    else
      return "$a\_$b";
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    DatabaseMethods databaseMethods = DatabaseMethods();

    return StatefulBuilder(
      builder: (context, setState) {
        databaseMethods.getUserByUsername(query).then((searchedUsers) {
          setState(() {
            _users = searchedUsers;
          });
        });
        return _users != null
            ? ListView.builder(
                itemCount: _users.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => createChatRoomAndStartConversation(
                        context, _users.docs[index].get("name")),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 50.0,
                      ),
                      title: Text(_users.docs[index].get("name")),
                      subtitle: Text(_users.docs[index].get("email")),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("");
  }
}
