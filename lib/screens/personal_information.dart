import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  // Updated changing Profile pic
  XFile? image;
  UploadTask? uploadTask;

  // //Changing the Profile pic
  // final ChangeProfilePic _profilePicHandler = ChangeProfilePic();
  // File? _profileImage;
  // String? _downloadUrl;
  //
  // // Callback to update UI after an image is picked and uploaded
  // void _updateProfilePicture() async{
  //   //Trigger profile picture upload
  //   await _profilePicHandler.pickAndUploadImage(ImageSource.gallery);
  //   setState(() {
  //     //was _profileImage
  //     _profileImage = _profilePicHandler.getImage();
  //     _downloadUrl = _profilePicHandler.getDownloadUrl();
  //   });
  // }
  //
  // //Uploading the profile picture to the firebase storage
  // void _uploadProfilePicture() async{
  //   await _profilePicHandler.pickAndUploadImage(ImageSource.gallery);
  //   String? imageUrl = _profilePicHandler.getDownloadUrl();
  //   if(imageUrl != null){
  //     print('Uploaded Image URL: $imageUrl');
  //   }
  // }
  String? profileImageUrl;

  @override
  void initState(){
    super.initState();
    final username = authService.getUserName();
    final userEmail = authService.getCurrentUserEmail();
    _loadProfileImageUrl();
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

  Future<void> _pickImage() async {
    final picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture != null) {
      setState(() {
        image = picture;
      });
      await _saveImage(); // Save the image after picking it
    }
  }

  //This function loads the image from firebase Storage
  Future<void> _loadProfileImageUrl()async{
    final userDoc = await FirebaseFirestore.instance
        .collection('userData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      profileImageUrl = userDoc.data()?['profileImageUrl'];
    });
  }
  //Save image
  Future<void> _saveImage()async{
    if (image == null) return;
    try{
      final ref = FirebaseStorage.instance
          .ref()
          .child("images/${image!.name}");

      uploadTask = ref.putFile(File(image!.path));
      final snapshot = await uploadTask!.whenComplete(() => null);

      //Getting the download URL to Firebase
      final downloadUrl = await snapshot.ref.getDownloadURL();
      // Save the download URL to Firebase
      await FirebaseFirestore.instance
          .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'profileImageUrl': downloadUrl});
    }catch (e){
      print('Error uploading image: $e');
    }
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
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: profileImageUrl != null
                              ? NetworkImage(profileImageUrl!)
                              : null, // No image if profileImageUrl is null
                          child: profileImageUrl == null // Show icon if no image is available
                              ? Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey.shade800,
                          )
                              : null, // No child if image is available
                        ),

                        SizedBox(height: 30,),
                        Container(
                            width: 225,
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
                                  onPressed: _pickImage, //Updated version of the imagepicker
                                    // //Show action sheet to choose image source
                                    // _profilePicHandler.showImageSourceActionSheet(context, _updateProfilePicture);


                                  child: Text('Choose Picture',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'FontsFree',
                                      fontWeight: FontWeight.normal,
                                    ),),
                                )
                            )
                        ),
                        SizedBox(height: 15,),
                        Container(
                          width: 250,
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
                          child: TextButton(
                            onPressed: _saveImage,
                            child: Text("Save Profile picture",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'FontsFree',
                                fontWeight: FontWeight.normal,
                              ),)

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
                                  child: Text('Reset Password',
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


