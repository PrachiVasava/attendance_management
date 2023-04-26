import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Controller/Session_controller.dart';
import 'package:hrms/Screens/login_screen.dart';
import 'package:hrms/Controller/profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../classes/language_dropdown.dart';
import '../constant/app_colors.dart';
import '../constant/language_constants.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  String username = '';
  String mobile = '';
  String email = '';
  String birthdate = '';
  String image = '';
  final DatabaseReference inRef = FirebaseDatabase.instance.ref("users");
  final DatabaseReference outRef = FirebaseDatabase.instance.ref("users");

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
                create: (_) => ProfileController(),
                child: Consumer<ProfileController>(
                  builder: (context, provider, child) {
                    return StreamBuilder(
                      stream:
                      inRef.child(SessionController().userId.toString()).onValue,
                    builder: (context, AsyncSnapshot snapshot) {

                      if(!snapshot.hasData){
                    return Container(
                      width: screenWidth,
                      height: screenHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child: CircularProgressIndicator())
                        ],
                      ),
                    );
                      }
                      else if (snapshot.hasData) {
                      Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.primary,
                                            width: 5,
                                          )),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: provider.image == null
                                              ? map['image'].toString() == ""
                                                  ? Icon(
                                                      Icons.person,
                                                      color: AppColors.black,
                                                      size: 100,
                                                    )
                                                  : Image(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        map['image'].toString(),
                                                      ),
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      },
                                                      errorBuilder: (context,
                                                          object, stack) {
                                                        return Container(
                                                          child: Icon(
                                                            Icons.person,
                                                            color: AppColors
                                                                .black,
                                                            size: 100,
                                                          ),
                                                        );
                                                      })
                                              : Stack(
                                                  children: [
                                                    Image.file(
                                                      File(provider.image!.path)
                                                          .absolute,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  ],
                                                )),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.pickImage(context);
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: AppColors.primary,
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.white70,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //Text(map['username']),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  RowWidget(
                                      title: translation(context).username,
                                      iconData: Icons.person,
                                      value: map['username'] == ""
                                          ? "xxxxxxxxx"
                                          : map['username']),
                                  RowWidget(
                                      title: translation(context).mobile_no,
                                      iconData: Icons.phone_android,
                                      value: map['mobile'] == ""
                                          ? "xxx-xxx-xxxx"
                                          : map['mobile']),
                                  RowWidget(
                                      title: translation(context).email,
                                      iconData: Icons.email,
                                      value: map['email'] == ""
                                          ? "xxxxx@xxx.xxx"
                                          : map['email']),
                                ],
                              ),
                            ),
                            SizedBox(
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
                          ]);
                    }
                      else if (snapshot.data.snapshot.value == null) {
                    return Stack(
                      children: [
                        Image.asset(
                          'assets/images/background.jpg',
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        Container(
                          width: screenWidth,
                          height: screenHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(translation(context).no_attendance_data.toUpperCase(),style: TextStyle(fontSize: 20,),textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ],
                    );
                      }

                      else {
                      return Center(
                          child: Text(
                            translation(context).something_went_wrong,
                        style: Theme.of(context).textTheme.titleMedium,
                      ));
                    }
                      },
                    );
                  },
                ),
              ),
            ],
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
            height: MediaQuery.of(context).size.height / 2.8,
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
                              FirebaseAuth auth = FirebaseAuth.instance;
                              auth.signOut().then((value) {
                                SessionController().userId = "";
                                Get.off(LoginScreen());
                              });
                              Navigator.pop(context);
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

class RowWidget extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const RowWidget(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Icon(
            iconData,
            color: AppColors.primary,
          ),
          trailing: Text(value),
        ),
        Divider(
          color: AppColors.primary.withOpacity(0.4),
          indent: 10,
          endIndent: 10,
        )
      ],
    );
  }
}
