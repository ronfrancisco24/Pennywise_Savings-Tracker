import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChangeProfilePic {
  File? _image;
  String? _downloadUrl;
  UploadTask? _uploadTask;

// Image picker function with improved error handling
  Future<void> _pickImage(ImageSource source) async {
    try {
      // Pick image from the specified source (camera or gallery)
      final pickedFile = await ImagePicker().pickImage(source: source);

      // Check if the user actually picked a file (or if the action was canceled)
      if (pickedFile == null) {
        print('No image selected or operation canceled.');
        return; // Return early if no image was selected
      }

      // Check if the file path is valid and accessible
      if (pickedFile.path.isNotEmpty) {
        File? croppedImage = await _cropImage(File(pickedFile.path));

        if (croppedImage != null) {
          _image = croppedImage;

          // Proceed to upload the image to Firebase storage
          await _uploadImageToFirebase(_image!);
          print('Image successfully uploaded.');
        } else {
          print('Image cropping canceled or failed.');
        }
      } else {
        print('Invalid file path or file not accessible.');
      }
    } catch (e) {
      // Catch and print any errors that occur during the image picking process
      print('Error picking image: $e');
    }
  }

// Public method to expose _pickImage for personal_information
  Future<void> pickAndUploadImage(ImageSource source) async {
    await _pickImage(source); // Calls the private method
  }



//Image cropping function
  Future<File?> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path);
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

//Function for uploading image to Firebase Storage
  Future<void> _uploadImageToFirebase(File imageFile) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final ref = storage.ref().child('profile_pictures/${_image!
        .path}'); //directory path for firebase storage
    _uploadTask = ref.putFile(imageFile);
    TaskSnapshot? snapshot = await _uploadTask?.whenComplete(() => {});
    _downloadUrl = await snapshot?.ref.getDownloadURL();
    print('Image uploaded successfully. URL: $_downloadUrl');
  }

  File? getImage() {
    return _image;
  }

  String? getDownloadUrl() {
    print('PROFILE PICTURE: $_downloadUrl');
    return _downloadUrl;
  }

// Function to show bottom sheet for image source selection
  void showImageSourceActionSheet(BuildContext context,
      void Function() callback) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.gallery);
                  callback();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.camera);
                  callback();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

