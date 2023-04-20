import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms/constant/app_colors.dart';
import 'package:hrms/constant/button_widget.dart';
import '../constant/custom_appbar.dart';
import '../constant/language_constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("HRMS"),
      backgroundColor: AppColors.primary,
      centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal:50),
            child: Center(
                child: Text(
                    "Enter your Email and we will send you a password resend link",
                  textAlign: TextAlign.center,
                )),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
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
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  labelText: translation(context).email,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppColors.primary,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(
                      20.0, 10.0, 20.0, 10.0),
                ),
              ),
            ),
          ),
          ButtonWidget(text: "Reset Password",
              onClicked: forgotPassword, color: AppColors.primary)
        ],
      ),
    );
  }

 Future forgotPassword() async{
   if (_formKey.currentState!.validate()) {
     _formKey.currentState?.save();
   } else {
     setState(() {});
   }

   try{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
  showDialog(context: context, builder: (context){
    return AlertDialog(content:Text("Password Reset Link send!Check your Email") ,);
  });
} on FirebaseAuthException catch (e){
  print(e);
  showDialog(context: context, builder: (context){
    return AlertDialog(content:Text(e.message.toString()) ,);
  });
}
  }
}
