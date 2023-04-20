
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hrms/Screens/register_user.dart';
import 'package:hrms/constant/app_colors.dart';
import '../Screens/index_homescreen.dart';



class auth_page extends StatefulWidget {
  const auth_page({Key? key}) : super(key: key);

  @override
  State<auth_page> createState() => _auth_pageState();
}

class _auth_pageState extends State<auth_page> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const IndexHomeScreen();

          } else{
            return RegisterUser();
          }
        },
  )
    );
  }
}

