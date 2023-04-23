import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Controller/Session_controller.dart';
import 'package:hrms/Screens/attendance_regularization.dart';
import 'package:hrms/Screens/leave_request.dart';
import 'package:hrms/Screens/qr_screen.dart';
import 'package:hrms/classes/language_dropdown.dart';
import 'package:provider/provider.dart';
import '../Controller/profile_controller.dart';
import '../classes/search_data.dart';
import '../constant/app_colors.dart';
import '../constant/language_constants.dart';
import 'attendance_calendar.dart';
import 'attendance_calendar.dart';
import 'attendance_calendar.dart';
import 'attendance_report.dart';
import 'attendance_screen.dart';
import 'index_homescreen.dart';
import 'items_transaction.dart';
import '../main.dart';
import 'leave_history.dart';
import 'menu_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class PopupItem {
  int value;
  String name;

  PopupItem(this.value, this.name);
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<String> list = [
  //   "Attendance",
  //   "Item Transaction",
  //   "QR Code",
  //   "Menu Item"
  // ];

  final DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  double screenHeight = 0;
  double screenWidth = 0;
  String? selectedValue;



  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            translation(context).home_page.toUpperCase(),
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          elevation: 10,
          // leading: IconButton(
          //   icon: const Icon(Icons.notifications),
          //   onPressed: () {},
          // ),
        ),
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child:
              Consumer<ProfileController>(builder: (context, provider, child) {
            return SafeArea(
                child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: StreamBuilder(
                        stream: ref
                            .child(SessionController().userId.toString())
                            .onValue,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              width: screenWidth,
                              height: screenHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                      child: CircularProgressIndicator()),
                                ],
                              ),
                            );
                          } else if (snapshot.hasData) {
                            Map<dynamic, dynamic> map =
                                snapshot.data.snapshot.value;
                            return Container(
                              height: screenHeight,
                              width: screenWidth,
                              //padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                              child: Column(
                                children: [
                                  Container(
                                    height: screenHeight / 3 -
                                        kBottomNavigationBarHeight,
                                    width: screenWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[800],
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.elliptical(
                                                    180, 50))),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 20),
                                            child: Container(
                                              height:120,
                                              width: 120,
                                              child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                  child: provider.image == null
                                                      ? map['image'].toString() == ""
                                                      ? Icon(
                                                    Icons.person,
                                                    color: AppColors.white,
                                                    size: 100,
                                                  )
                                                      : Image(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        map['image'].toString(),
                                                      ),
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return Center(
                                                          child:
                                                          CircularProgressIndicator(),
                                                        );
                                                      },
                                                      errorBuilder: (context,
                                                          object, stack) {
                                                        return Container(
                                                          child: Icon(
                                                            Icons.person,
                                                            color: AppColors
                                                                .primary,
                                                            size: 100,
                                                          ),
                                                        );
                                                      })
                                                      : Stack(
                                                    children: [
                                                      Image.file(
                                                        File(provider.image!.path)
                                                            .absolute,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Center(
                                                        child:
                                                        CircularProgressIndicator(),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Text(
                                            translation(context).welcome,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(map['username'] == ""
                                              ? "xxxxxxxxx"
                                              : map['username'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                    height: screenHeight / 1.6,
                                          width: screenWidth,
                                          padding: EdgeInsets.only(bottom: 100),
                                          child: GridView.count(
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            children: List.generate(
                                                choices.length, (index) {
                                              return Center(
                                                child: GestureDetector(
                                                    onTap: () => tapped(index),
                                                    child: SelectCard(
                                                      choice: choices[index],
                                                    )),
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                                child: Text(
                              "Something went Wrong",
                              style: Theme.of(context).textTheme.titleMedium,
                            ));
                          }
                        })));
          }),
        ));
  }

  tapped(int index) {
    if (index == 0) {
      Get.to(() => const AttendanceCalendar());
    } else if (index == 1) {
      Get.to(() => AttendanceReport());
    } else if (index == 2) {
      Get.to(() => LeaveRequest());
    } else if (index == 3) {
      Get.to(() => LeaveHistory());
    } else if (index == 4) {
      Get.to(() => AttendanceRegularization());
    }
  }
}

class Choice{
  Choice({required this.title, required this.image});

  String title;
  final String image;
}

List<Choice> choices =[
  Choice(
    title: "Attendance Calendar",
    image: "assets/images/attendance.png",
  ),
  Choice(
    title: "Attendance Report",
    image: "assets/images/takeattendance.png",
  ),
  Choice(title: 'Leave Request', image: "assets/images/leave_request.png"),
  Choice(title: 'Leave History', image: "assets/images/history.png"),
  Choice(
      title: 'Attendance Regularization',
      image: "assets/images/attendance_regularization.png"),
];



class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 180,
      width: 180,
      //margin: EdgeInsets.only(bottom: 50),
      child: Card(
          //margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
          //color: Colors.grey,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Image(
                      image: AssetImage(choice.image),
                      height: 50,
                      width: 50,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 10),
                    Text(
                      choice.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ]),
            ),
          )),
    );
  }
}
