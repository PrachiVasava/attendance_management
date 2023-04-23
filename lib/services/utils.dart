import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrms/constant/app_colors.dart';

class Utils{
  static void fieldFocus(BuildContext context,FocusNode currentNode,FocusNode nextFocus){
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.grey,
      textColor: AppColors.white,
      fontSize: 15,
    );
  }
}

