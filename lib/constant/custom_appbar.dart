import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Screens/index_homescreen.dart';
import '../Screens/homescreen.dart';
import 'app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;

  CustomAppBar({super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        toolbarOpacity: 0.8,
        elevation: 10,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       bottomRight: Radius.circular(25),
        //       bottomLeft: Radius.circular(25)),
        // ),
        title: Text(title.toUpperCase(),
            style: const TextStyle(
                letterSpacing: 1)),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Get.offAll(IndexHomeScreen());
            },
          ),
          //(onPressed: (){}, icon:const Icon(Icons.settings),
        ],

      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
