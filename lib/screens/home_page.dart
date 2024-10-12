                 import 'package:flutter/material.dart';
import '../widgets/constants.dart';
import '../authentication/sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffebedf0),
        body: SafeArea(
          child: Builder(
            // Wrap with Builder to get a proper context
            builder: (context) => Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Text(
                          'COLLABORATIVE',
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'HeyGotcha',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1 // Adjust the width of the outline
                              ..color = Color(0xff274293), // Color of the outline
                          ),
                        ),
                        Text(
                          'SAVINGS TRACKER',
                          style: TextStyle(
                              fontFamily: 'BebasNeue',
                              fontSize: 60,
                              color: Color(0xff274293)
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                            height: 350,
                            child:
                            Image.asset('images/logo.png')), // Image asset
                        SizedBox(height: 60),
                        TextButton(
                          // Gradient Button
                          onPressed: () {
                            // Navigate to the SignUpPage on button press
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 70,
                            width: 350,
                            decoration: BoxDecoration(
                              gradient: kLinearGradient,
                              borderRadius:
                              BorderRadius.circular(30), // Round corners
                            ),
                            child: Center(
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}