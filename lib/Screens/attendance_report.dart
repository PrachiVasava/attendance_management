import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms/constant/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:pdf/pdf.dart';
import '../Controller/Session_controller.dart';
import '../constant/app_colors.dart';
import '../constant/custom_appbar.dart';
import '../constant/language_constants.dart';
import 'attendance_screen.dart';

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
  final ref = FirebaseDatabase.instance.ref('attendance');

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CustomAppBar(title: "Report"),
        body: SafeArea(
            child: ChangeNotifierProvider(
                create: (_) => AttendanceScreen(),
                child: Consumer<AttendanceScreen>(
                    builder: (context, provider, child) {
                  return StreamBuilder(
                    stream: ref.child(uid).onValue,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData  || snapshot.data.snapshot.value == null) {
                        return Container(
                          width: screenWidth,
                          height: screenHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("No attendance data found for user".toUpperCase(),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center),
                            ],
                          ),
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
                            DataCell(Text(outTime == "" ? "-----" : outTime))
                          ];

                          rows.add(DataRow(cells: cells));
                        });

                        return SingleChildScrollView(
                            child: Container(
                          height: screenHeight,
                          width: screenWidth,
                          child: Column(
                            children: [
                              Container(
                                width: screenWidth,
                                height: screenHeight / 9,
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "History".toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  // Column(
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.only(top: 8.0),
                                  //       child: Text(
                                  //         "Filter by Date".toUpperCase(),
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 20),
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       width: MediaQuery.of(context).size.width,
                                  //       height: 100,
                                  //       padding:
                                  //           EdgeInsets.only(right: 10, left: 10),
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           Container(
                                  //             width: 5,
                                  //           ),
                                  //           Expanded(
                                  //               child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               TextFormField(
                                  //                 controller: _startDateController,
                                  //                 focusNode: startDateFocusNode,
                                  //                 autovalidateMode:
                                  //                     startDateFocusNode.hasFocus
                                  //                         ? AutovalidateMode.always
                                  //                         : AutovalidateMode
                                  //                             .disabled,
                                  //                 decoration: InputDecoration(
                                  //                   icon: Icon(
                                  //                     Icons.calendar_month,
                                  //                     color: AppColors.primary,
                                  //                     size: 30,
                                  //                   ),
                                  //                   labelText: "Start Date",
                                  //                 ),
                                  //                 showCursor: false,
                                  //                 readOnly: true,
                                  //                 onTap: () async {
                                  //                   onSelected();
                                  //                 },
                                  //                 validator: (value) {
                                  //                   if (value == null ||
                                  //                       value.isEmpty) {
                                  //                     return "Required field";
                                  //                   } else {
                                  //                     return null;
                                  //                   }
                                  //                 },
                                  //               )
                                  //             ],
                                  //           )),
                                  //           Container(
                                  //             width: 5,
                                  //           ),
                                  //           Expanded(
                                  //               child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Container(
                                  //                 width: 5,
                                  //               ),
                                  //               Expanded(
                                  //                   child: Column(
                                  //                       crossAxisAlignment:
                                  //                           CrossAxisAlignment
                                  //                               .start,
                                  //                       mainAxisAlignment:
                                  //                           MainAxisAlignment
                                  //                               .center,
                                  //                       children: [
                                  //                     TextFormField(
                                  //                       controller:
                                  //                           _endDateController,
                                  //                       focusNode: endDateFocusNode,
                                  //                       autovalidateMode:
                                  //                           endDateFocusNode
                                  //                                   .hasFocus
                                  //                               ? AutovalidateMode
                                  //                                   .always
                                  //                               : AutovalidateMode
                                  //                                   .disabled,
                                  //                       decoration: InputDecoration(
                                  //                         icon: Icon(
                                  //                           Icons.calendar_month,
                                  //                           color:
                                  //                               AppColors.primary,
                                  //                           size: 30,
                                  //                         ),
                                  //                         labelText: "End Date",
                                  //                         errorText: _endDateError
                                  //                             ? translation(context)
                                  //                                 .please_select_date
                                  //                             : null,
                                  //                       ),
                                  //                       showCursor: false,
                                  //                       readOnly: true,
                                  //                       onTap: () async {
                                  //                         onSelected();
                                  //                         //onSelected();
                                  //                       },
                                  //                       validator: (value) {
                                  //                         if (value == null ||
                                  //                             value.isEmpty) {
                                  //                           return "Required field";
                                  //                         } else {
                                  //                           return null;
                                  //                         }
                                  //                       },
                                  //                     )
                                  //                   ])),
                                  //               Container(
                                  //                 width: 5,
                                  //               ),
                                  //             ],
                                  //           )),
                                  //         ],
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                ),
                              ),
                              Container(
                                height: screenHeight / 1.5,
                                width: screenWidth,
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  height: 200,
                                  width: screenWidth,
                                  child: DataTable(
                                    columns: [
                                      DataColumn(label: Text('Date')),
                                      DataColumn(label: Text('Check-in')),
                                      DataColumn(label: Text('Check-out')),
                                      //DataColumn(label: Text('Status')),
                                    ],
                                    rows: rows,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                      } else {
                        return Center(
                            child: Text(
                          "Something went Wrong",
                          style: Theme.of(context).textTheme.titleMedium,
                        ));
                      }
                    },
                  );
                }))));
  }

  Future<void> onSelected() async {
    final DateRangePickerController controller = DateRangePickerController();
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                height: MediaQuery.of(context).size.height / 2.2,
                width: MediaQuery.of(context).size.width / 0.5,
                child: SfDateRangePicker(
                  controller: controller,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    setState(() {
                      _startDate = args.value.startDate;
                      _endDate = args.value.endDate;
                      _startDateController.text =
                          _dateFormat.format(_startDate!);
                      _endDateController.text = _dateFormat.format(_endDate!);
                    });
                  },
                  headerStyle: DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      backgroundColor: AppColors.primary,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                      weekendDays: [DateTime.sunday]),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    weekendTextStyle: TextStyle(color: Colors.red),
                    leadingDatesDecoration: BoxDecoration(
                      color: AppColors.red,
                    ),
                    trailingDatesDecoration:
                        BoxDecoration(color: AppColors.white),
                  ),
                  todayHighlightColor: Colors.teal,
                  enablePastDates: false,
                  showActionButtons: true,
                  onSubmit: (value) {
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ));
  }
}
