import 'package:flutter/material.dart';
import 'package:savings_2/authentication/sign_up.dart';
import 'package:savings_2/widgets/constants.dart';
import '../screens/tracker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _auth = FirebaseAuth.instance;
  // provides access to firebase authentication
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  Future<void> _loginUser() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print('Login Successful.');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TrackerPage()),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffebedf0),
      body: SafeArea(
        child: Stack(children: [
          CustomPaint(
            painter: RightTrianglePainter(),
            child: Container(),
          ),
          ListView(
            children: [
              Padding(
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
                          color: Color(0xff274293)),
                    ),
                    Container(
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 20),
                          SizedBox(
                            width: 150,
                            height: 200,
                            child: Image.asset('images/logo.png'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(width: 80),
                            Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  width: 350,
                  child: TextField(
                    controller: emailController,
                    // Email Text Field
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter Email',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 350,
                  margin: EdgeInsets.only(bottom: 30),
                  child: TextField(
                    // Password Text Field
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Enter Password',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to the TrackerPage on button press
                  _loginUser();
                },
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    gradient: kLinearGradient,
                    borderRadius: BorderRadius.circular(30), // Round corners
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.facebook),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.computer),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}


class RightTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xff274293), Colors.white], // Define the gradient colors
        begin: Alignment.topLeft, // Starting point of the gradient
        end: Alignment.bottomRight, // Ending point of the gradient
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 300); // Start at top-left
    path.lineTo(size.width * 1.5, size.height * 0.8); // Mid-right
    path.lineTo(size.width, size.height * 0.8); // Extend to the right edge
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(0, size.height); // Bottom-left
    path.close(); // Connect back to top-left

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
