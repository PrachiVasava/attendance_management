import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Controller/login_controller.dart';
import 'package:hrms/Screens/index_homescreen.dart';
import 'package:lottie/lottie.dart';
import 'package:hrms/Screens/register_user.dart';
import 'package:hrms/constant/app_colors.dart';
import 'package:provider/provider.dart';
import 'forgot_password.dart';
import '../classes/google_auth_service.dart';
import '../constant/button_widget.dart';
import '../constant/language_constants.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;

  const LoginScreen({Key? key, this.onTap}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _passwordError = false;
  String? _errorMessage;

  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Error'),
  //         content: Text(message),
  //         actions: [
  //           TextButton(
  //             child: Text('OK'),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future login() async {
  //
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState?.save();
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return const Center(child: CircularProgressIndicator(),heightFactor: 50,widthFactor: 50,);
  //         });
  //     try {
  //       await FirebaseAuth.instance.signInWithEmailAndPassword(
  //           email: _emailController.text.trim(),
  //           password: _passController.text.trim());
  //
  //       Get.to(IndexHomeScreen());
  //
  //     } on FirebaseAuthException catch (e) {
  //       print(e);
  //       Navigator.of(context).pop();
  //       showDialog(context: context, builder: (context){
  //         return AlertDialog(content:Text(e.message.toString()) ,
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],);
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(content:Text("Please Enter Email id and password") ,);
  //
  //           });
  //     });
  //   }
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Lottie.asset(
                "assets/animation/login.json",
                width: screenWidth / 1,
                height: 350,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: screenWidth,
              alignment: Alignment.topCenter,
              //padding: const EdgeInsets.only(top: -30),
              child: Text(
                translation(context).loginbtn.toUpperCase(),
                style: TextStyle(
                  fontSize: screenWidth / 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                  alignment: Alignment.center,
                  width: screenWidth,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              return translation(context).valid_email_address;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: translation(context).email,
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: screenHeight / 25,
                          ),
                          child: TextFormField(
                            controller: _passController,
                            obscureText: _obscureText,
                            focusNode: passwordFocusNode,
                            autovalidateMode: passwordFocusNode.hasFocus
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return translation(context)
                                    .please_enter_password;
                              }
                              if (value.length < 6) {
                                return translation(context).password_length;
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: translation(context).password,
                              errorText:
                                  _passwordError ? 'Incorrect password' : null,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: AppColors.primary,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                child: GestureDetector(
                                  onTap: _toggleObscureText,
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    size: 24,
                                  ),
                                ),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                            ),
                          ),
                        ),
                      ])),
            ),
            const SizedBox(
              height: 10,
            ),
            Transform.translate(
              offset: Offset(-25, 00),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ForgotPassword();
                        }));
                      },
                      child: Text(
                        translation(context).forgot_password,
                        style: TextStyle(color: AppColors.blue),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ChangeNotifierProvider(
              create: (_) => LoginController(),
              child: Consumer<LoginController>(
                builder: (context, provider, child) {
                  return ButtonWidget(
                      text: translation(context).loginbtn,
                      onClicked: () {
                        if (_formKey.currentState!.validate()) {
                          provider.login(_emailController.text,
                              _passController.text.toString());
                        }
                      },
                      color: AppColors.primary);
                },
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  style: TextStyle(color: AppColors.grey, fontSize: 18),
                  translation(context).new_here,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const RegisterUser());
                  },
                  child: Text(
                    style: TextStyle(color: AppColors.blue, fontSize: 18),
                    translation(context).register_now,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
