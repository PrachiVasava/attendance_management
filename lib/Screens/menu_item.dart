import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:hrms/constant/custom_appbar.dart';
import '../constant/app_colors.dart';
import '../constant/language_constants.dart';


class MenuItemScreen extends StatefulWidget {
  const MenuItemScreen({Key? key}) : super(key: key);

  @override
  State<MenuItemScreen> createState() => _MenuItemScreen();
}

class _MenuItemScreen extends State<MenuItemScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  final bool customIcon = false;

  List<String> icons = [
    "assets/images/tea.png",
    "assets/images/coffee.png",
    "assets/images/paratha.png",
    "assets/images/lunch.png",
  ];

  List<String> beverage = [
    "Tea",
    "Coffee",
  ];
  List<String> breakfast = [
    "paratha",
  ];
  List<String> lunch = [
    "Gujrati Thali",
  ];

  // List<Map<String, dynamic>> beverage = [
  //   {'title': "Tea", 'subtitle': "15", 'isSelected': false},
  //   {'title': "Coffee", 'subtitle': "20", 'isSelected': false},
  // ];
  // List<Map<String, dynamic>> breakfast = [
  //   {'title': "Paratha", 'subtitle': "40", 'isSelected': false},
  // ];
  // List<Map<String, dynamic>> lunch = [
  //   {'title': "Gujrati Thali", 'subtitle': "80", 'isSelected': false},
  // ];
  Set<String> selectedValues = {};
  int selectedTile = -1;

  // String getTotal() {
  //   List<Map<String, dynamic>> selected1 =
  //       beverage.where((item) => item['isSelected']).toList();
  //   List<Map<String, dynamic>> selected2 =
  //       breakfast.where((item) => item['isSelected']).toList();
  //   List<Map<String, dynamic>> selected3 =
  //       lunch.where((item) => item['isSelected']).toList();
  //   num total = selected1
  //           .map<int>((item) => int.parse(item['subtitle']))
  //           .fold(0, (prev, element) => prev + element) +
  //       selected2
  //           .map<int>((item) => int.parse(item['subtitle']))
  //           .fold(0, (prev, element) => prev + element) +
  //       selected3
  //           .map<int>((item) => int.parse(item['subtitle']))
  //           .fold(0, (prev, element) => prev + element);
  //   String result = '';
  //   if (selected1.isNotEmpty) {
  //     result += '';
  //     for (var item in selected1) {
  //       result += '${item['title']}\n\n'.toUpperCase();
  //     }
  //   }
  //   if (selected2.isNotEmpty) {
  //     result += '';
  //     for (var item in selected2) {
  //       result += '${item['title']}\n\n'.toUpperCase();
  //     }
  //   }
  //   if (selected3.isNotEmpty) {
  //     result += '';
  //     for (var item in selected3) {
  //       result += '${item['title']}\n\n'.toUpperCase();
  //     }
  //   }
  //   result += 'Total Amount: $total'.toUpperCase();
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    //int totalAmount = int.parse(getTotal().replaceAll(RegExp('[^0-9]'), ''));

    return Scaffold(
      appBar: CustomAppBar(
        title: translation(context).menu_item,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  translation(context).menu_of_the_day.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(15),
              elevation: 10,
              child: ExpansionTile(
                key: UniqueKey(),
                title: Text(translation(context).beverage.toUpperCase()),
                children: [
                  SizedBox(
                      height: screenHeight / 6,
                      child: ListView.builder(
                          itemCount: beverage.length,
                          itemBuilder: (context, index) {
                            return Column(
                                children: [
                                  ListTile(
                                    title: Text(beverage[index]),
                                    leading:Image(image: AssetImage(icons[index])),
                                  ),
                                  ]
                            );
                          }))
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(15),
              elevation: 10,
              child: ExpansionTile(
                key: UniqueKey(),
                title: Text(translation(context).breakfast.toUpperCase()),
                children: [
                  SizedBox(
                      height: screenHeight / 10,
                      child: ListView.builder(
                          itemCount: breakfast.length,
                          itemBuilder: (context, index) {
                            return Column(
                                children: [
                                  ListTile(
                                    title: Text(breakfast[index]),
                                    leading:Image(image: AssetImage(icons[2])),
                                  ),
                                ]
                            );
                          }))
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(15),
              elevation: 10,
              child: ExpansionTile(
                key: UniqueKey(),
                title: Text(translation(context).lunch.toUpperCase()),
                children: [
                  SizedBox(
                      height: screenHeight / 10,
                      child: ListView.builder(
                          itemCount: lunch.length,
                          itemBuilder: (context, index) {
                            return Column(
                                children: [
                                  ListTile(
                                    title: Text(lunch[index]),
                                    leading:Image(image: AssetImage(icons[3])),
                                  ),
                                ]
                            );
                          }))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
