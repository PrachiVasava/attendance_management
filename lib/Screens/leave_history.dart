import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hrms/Controller/leave_controller.dart';
import 'package:hrms/constant/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../Controller/Session_controller.dart';
import '../constant/app_colors.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({Key? key}) : super(key: key);

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  double screenHeight = 0;
  double screenWidth = 0;

  final DatabaseReference ref = FirebaseDatabase.instance.ref("leaveRequest");

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CustomAppBar(title: "HRMS"),
        body: ChangeNotifierProvider(
          create: (_) => LeaveController(),
          child: Consumer<LeaveController>(builder: (context, provider, child) {
            return StreamBuilder(
                stream:
                    ref.child(SessionController().userId.toString()).onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData  || snapshot.data.snapshot.value == null) {
                    return Container(
                      width: screenWidth,
                      height: screenHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("No Leave History found for user".toUpperCase(),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                    List<Widget> leaveData = [];

                    if (leaveData == null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("No attendance data found for user"),
                        ],
                      );
                    }

                    map.forEach((key, value) {
                      String leaveType = value["leaveType"];
                      String startDate = value["startDate"];
                      String endDate = value["endDate"];
                      String reason = value["reason"];
                      String status = value["status"];
                      String dayType = value["dayType"];

                      Color tileColor = Colors.red;
                      IconData iconData = Icons.cancel;
                      if (status == "Rejected") {
                        tileColor = Colors.orangeAccent;// Change color to red if status is "rejected"
                        iconData = Icons.access_time_filled;
                      } else if (status == "Approved") {
                        tileColor = Colors.green; // Change color to green if status is "approved"
                        iconData = Icons.check_circle;
                      }

                      leaveData.add(ListTile(
                            title:
                            Text(leaveType == null
                                ? "xxxxxxxxx"
                                : leaveType,
                            ),
                            subtitle: Column(
                              children: [
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_rounded,
                                      color: AppColors.primary,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: 'Start Date: ',
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 15),
                                          children: [
                                            TextSpan(
                                              text:
                                              startDate == null
                                                  ? "xxxxxxxxx"
                                                  : startDate,
                                              style: TextStyle(
                                                  color:
                                                  AppColors.black,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_rounded,
                                      color: AppColors.primary,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: 'End Date: ',
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 15),
                                          children: [
                                            TextSpan(
                                              text:
                                              endDate == null
                                                  ? "xxxxxxxxx"
                                                  : endDate,
                                              style: TextStyle(
                                                  color:
                                                  AppColors.black,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(children: [
                                  Icon(
                                    Icons.person,
                                    color: AppColors.primary,
                                  ),
                                  RichText(
                                    maxLines: 3,
                                    text: TextSpan(
                                        text: 'Reason: ',
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 15),
                                        children: [
                                          TextSpan(
                                              text:reason == null
                                                  ? "xxxxxxxxx"
                                                  : reason,
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 13,
                                              ))
                                        ]),
                                  ),
                                ]),
                                SizedBox(height: 10,),
                                Row(children: [
                                  Icon(
                                    Icons.ac_unit,
                                    color: AppColors.primary,
                                  ),
                                  RichText(
                                    maxLines: 3,
                                    text: TextSpan(
                                        text: 'Day Type: ',
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 15),
                                        children: [
                                          TextSpan(
                                              text:dayType == null
                                                  ? "xxxxxxxxx"
                                                  : dayType,
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 13,
                                              ))
                                        ]),
                                  ),
                                ]),
                              ],
                            ),
                            trailing: Container(
                              width: 115,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: tileColor,
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(iconData,color: Colors.white,),
                                  Text(
                                    status == null
                                        ? "xxxxxxxxx"
                                        : status,
                                    style:
                                    TextStyle(color: AppColors.white),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    });
                    return SafeArea(
                        child: SingleChildScrollView(
                            child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      child: Column(children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight / 10,
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 20),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                "Leave History".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        ListView.builder(
                            itemCount: leaveData.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 10),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: screenHeight / 4,
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: leaveData[index],

                                ),
                              );
                            })
                      ]),
                    )));
                  }
                  else {
                    return Center(
                        child: Text(
                      "Something went Wrong",
                      style: Theme.of(context).textTheme.titleMedium,
                    ));
                  }
                });
          }),
        ));
  }
}
