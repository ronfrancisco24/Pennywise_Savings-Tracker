import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/constants.dart';
import 'package:savings_2/authentication/auth_service.dart';
import 'package:savings_2/authentication/reset_password.dart';
import 'change_profile_pic.dart';
import 'dart:io';


void main(){
  runApp(PersonalInfoPage());
}

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}


class _PersonalInfoPageState extends State <PersonalInfoPage>{
  // Create a TextEditingController
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  //Authenticating firebase to the personal information
  final AuthService authService = AuthService();
  //Changing the Profile pic
  final ChangeProfilePic _profilePicHandler = ChangeProfilePic();
  File? _profileImage;
  String? _downloadUrl;

  //Callback to update UI after an image is picked and uploaded
  void _updateProfilePicture() async{
    //Trigger profile picture upload
    await _profilePicHandler.pickAndUploadImage(ImageSource.gallery);
    setState(() {
      _profileImage = _profilePicHandler.getImage();
      _downloadUrl = _profilePicHandler.getDownloadUrl();
    });
  }

  //Uploading the profile picture to the firebase storage
  void _uploadProfilePicture() async{
    await _profilePicHandler.pickAndUploadImage(ImageSource.gallery);
    String? imageUrl = _profilePicHandler.getDownloadUrl();
    if(imageUrl != null){
      print('Uploaded Image URL: $imageUrl');
    }
  }


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
  //Saving changes to Firebase
  Future<void> _saveChanges()async{
    String newName = _nameController.text.trim();
    String newEmail = _emailController.text.trim();
    if (newName.isNotEmpty){
      await authService.updateDisplayName(newName);
    }
    if (newEmail.isNotEmpty){
      await authService.updateEmail(newEmail);
    }
    //Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully')),
    );
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
                        //Display the current profile image or placeholder if no image is selected
                        _profileImage != null
                        ?CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(_profileImage!),
                        )
                        :CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey.shade800,
                          )
                        ),
                        SizedBox(height: 30,),
                        Container(
                            width: 300,
                            height: 40,
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
                                  onPressed:(){
                                    //Show action sheet to choose image source
                                    _profilePicHandler.showImageSourceActionSheet(context, _updateProfilePicture);
                                    },
                                  child: Text('Change Profile Picture',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'FontsFree',
                                      fontWeight: FontWeight.normal,
                                    ),),
                                )
                            )
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
                                child: TextButton(
                                  onPressed: _saveChanges,
                                  child: Text('Save Changes',
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


