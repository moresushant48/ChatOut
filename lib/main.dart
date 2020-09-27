import 'package:chatapp/services/DatabaseMethods.dart';
import 'package:chatapp/views/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatefulWidget {
  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> with WidgetsBindingObserver {
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Container(
            color: Colors.red,
          );
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            home: SplashScreen(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Map<String, bool> statusMap = {"status": true};
      databaseMethods.updateUserStatusByUid(
          uid: FirebaseAuth.instance.currentUser.uid, statusMap: statusMap);
    } else {
      Map<String, bool> statusMap = {"status": false};
      databaseMethods.updateUserStatusByUid(
          uid: FirebaseAuth.instance.currentUser.uid, statusMap: statusMap);
    }
  }
}
