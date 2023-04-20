import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hrms/constant/app_colors.dart';

import 'package:hrms/constant/custom_appbar.dart';

import '../constant/language_constants.dart';

class ItemList extends StatelessWidget {
  final String selectedValue;
  final String fromDate, toDate;

  ItemList(
      {Key? key,
      required this.selectedValue,
      required this.fromDate,
      required this.toDate})
      : super(key: key);

  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  double screenHeight = 0;
  double screenWidth = 0;

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: translation(context).item_list,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              height: screenHeight ,
              width: screenWidth,
              padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                        height: screenHeight / 7,
                        child: Card(
                          semanticContainer: true,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.person,
                                size: 60,
                              ),
                            ),
                            title: Text(user.email!
                                .replaceAll("@gmail.com", "")
                                .toUpperCase(),),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: 'Selected Items is:',
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 18),
                                          children: [
                                            TextSpan(
                                                text: selectedValue,
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'From Date:',
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 18),
                                        children: [
                                          TextSpan(
                                              text: fromDate,
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight:
                                                      FontWeight.bold))
                                        ]),
                                  ),
                                ]),
                                Row(children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'To Date:',
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 18),
                                        children: [
                                          TextSpan(
                                              text: toDate,
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight:
                                                  FontWeight.bold))
                                        ]),
                                  ),
                                ])
                              ],
                            ),
                          ),
                        ));
                  }),
            )),

      ),
    );
  }
}
