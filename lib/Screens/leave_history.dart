import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms/Controller/leave_controller.dart';
import 'package:hrms/constant/custom_appbar.dart';
import 'package:provider/provider.dart';
import '../Controller/Session_controller.dart';
import '../constant/app_colors.dart';
import '../constant/language_constants.dart';


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
        appBar: CustomAppBar(),
        body: ChangeNotifierProvider(
          create: (_) => LeaveController(),
          child: Consumer<LeaveController>(builder: (context, provider, child) {
            return StreamBuilder(
                stream:
                    ref.child(SessionController().userId.toString()).onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if(!snapshot.hasData){
                    return Container(
                      width: screenWidth,
                      height: screenHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child: CircularProgressIndicator())
                        ],
                      ),
                    );
                  }
                  else if (snapshot.data.snapshot.value == null) {
                    return Stack(
                      children: [
                        Image.asset(
                          'assets/images/background.jpg',
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        Container(
                          width: screenWidth,
                          height: screenHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  translation(context).no_attendance_data
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  else if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                    List<Widget> leaveData = [];

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
                                          text: translation(context).start_date,
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 15),
                                          children: [
                                            WidgetSpan(child: Text(": ")),
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
                                          text: translation(context).end_date,
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 15),
                                          children: [
                                            WidgetSpan(child: Text(": ")),

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
                                Row(
                                    children: [
                                  Icon(
                                    Icons.person,
                                    color: AppColors.primary,
                                  ),
                                  RichText(
                                    maxLines: 3,
                                    text: TextSpan(
                                        text:translation(context).reason,
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 15),
                                        children: [
                                          WidgetSpan(child: Text(": ")),
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
                                Row(
                                    children: [
                                  Icon(
                                    Icons.ac_unit,
                                    color: AppColors.primary,
                                  ),
                                  RichText(
                                    maxLines: 3,
                                    text: TextSpan(
                                        text: translation(context).day_type,
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 15),
                                        children: [
                                          WidgetSpan(child: Text(": ")),

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
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/background.jpg',
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                            SingleChildScrollView(
                                child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Text(
                                translation(context).leave_history.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
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
                                }),

                      ]),
                    )),
                          ],
                        ));
                  }
                  else if (snapshot.data.snapshot.value == null) {
                    return Stack(
                      children: [
                        Image.asset(
                          'assets/images/background.jpg',
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        Container(
                          width: screenWidth,
                          height: screenHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(translation(context).no_attendance_data.toUpperCase(),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  else {
                    return Center(
                        child: Text(
                          translation(context).something_went_wrong,
                      style: Theme.of(context).textTheme.titleMedium,
                    ));
                  }
                });
          }),
        ));
  }


}
