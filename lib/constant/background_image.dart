import 'package:flutter/material.dart';
import 'app_colors.dart';

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}


class _BackgroundImageState extends State<BackgroundImage> {


  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:
      Column(
        children: [
          Container(
          height: screenHeight / 4,
          width: screenWidth,
          decoration: BoxDecoration(
              color: AppColors.primary2,
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(180, 50))),
          child: const Padding(
            padding: EdgeInsets.only(top: 5),)
          ),
        ],
      )
    );
  }
}

BackgroundMobile(BuildContext context, {required String title}) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return Stack(
    children:[ Column(
      children: [
        Column(
          children: [
            Container(
                height: screenHeight / 11,
                width: screenWidth,
                decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(50, 50))),
              child: Padding(
                padding: const EdgeInsets.only(top:10),
                child: Column(
                  children: [Text(
                    title,
                  style:TextStyle(
                    fontFamily: "oswald",
                    fontSize: 28,
                    color: AppColors.white,
                  ) ,)],)
              ),
            ),
          ],
        ),
      ],
    ),
  ]);
}
BackgroundDesktop(BuildContext context, {required String title}) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return Stack(
      children:[ Column(
        children: [
          Column(
            children: [
              Container(
                height: screenHeight / 5,
                width: screenWidth,
                decoration: BoxDecoration(
                    color: AppColors.primary2,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.elliptical(80, 100))),
                child: Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: Column(
                      children: [Text(
                        title,
                        style:TextStyle(
                          fontFamily: "oswald",
                          fontSize: 28,
                          color: AppColors.white,
                        ) ,)],)
                ),
              ),
            ],
          ),
        ],
      ),
      ]);
}
