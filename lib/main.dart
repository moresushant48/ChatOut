import 'package:chatapp/views/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatefulWidget {
  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
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
}
