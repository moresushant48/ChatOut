import 'package:chatapp/services/DatabaseMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatOut"),
      ),
      body: Text("ChatROOM"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: SearchUserDelegate());
        },
      ),
    );
  }
}

class SearchUserDelegate extends SearchDelegate {
  QuerySnapshot _users;

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
                  return ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 50.0,
                    ),
                    title: Text(_users.docs[index].get("name")),
                    subtitle: Text(_users.docs[index].get("email")),
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
