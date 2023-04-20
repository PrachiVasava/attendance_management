import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Screens/login_screen.dart';
import 'package:hrms/services/database.dart';
import 'package:lottie/lottie.dart';
import '../constant/app_colors.dart';
import '../constant/button_widget.dart';
import '../constant/language_constants.dart';
import 'homescreen.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  double screenHeight = 0;
  double screenWidth = 0;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  bool _passwordError = false;
  bool _conPasswordError = false;

  bool _obscureText = true;
  bool _isRegistering = false;
  bool showSpinner = false;

  Future<LottieBuilder?> registerWithEmailAndPassword(String email, String password) async {
    try {
      if (passwordConfirmed()) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email,
            password: password);
        User? user = userCredential.user;

        //await DatabaseService(uid:user?.uid).updateUserData('prachi', imageUrl, mobileNumber, email, dob)
        print('User ${user?.uid} registered successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User registered successfully!'),
          ),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        setState(() {
          _passwordError = true;
        }
        );
      }
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      }
    }
  }

bool isLoading= false;
  Future SignUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      CollectionReference collRef = FirebaseFirestore.instance.collection('Users');
      collRef.add({
        'Email':_emailController.text,
        'Password': _passController.text,
        "Confirm Password": _confirmController.text,
      });

      registerWithEmailAndPassword(
          _emailController.text.trim(),_passController.text.trim());
      setState(() {
        isLoading=true;
      });
      Get.to(() => const LoginScreen());

    } else {
      setState(() {});
    }
    setState(() {
      showSpinner = false;
    });
    Navigator.of(context).pop();

  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //padding: EdgeInsets.all(40),
                child: Lottie.asset(
                  "assets/animation/login.json",
                  width: screenWidth / 1,
                  height: 350,
                  fit: BoxFit.fill,
                ),
              ),
              //const SizedBox(height: 70,),
              Text(
                "Register below With your details!",
                style: TextStyle(fontSize: 18, color: AppColors.primary),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
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
                                return "Password must be at least 6 characters long";
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
                                //suffixIcon: Icon(CupertinoIcons.eye_solid,color: AppColors.primary,),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: screenHeight / 25,
                          ),
                          child: TextFormField(
                            controller: _confirmController,
                            obscureText: _obscureText,
                            focusNode: confirmFocusNode,
                            autovalidateMode: confirmFocusNode.hasFocus
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return translation(context)
                                    .please_enter_password;
                              }
                              if (value != _passController.text) {
                                return 'Password must be same as above';
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters long";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              errorText: _conPasswordError
                                  ? 'Please enter Same password password'
                                  : null,
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
                            ),
                          ),
                        ),
                        ButtonWidget(
                          onClicked: SignUp,
                          text: "Sign up",
                          color: AppColors.primary,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  style: TextStyle(
                                      color: AppColors.grey, fontSize: 15),
                                  'Already have account!',
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => LoginScreen());
                                  },
                                  child: Text(
                                    style: TextStyle(
                                        color: AppColors.blue, fontSize: 15),
                                    'Login Here',
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
  }
}
