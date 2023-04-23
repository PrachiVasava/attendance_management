import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Controller/Session_controller.dart';
import 'package:hrms/constant/app_colors.dart';
import 'package:hrms/services/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileController with ChangeNotifier{

  DatabaseReference ref= FirebaseDatabase.instance.ref().child('users');

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  bool _loading =false;
  bool get loading => _loading;
  setLoading(bool value){
    _loading =value;
    notifyListeners();
  }

  Future pickGalleryImage(BuildContext context) async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
    if(pickedFile!= null){
      _image = XFile(pickedFile.path);
      notifyListeners();
      uploadImage(context);
    }
  }
  Future pickCameraImage(BuildContext context) async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera,imageQuality: 100);
    if(pickedFile!= null){
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }


  void pickImage(context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Container(
          height: 120,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  pickCameraImage(context);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.camera,color:AppColors.primary ,),
                title:  Text('Camera'),
              ),
              ListTile(
                onTap: () {
                  pickGalleryImage(context);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.image,color:AppColors.primary ,),
                title:  Text('Gallery'),
              ),
            ],

          ),
        ),
      );
    });
  }

  void uploadImage(BuildContext context) async{
    setLoading(true);

    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref("/image"+SessionController().userId.toString());

    firebase_storage.UploadTask uploadTask = storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    ref.child(SessionController().userId.toString()).update({
      "image":newUrl.toString()
    }).then((value){
      Utils.toastMessage("Profile Updated");
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace){
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }
}