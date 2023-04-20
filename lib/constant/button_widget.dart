import 'package:flutter/material.dart';
import 'app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;

  const ButtonWidget({Key? key, required this.text, required this.onClicked, required this.color}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double screenHeight = 0;
    double screenWidth = 0;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        height: screenHeight / 15,
        width: screenWidth,
        margin:
        EdgeInsets.only(top: screenWidth / 30, right: 20, left: 20),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: screenWidth / 25,
                color: AppColors.white,
                letterSpacing: 2),
          ),

        ),
      ),
    );
  }
}
