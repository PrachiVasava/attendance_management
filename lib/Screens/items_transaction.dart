import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms/constant/app_colors.dart';
import 'package:hrms/constant/button_widget.dart';
import 'package:hrms/constant/custom_appbar.dart';
import 'package:intl/intl.dart';
import '../constant/language_constants.dart';
import 'items_list.dart';

class ItemTransaction extends StatefulWidget {
  final String selectedValue;
  final String fromDate, toDate;

  const ItemTransaction(
      {Key? key,
      required this.selectedValue,
      required this.fromDate,
      required this.toDate})
      : super(key: key);

  @override
  State<ItemTransaction> createState() => _ItemTransactionState();
}

class _ItemTransactionState extends State<ItemTransaction> {
  String? _dropdownValue;
  final bool _dropDownError = false;
  final bool _toDateError = false;
  final bool _fromDateError = false;
  FocusNode dropDownFocusNode = FocusNode();
  FocusNode toDateFocusNode = FocusNode();
  FocusNode fromDateFocusNode = FocusNode();
  bool _autoValidate = false;

  String? dropDown;
  String? fromDate;
  String? toDate;

  final dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  final dateinput2 = TextEditingController();

  void initState2() {
    dateinput2.text = ""; //set the initial value of text field
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

        appBar: CustomAppBar(title: translation(context).item_transaction),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 30, right: 30, bottom: 20),
                  child: DropdownButtonFormField<String>(
                    focusNode: dropDownFocusNode,
                    autovalidateMode: dropDownFocusNode.hasFocus
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                      errorText: _dropDownError
                          ? translation(context).please_select_any_item
                          : null,
                      labelText: translation(context).select_any_item,
                    ),
                    isExpanded: true,
                    dropdownColor: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    value: _dropdownValue,
                    items: <String>[
                      translation(context).tea,
                      translation(context).coffee,
                      translation(context).snacks,
                      translation(context).petrol,
                      translation(context).diesel,
                      translation(context).oil,
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    validator: (value) => value == null
                        ? translation(context).please_select_any_item
                        : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue!;
                      });
                      _dropdownValue.reactive();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: dateinput,
                    focusNode: fromDateFocusNode,
                    autovalidateMode: fromDateFocusNode.hasFocus
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColors.primary,
                        size: 30,
                      ),
                      labelText: translation(context).from_date,
                      errorText: _fromDateError
                          ? translation(context).please_select_date
                          : null,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    showCursor: false,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2012),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          dateinput.text = formattedDate;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translation(context).please_select_date;
                      }
                      return null;
                    },
                    onSaved: (val) {
                      fromDate = val;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: dateinput2,
                    focusNode: toDateFocusNode,
                    autovalidateMode: toDateFocusNode.hasFocus
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColors.primary,
                        size: 30,
                      ),
                      labelText: translation(context).to_date,
                      errorText: _toDateError
                          ? translation(context).please_select_date
                          : null,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    showCursor: false,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2012),
                          lastDate: DateTime.now(),);
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          dateinput2.text =
                              formattedDate; //set output date to TextField value.
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return translation(context).please_select_date;
                      }
                      return null;
                    },
                    onSaved: (val) {
                      toDate = val;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child:ButtonWidget(
                    color: AppColors.primary,
                    text: translation(context).submit,
                    onClicked: () {
                      if (_formKey.currentState!.validate()) {
                    _formKey.currentState
                        ?.save(); //save once fields are valid, onSaved method invoked for every form fields
                    if (_dropdownValue != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemList(
                              selectedValue: _dropdownValue.toString(),
                              fromDate: dateinput.text,
                              toDate: dateinput2.text,
                            )),
                      );
                    }
                  }
                    else {
                    setState(() {
                      _autoValidate = true;
                    });}}
                  )
                  // GestureDetector(
                  //   onTap: () {
                  //
                  //     if (_formKey.currentState!.validate()) {
                  //       _formKey.currentState
                  //           ?.save(); //save once fields are valid, onSaved method invoked for every form fields
                  //       if (_dropdownValue != null) {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ItemList(
                  //                 selectedValue: _dropdownValue.toString(),
                  //                 fromDate: dateinput.text,
                  //                 toDate: dateinput2.text,
                  //               )),
                  //         );
                  //       }
                  //     }
                  //       else {
                  //       setState(() {
                  //         _autoValidate = true;
                  //       });
                  //     }
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     width: MediaQuery.of(context).size.width / 0.75,
                  //     height: 55,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: AppColors.primary),
                  //     child: Text(
                  //       translation(context).submit,
                  //       textAlign: TextAlign.center,
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: (20),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        )));
  }
}

Future<void> _showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog( // <-- SEE HERE
        title: const Text('Cancel booking'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Are you sure want to cancel booking?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

