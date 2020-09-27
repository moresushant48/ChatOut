import 'package:chatapp/services/DatabaseMethods.dart';
import 'package:chatapp/views/Coversation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchUserDelegate extends SearchDelegate {
  final databaseMethods = DatabaseMethods();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

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
          builder: (context) => Conversation(chatRoomId),
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

    return FutureBuilder(
      future: databaseMethods.getUserByUsername(query),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => createChatRoomAndStartConversation(
                        context, snapshot.data.docs[index].get("username")),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 50.0,
                      ),
                      title: Text(snapshot.data.docs[index].get("username")),
                      subtitle: Text(snapshot.data.docs[index].get("email")),
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
