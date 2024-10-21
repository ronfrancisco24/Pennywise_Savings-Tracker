import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // updates the password of the user.
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

  //Update the display name of the user
  Future<void> updateDisplayName(String displayName) async{
    User? user = _auth.currentUser;
    if(user != null){
      try{
        await user.updateProfile(displayName: displayName);
        await user.reload(); //Reload the user to apply changes
        print("Display name updated to: $displayName");
      }catch(e){
        print("Failed to update Display Name: $e");
      }
    }
  }
  //Update the email of the user
  Future<void> updateEmail(String email)async{
    User? user = _auth.currentUser;
    if(user !=null){
      try{
        await user.updateEmail(email);
        await user.reload(); //Reloads to apply changes
        print("Email updated to: $email");
      } catch(e){
        print("Failed to updated Email: $e");
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


  // Method to send an invite
  Future<void> sendInvite(String recipientEmail) async {
    // Get the current user's ID
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      print("User is not authenticated. Cannot send invite.");
      return;
    }

    String senderId = currentUser.uid; // Use userId from Firebase Auth
    try {
      // Create an invite document
      await _firestore.collection('invites').add({
        'senderId': senderId,
        'recipientEmail': recipientEmail,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Invite sent to $recipientEmail from $senderId");
    } catch (e) {
      print("Failed to send invite: $e");
      // Handle error (e.g., show an alert or snackbar)
    }
  }
}