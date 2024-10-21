import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:savings_2/data/firebase_data.dart';
import 'package:savings_2/authentication/auth_service.dart';

class SendInviteScreen extends StatefulWidget {
  @override
  _SendInviteScreenState createState() => _SendInviteScreenState();
}

class _SendInviteScreenState extends State<SendInviteScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseData firebaseData = FirebaseData(); // instance of firebase class
  final AuthService authService = AuthService(); // instance of auth service

  Future<void> _sendInvite() async {
    User? currentUser = authService.getCurrentUser();

    if (currentUser != null && _emailController.text.isNotEmpty) {
      String senderId = currentUser.uid; // Get userId from the current user
      String senderEmail = currentUser.email ?? "unknown";

      await firebaseData.sendFriendInvite(
        senderId: senderId,
        recipientEmail: _emailController.text,
        senderName: senderEmail,
      );

      // Feedback to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invite sent to ${_emailController.text}!')),
      );
    } else {
      // Handle cases where userId or email might be null
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send invite. Please check your input.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Friend Invite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Friend\'s Email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendInvite,
              child: Text('Send Invite'),
            ),
          ],
        ),
      ),
    );
  }
}
