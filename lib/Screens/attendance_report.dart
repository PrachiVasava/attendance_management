import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../constant/app_colors.dart';
import '../constant/custom_appbar.dart';
import '../constant/language_constants.dart';

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
  final DateFormat _dateFormat = DateFormat('dd-MMMM-yyyy');
  final bool _endDateError = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: "Report"),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight / 5,
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Filter by Date".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 5,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: _startDateController,
                                  focusNode: startDateFocusNode,
                                  autovalidateMode: startDateFocusNode.hasFocus
                                      ? AutovalidateMode.always
                                      : AutovalidateMode.disabled,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_month,
                                      color: AppColors.primary,
                                      size: 30,
                                    ),
                                    labelText: "Start Date",
                                  ),
                                  showCursor: false,
                                  readOnly: true,
                                  onTap: () async {
                                    onSelected();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Required field";
                                    } else {
                                      return null;
                                    }
                                  },
                                )
                              ],
                            )),
                            Container(
                              width: 5,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 5,
                                ),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      TextFormField(
                                        controller: _endDateController,
                                        focusNode: endDateFocusNode,
                                        autovalidateMode:
                                            endDateFocusNode.hasFocus
                                                ? AutovalidateMode.always
                                                : AutovalidateMode.disabled,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.calendar_month,
                                            color: AppColors.primary,
                                            size: 30,
                                          ),
                                          labelText: "End Date",
                                          errorText: _endDateError
                                              ? translation(context)
                                                  .please_select_date
                                              : null,
                                        ),
                                        showCursor: false,
                                        readOnly: true,
                                        onTap: () async {
                                          onSelected();
                                          //onSelected();
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Required field";
                                          } else {
                                            return null;
                                          }
                                        },
                                      )
                                    ])),
                                Container(
                                  width: 5,
                                ),
                              ],
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: screenHeight / 2,
                width: screenWidth,
                padding: EdgeInsets.all(10),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    child: Column(children: [
                      DataTable(
                          columns: const [
                            DataColumn(
                              label: Text('Date'),
                            ),
                            DataColumn(
                              label: Text('Time'),
                            ),
                            DataColumn(
                              label: Text('Type'),
                            ),
                          ],
                          rows: const [
                            DataRow(cells: [
                              DataCell(Text('12/02/2023')),
                              DataCell(Text('10:05:24')),
                              DataCell(Text('Check in')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('12/02/2023')),
                              DataCell(Text('10:05:24')),
                              DataCell(Text('Check in')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('12/02/2023')),
                              DataCell(Text('10:05:24')),
                              DataCell(Text('Check in')),
                            ]),
                          ],
                      )

                    ])),
              ),
            ],
          ),
        )),
      ),
    );
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
