import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:savings_2/authentication/sign_in.dart';
import 'package:savings_2/widgets/rightTrianglePainter.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';


class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text controllers
  final _auth =
      FirebaseAuth.instance; // provides access to firebase authentication
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  // final _formKey = GlobalKey<FormState>(); // identifies form widgets and allows validation.

  bool isPasswordVisibility = false;               //Manages password visibility
  bool isPasswordVisible = false;
  bool isPasswordValid = false;                    //Validates the password input
  String passwordError = '';


  Future<void> _registerUser() async {
    // if password doesnt equal to confirm password, show error
    if (passwordController.text != confirmPwController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match.'),
        ),
      );
      return;
    }

    try {
      UserCredential? userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      await userCredential.user?.updateDisplayName(usernameController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration Successful.'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffebedf0),
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            left: 0,
            right: 0,
            top: 10,
            bottom: 0,
            child: CustomPaint(
              painter: RightTrianglePainter(),
              child: Container(
              ),
            ),
          ),
          ListView(
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
                            ..strokeWidth =
                                1 // Adjust the width of the outline
                            ..color =
                                Color(0xff274293), // Color of the outline
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
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 350,
                        child: Form(
                          child: TextField(
                            controller: usernameController,
                            // Email Text Field
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Enter Username',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 350,
                        child: Form(
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
                      SizedBox(height: 20),
                      Container(
                        width: 350,
                        child: TextField(
                          controller: passwordController,
                          obscureText: !isPasswordVisibility,
                          // Password Text Field
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Enter Password',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(width: 5),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisibility =
                                    !isPasswordVisibility; // Toggle visibility
                                  });
                                },
                            ),
                          ),
                          onChanged: (value){
                             _validatePassword(value);
                          },
                        ),
                      ),
                      if (passwordError.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 37.0, right: 5.0, bottom: 1.0),
                          child: Text(passwordError,
                          style: TextStyle(color: Colors.red),),
                        ),
                      SizedBox(height: 20),
                      Container(
                        width: 350,
                        child: TextField(
                          controller: confirmPwController,
                          obscureText: !isPasswordVisible ,
                          // Confirm Password Text Field
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Confirm Password',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(width: 5),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible =
                                  !isPasswordVisible; // Toggle visibility
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the SignInPage on button press
                          _registerUser();
                          print(usernameController.text);
                          print(emailController.text);
                          print(passwordController.text);
                          print(confirmPwController.text);
                        },
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff264193),
                                Color(0xff81bed4)
                              ], // Define gradient colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius:
                                BorderRadius.circular(30), // Round corners
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
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
                              Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  // Navigate to the HomePage on button press
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                                icon: Icon(Icons.g_mobiledata_rounded),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ]),
      ),

    );
  }
  void _validatePassword(String password) {  //Conditions to set the validation of passwords
    String error = '';

    if (password.length < 6) {
      error += 'Must be at least 6 characters long.\n';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      error += 'Must have one uppercase letter.\n';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      error += 'Must have a number digit.\n';
    }
    if (!password.contains(RegExp(r'[!@#\$&*~]'))) {
      error += 'Must have one special character.\n';
    }

    setState(() {
      passwordError = error;
      isPasswordValid = error.isEmpty;
    });
  }
  }



class RightTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size){
    drawRightTriangle(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}