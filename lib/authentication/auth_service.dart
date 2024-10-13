import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //get current email
  String? getCurrentUserEmail(){
    return _auth.currentUser?.email;
  }

  //Forgot Password
  Future<void> sendPasswordResetEmail(String email)async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e){
      print(e);
      //Add a potential handling of error like a snackbar or alert
    }
  }
  Future<void> updatePassword(String newPassword) async{
    User? user = _auth.currentUser;
    if(user != null){
      try{
        await user.updatePassword(newPassword);
      }catch (e){
        print(e);
        //Add a potential handling of error like a snackbar or alert
      }
    }
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