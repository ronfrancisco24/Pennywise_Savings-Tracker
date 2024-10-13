import 'package:flutter/material.dart';
import '../widgets/constants.dart';
import 'package:savings_2/authentication/auth_service.dart';


void main(){
  runApp(PersonalInfoPage());
}

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

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


class _PersonalInfoPageState extends State <PersonalInfoPage>{
  // Create a TextEditingController
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  //Authenticating firebase to the personal information
  final AuthService authService = AuthService();


  @override
  void initState(){
    super.initState();
    final username = authService.getUserName();
    final userEmail = authService.getCurrentUserEmail();
    //Set default placeholder for debugging
    _nameController.text = '${username}';
    _emailController.text = '${userEmail}';

  }
  @override
  void dispose(){
    //Clean up the controller when widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Profile Information'),
            ),
            bottomNavigationBar: kBottomAppBar(context),
            body: ListView(
              children: [SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: Offset(0,5),
                                  )
                                ]
                            ),
                            child: kCircleAvatar),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: 300,
                          child: TextField(
                            // Name field
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Your Name',
                              hintText: 'Enter Your Name',
                              border:UnderlineInputBorder(
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: 300,
                          child: TextField(
                            // Email field
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              border:UnderlineInputBorder(
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: kLinearGradient,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.normal,
                                ),
                              ],
                            ),
                            child: Center(
                                child: TextButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResetPasswordPage(),
                                      ),
                                    );
                                  },
                                  child: Text('Forgot Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'FontsFree',
                                      fontWeight: FontWeight.normal,
                                    ),),
                                )
                            )
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: kLinearGradient,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.normal,
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text('Save Changes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'FontsFree',
                                    fontWeight: FontWeight.normal,
                                  ),)
                            )
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
              ),
              ],)
        )
    );
  }
}


