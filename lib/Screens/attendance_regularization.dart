import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../constant/app_colors.dart';
import '../constant/button_widget.dart';
import '../constant/custom_appbar.dart';
import '../constant/language_constants.dart';

class AttendanceRegularization extends StatefulWidget {
  const AttendanceRegularization({Key? key}) : super(key: key);

  @override
  State<AttendanceRegularization> createState() => _AttendanceRegularizationState();
}

class _AttendanceRegularizationState extends State<AttendanceRegularization> {
  double screenHeight = 0;
  double screenWidth = 0;
  final _formKey = GlobalKey<FormState>();

  FocusNode categoryFocusNode = FocusNode();
  final categoryController =  SingleValueDropDownController();
  String? _dropdownValue;
  FocusNode durationFocusNode = FocusNode();
  final durationController =  SingleValueDropDownController();
  FocusNode startDateFocusNode = FocusNode();
  final TextEditingController _startDateController = TextEditingController();
  FocusNode endDateFocusNode = FocusNode();
  final TextEditingController _endDateController = TextEditingController();
  FocusNode reasonFocusNode = FocusNode();
  final TextEditingController reasonController = TextEditingController();


  late DateTime _startDate;
  late DateTime _endDate;
  final DateFormat _dateFormat = DateFormat('dd-MMMM-yyyy');

  final bool _startDateError = false;
  final bool _endDateError = false;




  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
  screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight ,
          width: screenWidth,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
            Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Column(
                children: [
                  DropDownTextField(
                    controller: categoryController ,
                    textFieldFocusNode: categoryFocusNode,
                    autovalidateMode: categoryFocusNode.hasFocus
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    dropDownItemCount: 4,
                    dropDownList: const [
                      DropDownValueModel(
                          name: 'Casual Leave', value: "Casual Leave"),
                      DropDownValueModel(
                        name: 'Consolidated Leave',
                        value: "Consolidated Leave",
                      ),
                      DropDownValueModel(
                          name: 'Leave Without Pay',
                          value: "Leave Without Pay"),
                      DropDownValueModel(
                          name: 'Sick Leave', value: "Sick Leave"),
                    ],
                    onChanged: (value) {

                    },
                    textFieldDecoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.primary, width: 2),
                      ),
                      labelText: "Regularization Category",
                      labelStyle: TextStyle(color: AppColors.primary),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  DropDownTextField(
                    controller: durationController ,
                    textFieldFocusNode: durationFocusNode,
                    autovalidateMode: durationFocusNode.hasFocus
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    dropDownItemCount: 4,
                    dropDownList: const [
                      DropDownValueModel(
                          name: 'First Half', value: "First Half"),
                      DropDownValueModel(
                        name: 'Second Half',
                        value: "Second Half",
                      ),
                      DropDownValueModel(
                          name: 'Full Day', value: "Full Day"),
                    ],
                    onChanged: (value) {
                    },
                    textFieldDecoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.primary, width: 2),
                      ),
                      labelText: "Duration time",
                      labelStyle: TextStyle(color: AppColors.primary),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.black,
                    ),
                        borderRadius: BorderRadius.circular(5)
                    ),
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
                                    errorText: _startDateError
                                        ? translation(context)
                                        .please_select_date
                                        : null,
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
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: reasonController,
                    focusNode: reasonFocusNode,
                    autovalidateMode: reasonFocusNode.hasFocus
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    maxLines: 3,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                        labelText: "Reason",
                        labelStyle: TextStyle(color: AppColors.primary)),
                    validator: (value) {
                      if (value == null || value.isEmpty ) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                  ), //reasons
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonWidget(
                      text: "Submit",
                      color: AppColors.primary,
                      onClicked: () {

                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                        } else {
                          setState(() {});
                        }
                      })

                ],
              ),
            ),
            ),
            ],
          ),
        ),
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
              monthViewSettings:  DateRangePickerMonthViewSettings(
                  weekendDays: [DateTime.sunday]),
              monthCellStyle:  DateRangePickerMonthCellStyle(
                weekendTextStyle: TextStyle(color: Colors.red),
                leadingDatesDecoration:
                BoxDecoration(color: AppColors.red,
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
