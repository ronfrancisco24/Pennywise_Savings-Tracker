import 'package:flutter/material.dart';
import 'widgets/constants.dart';


void main(){
  runApp(PersonalInfoPage());
}

class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile Information'),
        ),
        bottomNavigationBar: kBottomAppBar(context),
          body: SafeArea(
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
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        width: 300,
                        child: TextField(
                          // Username field
                          decoration: InputDecoration(
                            border:UnderlineInputBorder(
                              borderSide: BorderSide(width: 5),
                            ),
                            helperText: 'Username',
                          ),
                        ),
                      )),
                  Expanded(child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 300,
                    child: TextField(
                      // Username field
                      decoration: InputDecoration(
                        border:UnderlineInputBorder(
                          borderSide: BorderSide(width: 5),
                        ),
                        helperText: 'Your Name',
                      ),
                    ),
                  )),
                  Expanded(child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 300,
                    child: TextField(
                      // Username field
                      decoration: InputDecoration(
                        border:UnderlineInputBorder(
                          borderSide: BorderSide(width: 5),
                        ),
                        helperText: 'Email',
                      ),
                    ),
                  )),
                  Expanded(child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 300,
                    child: TextField(
                      // Username field
                      decoration: InputDecoration(
                        border:UnderlineInputBorder(
                          borderSide: BorderSide(width: 5),
                        ),
                        helperText: 'Your Birthday',
                      ),
                    ),
                  )),
                  Expanded(child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 300,
                    child: TextField(
                      // Username field
                      decoration: InputDecoration(
                        border:UnderlineInputBorder(
                          borderSide: BorderSide(width: 5),
                        ),
                        helperText: 'Password',
                      ),
                    ),
                  )),
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
          )
      )
    );
  }
}
