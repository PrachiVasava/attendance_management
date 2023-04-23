import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrms/Screens/attendance_screen.dart';
import 'package:hrms/constant/app_colors.dart';
import 'homescreen.dart';
import 'profile_screen.dart';

class IndexHomeScreen extends StatefulWidget {
  const IndexHomeScreen({Key? key}) : super(key: key);

  @override
  State<IndexHomeScreen> createState() => _IndexHomeScreenState();
}

class _IndexHomeScreenState extends State<IndexHomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  int currentIndex = 0;


  List<IconData> navigationIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.calendarCheck,
    FontAwesomeIcons.user
  ];

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: IndexedStack(
          index: currentIndex,
          children: [HomeScreen(),AttendanceScreen(), ProfileScreen(),],
        ),
        bottomNavigationBar:
        Container(
          height: 60,
          margin: const EdgeInsets.only(left: 12, right: 13, bottom: 24),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black87, blurRadius: 5, offset: Offset(2, 2))
              ]),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = i;
                          });
                        },
                        child: Container(
                          height: screenHeight,
                          width: screenWidth,
                          color: Colors.white,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  navigationIcons[i],
                                  color: i == currentIndex
                                      ? AppColors.primary
                                      : Colors.black,
                                  size: i == currentIndex ? 28 : 25,
                                ),
                                i == currentIndex ? Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 5,left: 4,right: 2),
                                  height: 3,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: AppColors.primary),
                                ) : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  },
                ],
              )),
        ),
      ),
    );
  }
}
