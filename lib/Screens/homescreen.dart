
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Screens/attendance_regularization.dart';
import 'package:hrms/Screens/leave_request.dart';
import 'package:hrms/Screens/qr_screen.dart';
import 'package:hrms/classes/language_dropdown.dart';
import '../classes/search_data.dart';
import '../constant/app_colors.dart';
import '../constant/language_constants.dart';
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

  final user = FirebaseAuth.instance.currentUser!;
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
          leading: IconButton(
            icon: const Icon(
                Icons.notifications),
            onPressed: () {  },),
          actions: <Widget>[
            // IconButton(
            //     icon: const Icon(Icons.search),
            //     onPressed: () {
            //       showSearch(context: context, delegate: DataSearch());
            //     }),
            // PopupMenuButton(
            //   icon: const Icon(
            //     Icons.language,
            //     color: Colors.white,
            //   ),
            //   onSelected: (Language? language) async {
            //     if (language != null) {
            //       Locale local = await setLocale(language.languageCode);
            //       MyApp.setLocale(context, local);
            //     }
            //   },
            //   itemBuilder: (BuildContext context) {
            //     return Language.languageList()
            //         .map<PopupMenuItem<Language>>((e) =>
            //             PopupMenuItem<Language>(
            //               value: e,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(
            //                     e.flag,
            //                     style: const TextStyle(fontSize: 30),
            //                   ),
            //                   Text(e.name)
            //                 ],
            //               ),
            //             ))
            //         .toList();
            //   },
            // ),
          ],

        ),
        body:SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: screenHeight  ,
                width: screenWidth,
                //padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                child: Column(
                      children: [
                        Container(
                          height: screenHeight/ 3 - kBottomNavigationBarHeight,
                          width: screenWidth,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.elliptical(180, 50))),
                          child: Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.white,
                                ),
                                Text(translation(context).welcome,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                    ),),
                                Text(user.email!
                                    .replaceAll("@gmail.com", "")
                                    .toUpperCase(),
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
                                height: screenHeight /1.6,
                                width: screenWidth,
                                padding: EdgeInsets.only(bottom: 100),
                                child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  children: List.generate(choices.length, (index) {
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
              ),
            )
        ),
    );
  }

  tapped(int index) {
    if (index == 0) {
      Get.to(() => const AttendanceCalendar());
    }
    else if (index == 1) {
      Get.to(() => AttendanceReport());
    }
    else if (index == 2) {
      Get.to(() =>  LeaveRequest());
    }
    else if (index == 3) {
      Get.to(() =>  LeaveHistory());
    }
    else if (index == 4) {
      Get.to(() =>  AttendanceRegularization());
    }
  }
}

class Choice {
  Choice({required this.title, required this.image});
  String title;
  final String image;
}

 List<Choice> choices = <Choice>[
  Choice(
    title: "Attendance Calendar",
    image: "assets/images/attendance.png",
  ),
   Choice(
     title: "Attendance Report",
     image: "assets/images/takeattendance.png",
   ),
   Choice(
       title: 'Leave Request',
       image: "assets/images/leave_request.png"),
   Choice(
       title: 'Leave History',
       image: "assets/images/history.png"),
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
      borderRadius: BorderRadius.circular(10),),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height:30),
                    Image(
                      image: AssetImage(choice.image),
                      height: 50,width: 50,
                      color: AppColors.primary,
                    ),
                    SizedBox(height:10),
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


