import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms/constant/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Controller/Session_controller.dart';
import '../constant/app_colors.dart';
import '../constant/custom_appbar.dart';
import '../constant/language_constants.dart';
import 'attendance_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;



class AttendanceReport extends StatefulWidget {
  const AttendanceReport({Key? key}) : super(key: key);

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  double screenHeight = 0;
  double screenWidth = 0;
  FocusNode startDateFocusNode = FocusNode();
  FocusNode endDateFocusNode = FocusNode();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  late DateTime _startDate;
  late DateTime _endDate;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String time = DateFormat.Hms().format(DateTime.now());
  String uid = SessionController().userId.toString();
  final DateFormat _dateFormat = DateFormat('dd-MMMM-yyyy');
  final bool _endDateError = false;
  final DatabaseReference ref = FirebaseDatabase.instance.ref('attendance');

  DatabaseReference _ref = FirebaseDatabase.instance.ref().child('attendance');





  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/background.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                ChangeNotifierProvider(
                    create: (_) => AttendanceScreen(),
                    child: Consumer<AttendanceScreen>(
                        builder: (context, provider, child) {
                      return StreamBuilder(
                        stream: ref.child(uid).onValue,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
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
                                            color: AppColors.black
                                          ),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }

                          else if (snapshot.hasData) {
                            Map<dynamic, dynamic> map =
                                snapshot.data.snapshot.value;
                            List<DataRow> rows = [];
                            map.forEach((key, value) {
                              String date = value['date'];
                              String inTime = value["inTime"];
                              String outTime = value["outTime"];
                              List<DataCell> cells = [
                                DataCell(Text(date == "" ? "------" : date)),
                                DataCell(Text(inTime == "" ? "-----" : inTime)),
                                DataCell(
                                    Text(outTime == "" ? "-----" : outTime))
                              ];

                              rows.add(DataRow(cells: cells));
                            });

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Text(
                                  translation(context).attendance_report.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style:  TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      color: AppColors.white
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  height: screenHeight/2,
                                  width: screenWidth,
                                  child: DataTable(
                                    columns:  [
                                      DataColumn(label: Text(translation(context).date)),
                                      DataColumn(label: Text(translation(context).check_in)),
                                      DataColumn(label: Text(translation(context).check_out)),
                                      //DataColumn(label: Text('Status')),
                                    ],
                                    rows: rows,
                                  ),

                                ),
                                ButtonWidget(text: translation(context).download_pdf, onClicked: () async {
                                }, color: AppColors.primary),
                              ],
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
                          } else {
                            return Center(
                                child: Text(
                                  translation(context).something_went_wrong,
                              style: Theme.of(context).textTheme.titleMedium,
                            ));
                          }
                        },
                      );
                    })),
              ],
            )));
  }

}
