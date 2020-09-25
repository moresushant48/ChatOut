import 'package:chatapp/modal/ChatUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      return user != null ? ChatUser(userId: user.uid) : null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      return user != null ? ChatUser(userId: user.uid) : null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
