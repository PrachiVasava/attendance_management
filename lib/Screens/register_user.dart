import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Screens/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../Controller/register_controller.dart';
import '../constant/app_colors.dart';
import '../constant/button_widget.dart';
import '../constant/language_constants.dart';
import '../services/utils.dart';
import 'homescreen.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  double screenHeight = 0;
  double screenWidth = 0;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _passwordError = false;
  bool _conPasswordError = false;

  bool _obscureText = true;
  bool _isRegistering = false;
  bool showSpinner = false;

  bool passwordConfirmed() {
    if (_passController.text.trim() == _confirmController.text.trim()) {
      return true;
    } else {
      return _conPasswordError;
    }
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        body: ChangeNotifierProvider(
          create: (_) => registerController(),
          child: Consumer<registerController>(
            builder: (context, provider, child) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: screenHeight * 1.1,
                    width: screenWidth,
                    child: Column(
                      children: [
                        Container(
                          //padding: EdgeInsets.all(40),
                          child: Lottie.asset(
                            "assets/animation/login.json",
                            width: 300,
                            height: 300,
                            fit: BoxFit.fill,
                          ),
                        ),
                        //const SizedBox(height: 70,),
                        Text(
                          translation(context).register_string,
                          style:
                              TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            alignment: Alignment.center,
                            width: screenWidth,
                            margin: EdgeInsets.symmetric(
                                horizontal: screenWidth / 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    focusNode: usernameFocusNode,
                                    autovalidateMode: usernameFocusNode.hasFocus
                                        ? AutovalidateMode.always
                                        : AutovalidateMode.disabled,
                                    controller: _usernameController,
                                    onFieldSubmitted: (value) {
                                      Utils.fieldFocus(context,
                                          usernameFocusNode, emailFocusNode);
                                    },
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? translation(context)
                                              .please_enter_username
                                          : null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: translation(context).username,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: AppColors.primary,
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                    ),
                                  ),
                                  TextFormField(
                                    focusNode: emailFocusNode,
                                    autovalidateMode: emailFocusNode.hasFocus
                                        ? AutovalidateMode.always
                                        : AutovalidateMode.disabled,
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return translation(context)
                                            .please_enter_email_address;
                                      }
                                      if (!RegExp(
                                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                          .hasMatch(value)) {
                                        return translation(context)
                                            .valid_email_address;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: translation(context).email,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: AppColors.primary,
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                    ),
                                  ),
                                  TextFormField(
                                    focusNode: mobileFocusNode,
                                    autovalidateMode: mobileFocusNode.hasFocus
                                        ? AutovalidateMode.always
                                        : AutovalidateMode.disabled,
                                    controller: _mobileController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return translation(context)
                                            .please_enter_mobile_no;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: translation(context).mobile_no,
                                      prefixIcon: Icon(
                                        Icons.phone_android,
                                        color: AppColors.primary,
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      controller: _passController,
                                      obscureText: _obscureText,
                                      focusNode: passwordFocusNode,
                                      autovalidateMode:
                                          passwordFocusNode.hasFocus
                                              ? AutovalidateMode.always
                                              : AutovalidateMode.disabled,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return translation(context)
                                              .please_enter_password;
                                        }
                                        if (value.length < 6) {
                                          return translation(context)
                                              .password_length;
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText:
                                            translation(context).password,
                                        errorText: _passwordError
                                            ? translation(context)
                                                .password_length
                                            : null,
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: AppColors.primary,
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 4, 0),
                                          child: GestureDetector(
                                            onTap: _toggleObscureText,
                                            child: Icon(
                                              _obscureText
                                                  ? Icons.visibility_rounded
                                                  : Icons
                                                      .visibility_off_rounded,
                                              size: 24,
                                            ),
                                          ),
                                          //suffixIcon: Icon(CupertinoIcons.eye_solid,color: AppColors.primary,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      controller: _confirmController,
                                      obscureText: _obscureText,
                                      focusNode: confirmFocusNode,
                                      autovalidateMode:
                                          confirmFocusNode.hasFocus
                                              ? AutovalidateMode.always
                                              : AutovalidateMode.disabled,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return translation(context)
                                              .please_enter_password;
                                        }
                                        if (value != _passController.text) {
                                          return translation(context)
                                              .same_password;
                                        }
                                        if (value.length < 6) {
                                          return translation(context)
                                              .password_length;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: translation(context)
                                            .confirm_password,
                                        errorText: _conPasswordError
                                            ? translation(context).same_password
                                            : null,
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: AppColors.primary,
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 4, 0),
                                          child: GestureDetector(
                                            onTap: _toggleObscureText,
                                            child: Icon(
                                              _obscureText
                                                  ? Icons.visibility_rounded
                                                  : Icons
                                                      .visibility_off_rounded,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ButtonWidget(
                                    onClicked: () {
                                      if (_formKey.currentState!.validate()) {
                                        provider.signUp(
                                          _usernameController.text.toString(),
                                          _emailController.text.toString(),
                                          _mobileController.text.toString(),
                                          _passController.text.toString(),
                                          _confirmController.text.toString(),
                                        );
                                      }
                                    },
                                    text: translation(context).sign_up,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            style: TextStyle(
                                                color: AppColors.grey,
                                                fontSize: 15),
                                            translation(context)
                                                .already_account,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => LoginScreen());
                                            },
                                            child: Text(
                                              style: TextStyle(
                                                  color: AppColors.blue,
                                                  fontSize: 15),
                                              translation(context).login_here,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
