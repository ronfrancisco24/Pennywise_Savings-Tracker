import 'package:flutter/material.dart';
import 'package:savings_2/authentication/auth_service.dart';


class ResetPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter your email",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _authService.sendPasswordResetEmail(emailController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Password reset email sent!")),
                );
              },
              child: Text("Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}