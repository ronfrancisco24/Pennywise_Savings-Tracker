import 'package:firebase_auth/firebase_auth.dart';


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

}