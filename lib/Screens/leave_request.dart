import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/Controller/leave_controller.dart';
import 'package:hrms/constant/button_widget.dart';
import 'package:hrms/constant/custom_appbar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Controller/register_controller.dart';
import '../constant/app_colors.dart';
import '../constant/language_constants.dart';

class LeaveRequest extends StatefulWidget {
  const LeaveRequest({Key? key}) : super(key: key);

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  double screenHeight = 0;
  double screenWidth = 0;

  String? _dropdownValue;

  final bool _startDateError = false;
  final bool _endDateError = false;

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  late DateTime _startDate;
  late DateTime _endDate;
  final DateFormat _dateFormat = DateFormat('dd-MMMM-yyyy');

  FocusNode leaveTypeFocusNode = FocusNode();
  FocusNode dayTypeFocusNode = FocusNode();
  FocusNode reasonFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode startDateFocusNode = FocusNode();
  FocusNode endDateFocusNode = FocusNode();

  final leaveTypeController = SingleValueDropDownController();
  final dayTypeController = SingleValueDropDownController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    leaveTypeController.dispose();
    dayTypeController.dispose();
    reasonController.dispose();
    mobileController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
  // String selectedValue = "";
  // void onValueChanged(DropDownValueModel value) {
  //   selectedValue = value.name;
  // }


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
                  create: (_) => LeaveController(),
                  child: Consumer<LeaveController>(
                      builder: (context, provider, child) {
                    return SafeArea(
                        child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                              translation(context).leave_request.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              color: AppColors.white
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(children: [
                                  DropDownTextField(
                                    controller: leaveTypeController,
                                    textFieldFocusNode: leaveTypeFocusNode,
                                    autovalidateMode: leaveTypeFocusNode.hasFocus
                                        ? AutovalidateMode.always
                                        : AutovalidateMode.disabled,
                                    dropDownItemCount: 4,
                                    dropDownList: [
                                      DropDownValueModel(
                                          name: translation(context).casual_leave,
                                          value: translation(context).casual_leave
                                      ),
                                      DropDownValueModel(
                                        name: translation(context).consolidated_leave,
                                        value: translation(context).consolidated_leave,
                                      ),
                                      DropDownValueModel(
                                          name: translation(context).leave_without_pay,
                                          value: translation(context).leave_without_pay),
                                      DropDownValueModel(
                                          name: translation(context).sick_leave,
                                          value: translation(context).sick_leave),
                                    ],
                                    onChanged: (value) {},
                                    textFieldDecoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.primary, width: 2),
                                      ),
                                      labelText: translation(context).leave_type,
                                      labelStyle: TextStyle(color: AppColors.primary),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return translation(context).required_field;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ), //leave pay
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 5,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextFormField(
                                              controller: _startDateController,
                                              focusNode: startDateFocusNode,
                                              autovalidateMode:
                                                  startDateFocusNode.hasFocus
                                                      ? AutovalidateMode.always
                                                      : AutovalidateMode.disabled,
                                              decoration: InputDecoration(
                                                icon: Icon(
                                                  Icons.calendar_month,
                                                  color: AppColors.primary,
                                                  size: 30,
                                                ),
                                                labelText: translation(context).start_date,
                                                labelStyle: TextStyle(color: AppColors.primary)
                                              ),
                                              showCursor: false,
                                              readOnly: true,
                                              onTap: () async {
                                                onSelected();
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return translation(context).required_field;
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                    autovalidateMode: endDateFocusNode
                                                            .hasFocus
                                                        ? AutovalidateMode.always
                                                        : AutovalidateMode.disabled,
                                                    decoration: InputDecoration(
                                                      icon: Icon(
                                                        Icons.calendar_month,
                                                        color: AppColors.primary,
                                                        size: 30,
                                                      ),
                                                      labelText: translation(context).end_date,
                                                        labelStyle: TextStyle(color: AppColors.primary),

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
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return translation(context).required_field;
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
                                  ), //start dat & end date
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: screenWidth,
                                    height: 60,
                                    child: DropDownTextField(
                                      controller: dayTypeController,
                                      textFieldFocusNode: dayTypeFocusNode,
                                      autovalidateMode: dayTypeFocusNode.hasFocus
                                          ? AutovalidateMode.always
                                          : AutovalidateMode.disabled,
                                      textFieldDecoration: InputDecoration(
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(width: 1),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent, width: 2),
                                          ),
                                          labelText: translation(context).day_type,
                                          labelStyle:
                                              TextStyle(color: AppColors.primary)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return translation(context).required_field;
                                        } else {
                                          return null;
                                        }
                                      },
                                      dropDownItemCount: 3,
                                      dropDownList:  [
                                        DropDownValueModel(
                                            name: translation(context).first_half,
                                            value: translation(context).first_half),
                                        DropDownValueModel(
                                          name: translation(context).second_half,
                                          value: translation(context).second_half,
                                        ),
                                        DropDownValueModel(
                                            name: translation(context).full_day, value: translation(context).full_day),
                                      ],
                                      onChanged: (val) {},
                                    ),
                                  ), //day type
                                  const SizedBox(
                                    height: 15,
                                  ),
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
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent, width: 2),
                                        ),
                                        labelText: translation(context).reason_for_leave,
                                        labelStyle:
                                            TextStyle(color: AppColors.primary)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return translation(context).required_field;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ), //reasons for leave
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: mobileController,
                                    focusNode: mobileFocusNode,
                                    autovalidateMode: startDateFocusNode.hasFocus
                                        ? AutovalidateMode.always
                                        : AutovalidateMode.disabled,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(width: 1),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueAccent, width: 2),
                                        ),
                                        labelText: translation(context).mobile_no,
                                        labelStyle:
                                            TextStyle(color: AppColors.primary),
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: AppColors.primary,
                                        )),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return translation(context).required_field;
                                      }
                                      if (value.length < 10) {
                                        return translation(context).valid_mobile_no;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ), //mobile number
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  ButtonWidget(
                                      text: translation(context).submit,
                                      color: AppColors.primary,
                                      onClicked: () {
                                        if (_formKey.currentState!.validate()) {
                                          provider.leaveRequest(
                                              leaveTypeController.dropDownValue!.name,
                                              _startDateController.text.toString(),
                                              _endDateController.text.toString(),
                                              dayTypeController.dropDownValue!.name,
                                            reasonController.text.toString(),
                                            mobileController.text.toString()
                                          );
                                          showDialog(context: context, builder: (context) {
                                            return AlertDialog(
                                              content: Lottie.asset(
                                                "assets/animation/leave_request.json",
                                                width: 100,
                                                height: 250,
                                                fit: BoxFit.fill,
                                              ),
                                              title: Center(
                                                  child: Text(translation(context).leave_request_sent,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                    });
                                                    _formKey.currentState!.reset();
                                                    leaveTypeController.clearDropDown();
                                                    _startDateController.clear();
                                                    _endDateController.clear();
                                                    dayTypeController.clearDropDown();
                                                    reasonController.clear();
                                                    mobileController.clear();
                                                    Navigator.pop(context);
                                                    },
                                                  child: Text(translation(context).ok),
                                                ),
                                              ],
                                            );
                                          }).then((value) {

                                          });
                                        }
                                      })
                                ])))
                      ]),
                    ));
                  })),
            ],
          ),
        ));
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
