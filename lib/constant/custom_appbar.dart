import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Screens/index_homescreen.dart';
import 'package:hrms/constant/language_constants.dart';
import '../Screens/homescreen.dart';
import 'app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  CustomAppBar({super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 110,
        toolbarOpacity: 0.8,
        elevation: 10,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       bottomRight: Radius.circular(25),
        //       bottomLeft: Radius.circular(25)),
        // ),
        title: Text(translation(context).hrms.toUpperCase(),
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
          // IconButton(
          //   icon: const Icon(Icons.home),
          //   onPressed: () {
          //     Get.offAll(IndexHomeScreen());
          //   },
          // ),
          //(onPressed: (){}, icon:const Icon(Icons.settings),
        ],

      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
