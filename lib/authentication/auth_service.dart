import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // is user signed in
  bool isUserSignedIn(){
    return _auth.currentUser != null;
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // display name
  String? getUserName() {
    return _auth.currentUser?.displayName;
  }

}