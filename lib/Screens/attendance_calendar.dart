import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrms/Screens/attendance_regularization.dart';
import 'package:hrms/Screens/leave_request.dart';
import 'package:hrms/constant/language_constants.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constant/app_colors.dart';
import '../constant/custom_appbar.dart';

class AttendanceCalendar extends StatefulWidget {
  const AttendanceCalendar({Key? key}) : super(key: key);

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  final dateFormat = DateFormat('dd-MMMM-yyyy EEEE');

  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CustomAppBar(),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Center(
                child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                translation(context).calendar.toUpperCase(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: AppColors.white),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 8,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20)),
              child: TableCalendar(
                calendarFormat: _calendarFormat,
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2010, 10, 20),
                lastDay: DateTime.utc(2040, 10, 20),
                startingDayOfWeek: StartingDayOfWeek.monday,
                weekendDays: const [DateTime.sunday],
                rowHeight: 50,
                daysOfWeekHeight: 50,
                availableGestures: AvailableGestures.all,
                sixWeekMonthsEnforced: true,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDate, day);
                },
                onDaySelected: (date, events) {
                  setState(() {
                    _selectedDate = date;
                    _focusedDay = _focusedDay;
                  });
                },
                holidayPredicate: (date) => is2ndOr4thSaturday(date),
                calendarStyle: CalendarStyle(
                  holidayTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                  holidayDecoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.red,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    //color: Colors.red
                  ),
                  weekendTextStyle: TextStyle(color: Colors.red),
                  weekendDecoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.red,
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    //color: Colors.blue
                  ),
                  todayDecoration: BoxDecoration(color: AppColors.primary),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    //borderRadius: BorderRadius.circular(20),
                  ),
                  titleTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: AppColors.black,
                    size: 28,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: AppColors.black,
                    size: 28,
                  ),
                ),
                onDayLongPressed: (date, events) {
                  setState(() {
                    _selectedDate = date;
                  });

                  if (_selectedDate.isBefore(DateTime.now())) {
                    // Show alert box for previous date
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          scrollable: true,
                          title: Text(dateFormat.format(_selectedDate)),
                          actions: <Widget>[
                            GestureDetector(
                              onTap: () => Get.to(() => const LeaveRequest()),
                              child: SizedBox(
                                height: 35,
                                width: screenWidth,
                                child: Text(
                                  translation(context).leave_request,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.black,
                            ),
                            GestureDetector(
                              onTap: () => Get.off(
                                  () => const AttendanceRegularization()),
                              child: SizedBox(
                                height: 35,
                                width: screenWidth,
                                child: Text(
                                  translation(context).attendance_regularization,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Show alert box for today or future date
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          scrollable: true,
                          title: Text(dateFormat.format(_selectedDate)),
                          actions: <Widget>[
                            GestureDetector(
                              onTap: () => Get.to(() => const LeaveRequest()),
                              child: SizedBox(
                                height: 35,
                                width: screenWidth,
                                child: Text(
                                  translation(context).leave_request,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: GridView.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(choices.length, (index) {
                  return Center(
                    child: SelectCard(
                      choice: choices[index],
                      key: null,
                    ),
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.red,
                          ),
                        ),
                        Text(
                          " - ",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          translation(context).holiday,
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          " - ",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          translation(context).today_date,
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                ),
                Container(
                  height: 10,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.green,
                  ),
                ),
                Text(
                  " - ",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  translation(context).absent,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ],
            )),
          ],
        ));
  }

  bool is2ndOr4thSaturday(DateTime date) {
    // Check if the date is a Saturday
    if (date.weekday != DateTime.saturday) {
      return false;
    }
    // Check if the date is the 2nd or 4th Saturday of the month
    int weekNumber = ((date.day - 1) / 7).ceil();
    return (weekNumber == 2 || weekNumber == 4);
  }
}

class Choices {
  const Choices({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

List<Choices> choices = <Choices>[
  Choices(title: "casual leave", icon: Icons.one_k),
  Choices(title: 'Leave Without Pay', icon: Icons.one_k),
  Choices(title: 'Sick Leave', icon: Icons.one_k),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choices choice;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.primary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: '5',
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: '/',
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '20',
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                          ]),
                    ),
                  ),
                  Center(
                    child: Text(
                      choice.title,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
          ),
        ));
  }
}
