import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Screens/index_homescreen.dart';

import '../Screens/homescreen.dart';
import '../services/utils.dart';
import 'Session_controller.dart';

class LoginController with ChangeNotifier{
  FirebaseAuth auth =FirebaseAuth.instance;

  bool _loading =false;
  bool get loading => _loading;
  setLoading(bool value){
    _loading =value;
    notifyListeners();
  }
  void login(String email,String password) async{
    setLoading(true);

    try{
      final user = await auth.signInWithEmailAndPassword(
        email: email,
          password: password).then((value){
        SessionController().userId = value.user!.uid.toString();
        setLoading(false);
        Get.offAll(IndexHomeScreen());
        }).onError((error, stackTrace){
          setLoading(false);
          Utils.toastMessage(error.toString());
        });
    }catch(e){
      Utils.toastMessage(e.toString());
    }

  }

}