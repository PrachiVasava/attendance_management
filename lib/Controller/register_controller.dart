import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Screens/homescreen.dart';
import 'package:hrms/Screens/index_homescreen.dart';
import 'package:hrms/services/utils.dart';
import 'package:provider/provider.dart';

import 'Session_controller.dart';

class registerController with ChangeNotifier{

  FirebaseAuth auth =FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");

  bool _loading =false;
  bool get loading => _loading;
  setLoading(bool value){
    _loading =value;
    notifyListeners();
  }
void signUp(String username,String email,String mobile,String password,String confirmPassword) async{
  setLoading(true);

    try{
      auth.createUserWithEmailAndPassword
        (email: email,
          password: password).then((value){
        SessionController().userId = value.user!.uid.toString();
            ref.child(value.user!.uid.toString()).set({
              'uid':value.user!.uid.toString(),
              "username": username,
              "email": value.user!.email.toString(),
              "mobile": mobile,
              "image":"",
            }).then((value) {
              setLoading(false);
              Get.offAll(const IndexHomeScreen());

            }).onError((error, stackTrace){
              setLoading(false);
              Utils.toastMessage(error.toString());
            });
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    }catch(e){
      Utils.toastMessage(e.toString());
    }

}

}