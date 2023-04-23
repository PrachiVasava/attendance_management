
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Controller/Session_controller.dart';
import 'package:hrms/Screens/login_screen.dart';
import 'package:hrms/Screens/register_user.dart';
import 'package:hrms/constant/app_colors.dart';
import '../Screens/index_homescreen.dart';



class SplashServices{

  void isLogin(BuildContext context){
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      SessionController().userId = user.uid.toString();
      Timer(Duration(seconds: 3), () => Get.offAll(IndexHomeScreen()));
    }
    else{
      Timer(Duration(seconds: 3), () => Get.offAll(LoginScreen()));
    }
  }

}

//     extends StatefulWidget {
//   const auth_page({Key? key}) : super(key: key);
//
//   @override
//   State<auth_page> createState() => _auth_pageState();
// }
//
// class _auth_pageState extends State<auth_page> {
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.blue,
//         body: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return const IndexHomeScreen();
//
//             } else{
//               return RegisterUser();
//             }
//           },
//         )
//     );
//   }
// }

