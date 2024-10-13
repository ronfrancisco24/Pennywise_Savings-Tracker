import 'package:flutter/material.dart';
import '../widgets/constants.dart';


void main(){
  runApp(PersonalInfoPage());
}

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State <PersonalInfoPage>{
  // Create a TextEditingController
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void initState(){
    super.initState();
    //Set default username for debugging
    _nicknameController.text = "TEST NICKNAME";
    _nameController.text = "TEST NAME";
    _emailController.text = "TESTEMAIL@email.com";
    _passwordController.text = "TEST PASSWORD";

  }
  @override
  void dispose(){
    //Clean up the controller when widget is disposed.
    _nicknameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                            // Username field
                            controller: _nicknameController, //Setting the controller
                            decoration: InputDecoration(
                              labelText: 'Nickname',
                              hintText: 'Enter Your Nickname',
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
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: 300,
                          child: TextField(
                            // Password field
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your Password',
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
                            // Birthday field
                            decoration: InputDecoration(
                              labelText: 'Your Birthday',
                              hintText: 'Enter Your Birthday',
                              border:UnderlineInputBorder(
                                borderSide: BorderSide(width: 5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
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


