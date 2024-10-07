import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savings_2/screens/home_page.dart';
import '../screens/tracker.dart';


class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TrackerPage();
            } else {
              return HomePage();
            }
          }
      ),
    );
  }
}