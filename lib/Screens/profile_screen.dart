import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Screens/login_screen.dart';
import 'package:hrms/constant/button_widget.dart';
import '../classes/language_dropdown.dart';
import '../constant/app_colors.dart';
import '../constant/language_constants.dart';
import '../main.dart';
import '../services/users.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  double screenHeight = 0;
  double screenWidth = 0;
  final dbRef =FirebaseDatabase.instance.ref().child('users');


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            translation(context).profile,
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          elevation: 10,
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              onSelected: (Language? language) async {
                if (language != null) {
                  Locale local = await setLocale(language.languageCode);
                  MyApp.setLocale(context, local);
                }
              },
              itemBuilder: (BuildContext context) {
                return Language.languageList()
                    .map<PopupMenuItem<Language>>((e) =>
                        PopupMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ))
                    .toList();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [

              FirebaseAnimatedList(
                  query: dbRef,
                  shrinkWrap: true,
                  itemBuilder: (context,snapshot,animation,index){
                    return Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            horizontalTitleGap: 20,
                            leading: Container(
                              height: screenHeight,
                              width: 80,
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                  radius: 100,
                                  child:
                                  Image(
                                    image: const AssetImage(
                                      "assets/images/profile.png",
                                    ),
                                    color: AppColors.white,
                                  )),
                            ),
                            title: Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: 'Username: '.toUpperCase(),
                                      style: TextStyle(
                                        color: AppColors.grey,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: snapshot.child('userName').value.toString(),
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight:
                                                FontWeight.bold))
                                      ]),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'Mobile Number: ',
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 15),
                                          children: [
                                            TextSpan(
                                                text: snapshot.child('mobileNumber').value.toString(),
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                    FontWeight.bold))
                                          ]),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'Email : ',
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 15),
                                          children: [
                                            TextSpan(
                                                text: snapshot.child('email').value.toString(),
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                    FontWeight.bold))
                                          ]),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: ' Birthdate : ',
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 15),
                                          children: [
                                            TextSpan(
                                                text: snapshot.child('dob').value.toString(),
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                    FontWeight.bold))
                                          ]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 80, right: 80),
                            child: ButtonWidget(
                                text: "Edit Profile",
                                onClicked: () {
                                  Get.to(() =>  EditProfile());
                                },
                                color: AppColors.blue),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                    
                  }),
              // Card(
              //   elevation: 10,
              //   margin: const EdgeInsets.all(10),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20)),
              //   child: Column(
              //     children: [
              //       ListTile(
              //         contentPadding: const EdgeInsets.symmetric(
              //             horizontal: 10, vertical: 10),
              //         horizontalTitleGap: 20,
              //         leading: Container(
              //           height: screenHeight,
              //           width: 80,
              //           alignment: Alignment.center,
              //           child: CircleAvatar(
              //               radius: 100,
              //               child:
              //               Image(
              //                 image: const AssetImage(
              //                   "assets/images/profile.png",
              //                 ),
              //                 color: AppColors.white,
              //               )),
              //         ),
              //         title: Row(
              //           children: [
              //             RichText(
              //               text: TextSpan(
              //                   text: 'Username: '.toUpperCase(),
              //                   style: TextStyle(
              //                       color: AppColors.grey,
              //                       ),
              //                   children: [
              //                     TextSpan(
              //                         text: 'uname',
              //                         style: TextStyle(
              //                             color: AppColors.black,
              //                             fontWeight:
              //                             FontWeight.bold))
              //                   ]),
              //             ),
              //           ],
              //         ),
              //         subtitle: Column(
              //           children: [
              //             Row(
              //               children: [
              //                 RichText(
              //                   text: TextSpan(
              //                       text: 'Mobile Number: ',
              //                       style: TextStyle(
              //                           color: AppColors.grey,
              //                           fontSize: 15),
              //                       children: [
              //                         TextSpan(
              //                             text: "mobile",
              //                             style: TextStyle(
              //                                 color: AppColors.black,
              //                                 fontWeight:
              //                                 FontWeight.bold))
              //                       ]),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 RichText(
              //                   text: TextSpan(
              //                       text: 'Email : ',
              //                       style: TextStyle(
              //                           color: AppColors.grey,
              //                           fontSize: 15),
              //                       children: [
              //                         TextSpan(
              //                             text: "email",
              //                             style: TextStyle(
              //                                 color: AppColors.black,
              //                                 fontWeight:
              //                                 FontWeight.bold))
              //                       ]),
              //                 ),
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 RichText(
              //                   text: TextSpan(
              //                       text: ' Birthdate : ',
              //                       style: TextStyle(
              //                           color: AppColors.grey,
              //                           fontSize: 15),
              //                       children: [
              //                         TextSpan(
              //                             text: "dob",
              //                             style: TextStyle(
              //                                 color: AppColors.black,
              //                                 fontWeight:
              //                                 FontWeight.bold))
              //                       ]),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 80, right: 80),
              //         child: ButtonWidget(
              //             text: "Edit Profile",
              //             onClicked: () {
              //               Get.to(() =>  EditProfile());
              //             },
              //             color: AppColors.blue),
              //       ),
              //       const SizedBox(
              //         height: 20,
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showDialog(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary),
                    child: Text(
                      translation(context).log_out,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: (20),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 50,
                //insetPadding: const EdgeInsets.symmetric(vertical: 305),
                title: Text(translation(context).log_out),
                content: Column(children: [
                  Text(translation(context).do_you_really_want_to_log_out),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(17),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                translation(context).no,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                              Get.off(LoginScreen());
                            },
                            child: Container(
                              padding: const EdgeInsets.all(17),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                translation(context).yes,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ])),
          ),
        ),
      );
    },
  );
}
