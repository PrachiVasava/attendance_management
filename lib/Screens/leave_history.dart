import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hrms/constant/custom_appbar.dart';

import '../constant/app_colors.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({Key? key}) : super(key: key);

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: "History"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 10),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: screenHeight / 5,
                  padding: EdgeInsets.all(10),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        "Leave Type".toUpperCase(),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                color: AppColors.primary,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Date: ',
                                    style: TextStyle(
                                        color: AppColors.grey, fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: "12/03/2023 to 14/03/2023",
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      )
                                    ]),
                              ),
                            ],
                          ),
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
                                      color: AppColors.grey, fontSize: 15),
                                  children: [
                                    TextSpan(
                                        text: "medical Emergency so ",
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ))
                                  ]),
                            ),
                          ]),
                        ],
                      ),
                      trailing: Container(
                        width: 80,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primary,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Status",
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      )),
    );
  }
}
