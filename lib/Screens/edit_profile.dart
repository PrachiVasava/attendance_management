import 'dart:io';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/app_colors.dart';
import '../constant/button_widget.dart';
import '../constant/custom_appbar.dart';
import '../constant/language_constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late DatabaseReference dbRef;
  String? _savedData;

  User? uid;
  @override
  void initState() {
    super.initState();
    _loadSavedData();
    dbRef = FirebaseDatabase.instance.ref().child('users').child("$uid");
  }

  double screenHeight = 0;
  double screenWidth = 0;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController unameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController spouseNameController = TextEditingController();
  final TextEditingController spouseNumberController = TextEditingController();
  final maritalStstusController = SingleValueDropDownController();

  FocusNode unameFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode spouseNameFocusNode = FocusNode();
  FocusNode spouseNumberFocusNode = FocusNode();
  FocusNode maritalStstusFocusNode = FocusNode();

  File? _image;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Stack(children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: AppColors.white,
                            child: _image == null
                                ? Image.asset(
                                    "assets/images/profile.png",
                                    color: AppColors.primary,
                                  )
                                : CircleAvatar(
                                    radius: 70.0,
                                    backgroundImage: FileImage(_image!),
                                  ),
                          ),
                          Positioned(
                            bottom: 15,
                            right: 0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.white,
                              child: IconButton(
                                icon: Icon(
                                  CupertinoIcons.camera_fill,
                                  size: 28.0,
                                  color: AppColors.primary,
                                ),
                                onPressed: () async {
                                  getImage();
                                },
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: screenWidth,
                  height: screenHeight,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(5),
                          elevation: 10,
                          child: ExpansionTile(
                              childrenPadding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              title: const Text("Enter Employee Details"),
                              children: [
                                Column(
                                  children: [
                                    TextFormField(
                                      controller: unameController,
                                      focusNode: unameFocusNode,
                                      autovalidateMode: unameFocusNode.hasFocus
                                          ? AutovalidateMode.always
                                          : AutovalidateMode.disabled,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.person,
                                          color: AppColors.primary,
                                          size: 30,
                                        ),
                                        labelText: "User Name",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return translation(context)
                                              .please_select_date;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      controller: mobileController,
                                      focusNode: mobileFocusNode,
                                      autovalidateMode: mobileFocusNode.hasFocus
                                          ? AutovalidateMode.always
                                          : AutovalidateMode.disabled,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.phone_android,
                                          color: AppColors.primary,
                                          size: 30,
                                        ),
                                        labelText: "Enter Mobile Number",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter mobile number";
                                        }
                                        if (value.length < 10) {
                                          return "Password must be at least 10 characters long";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      focusNode: emailFocusNode,
                                      autovalidateMode: emailFocusNode.hasFocus
                                          ? AutovalidateMode.always
                                          : AutovalidateMode.disabled,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.person,
                                          color: AppColors.primary,
                                          size: 30,
                                        ),
                                        labelText: "Enter Email Address",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter Email Address";
                                        }
                                        if (!RegExp(
                                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                            .hasMatch(value)) {
                                          return translation(context)
                                              .valid_email_address;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: dobController,
                                      focusNode: dobFocusNode,
                                      autovalidateMode: dobFocusNode.hasFocus
                                          ? AutovalidateMode.always
                                          : AutovalidateMode.disabled,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.calendar_month,
                                          color: AppColors.primary,
                                          size: 30,
                                        ),
                                        labelText: "Date of Birth",
                                      ),
                                      showCursor: false,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(pickedDate);
                                          setState(() {
                                            dobController.text = formattedDate;
                                          });
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return translation(context)
                                              .please_select_date;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Wrap(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 150,
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: ButtonWidget(
                                                  text: "Reset",
                                                  color: AppColors.primary,
                                                  onClicked: () {
                                                    _formKey.currentState
                                                        ?.reset();
                                                    _formKey.currentState
                                                        ?.deactivate();
                                                  }),
                                            ),
                                            Container(
                                              width: 150,
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: ButtonWidget(
                                                text: "Submit",
                                                color: AppColors.primary,
                                                onClicked: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _formKey.currentState
                                                        ?.save();

                                                    String uname =
                                                        unameController.text;
                                                    String mobile =
                                                        mobileController.text;
                                                    String email =
                                                        emailController.text;
                                                    String dob =
                                                        dobController.text;
                                                    _saveData(uname);
                                                    _saveData(mobile);
                                                    _saveData(email);
                                                    _saveData(dob);

                                                    Map<String, String> users =
                                                        {
                                                      'userName': uname,
                                                      'mobileNumber': mobile,
                                                      'email': email,
                                                      'dob': dob,
                                                      'image': _image!.path,
                                                    };
                                                    dbRef.push().set(users);
                                                    setState(() {
                                                      uname = uname;
                                                    });
                                                  } else {
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Card(
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10)),
                        //   clipBehavior: Clip.antiAlias,
                        //   margin: const EdgeInsets.all(5),
                        //   elevation: 10,
                        //   child: ExpansionTile(
                        //       childrenPadding:
                        //           const EdgeInsets.only(left: 10, right: 10),
                        //       title: const Text("Enter Personal Details"),
                        //       children: [
                        //         Column(
                        //           children: [
                        //             MyTextFormField(
                        //               "Home Address",
                        //               addressController,
                        //               (value) {
                        //                 if (value!.isEmpty) {
                        //                   return "Please enter Home address";
                        //                 }
                        //                 return null;
                        //               },
                        //               Icons.home,
                        //               TextInputType.text,
                        //               addressFocusNode,
                        //               addressFocusNode.hasFocus
                        //                   ? AutovalidateMode.always
                        //                   : AutovalidateMode.disabled,
                        //               true,
                        //                   (p0) {
                        //                 uname = p0;
                        //               },                                    ),
                        //             const SizedBox(
                        //               height: 10,
                        //             ),
                        //             DropDownTextField(
                        //               controller: maritalStstusController,
                        //               textFieldFocusNode:
                        //                   maritalStstusFocusNode,
                        //               autovalidateMode:
                        //                   maritalStstusFocusNode.hasFocus
                        //                       ? AutovalidateMode.always
                        //                       : AutovalidateMode.disabled,
                        //               dropDownItemCount: 2,
                        //               dropDownList: const [
                        //                 DropDownValueModel(
                        //                     name: 'Married', value: "Married"),
                        //                 DropDownValueModel(
                        //                   name: 'Unmarried',
                        //                   value: "Unmarried",
                        //                 ),
                        //               ],
                        //               onChanged: (value) {},
                        //               textFieldDecoration: InputDecoration(
                        //                 labelText: "Marital status",
                        //                 labelStyle:
                        //                     TextStyle(color: AppColors.primary),
                        //                 // prefixIcon: Icon(
                        //                 //   Icons.arrow_drop_down_circle_outlined,
                        //                 //   color: AppColors.primary,)
                        //               ),
                        //               validator: (value) {
                        //                 if (value == null || value.isEmpty) {
                        //                   return "Required field";
                        //                 } else {
                        //                   return null;
                        //                 }
                        //               },
                        //             ),
                        //             const SizedBox(
                        //               height: 10,
                        //             ),
                        //             MyTextFormField(
                        //               "Enter Spouse's Name",
                        //               spouseNameController,
                        //               (value) {
                        //                 if (value!.isEmpty) {
                        //                   return "Please enter Spouse Name";
                        //                 }
                        //                 return null;
                        //               },
                        //               Icons.person,
                        //               TextInputType.phone,
                        //               spouseNameFocusNode,
                        //               spouseNameFocusNode.hasFocus
                        //                   ? AutovalidateMode.always
                        //                   : AutovalidateMode.disabled,
                        //               true,
                        //                   (p0) {
                        //                 uname = p0;
                        //               },                                    ),
                        //             const SizedBox(
                        //               height: 10,
                        //             ),
                        //             MyTextFormField(
                        //               "Enter Spouse Mobile Number",
                        //               spouseNumberController,
                        //               (value) {
                        //                 if (value!.isEmpty) {
                        //                   return "Please enter Spouse Mobile Number";
                        //                 }
                        //                 if (value.length < 10) {
                        //                   return "Password must be at least 10 characters long";
                        //                 }
                        //                 return null;
                        //               },
                        //               Icons.phone_android,
                        //               TextInputType.number,
                        //               spouseNumberFocusNode,
                        //               spouseNumberFocusNode.hasFocus
                        //                   ? AutovalidateMode.always
                        //                   : AutovalidateMode.disabled,
                        //               true,
                        //                   (p0) {
                        //                 uname = p0;
                        //               },                                    ),
                        //             const SizedBox(
                        //               height: 20,
                        //             ),
                        //             Wrap(
                        //               children: [
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.center,
                        //                   children: [
                        //                     Container(
                        //                       width: 150,
                        //                       margin: const EdgeInsets.only(
                        //                           bottom: 10),
                        //                       child: ButtonWidget(
                        //                           text: "Reset",
                        //                           color: AppColors.primary,
                        //                           onClicked: () {
                        //                             _formKey.currentState
                        //                                 ?.reset();
                        //                             _formKey.currentState
                        //                                 ?.deactivate();
                        //                           }),
                        //                     ),
                        //                     Container(
                        //                       width: 150,
                        //                       margin: const EdgeInsets.only(
                        //                           bottom: 10),
                        //                       child: ButtonWidget(
                        //                         text: "Submit",
                        //                         color: AppColors.primary,
                        //                         onClicked: () {
                        //                           if (_formKey.currentState!
                        //                               .validate()) {
                        //                             _formKey.currentState
                        //                                 ?.save();
                        //                           } else {
                        //                             setState(() {});
                        //                           }
                        //                         },
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ],
                        //             )
                        //           ],
                        //         ),
                        //       ]),
                        // ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('savedData');
    setState(() {
      _savedData = savedData!;
    });
  }

  void _saveData(String data) {
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child('my_data');
    DatabaseReference newChildRef = dbRef.push();
    String? key = newChildRef.key; // this will return the auto-generated UID
    newChildRef.set({
      'data': data,
      'timestamp': ServerValue.timestamp,
    });
  }
}
