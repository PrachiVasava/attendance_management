import 'dart:async';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' hide LocationAccuracy;
import 'package:lottie/lottie.dart' hide Marker;
import 'package:provider/provider.dart';
import '../Controller/Session_controller.dart';
import '../Controller/profile_controller.dart';
import 'package:provider/provider.dart';
import '../constant/app_colors.dart';
import '../constant/in_out_button.dart';
import '../services/utils.dart';

class AttendanceScreen extends StatefulWidget with ChangeNotifier{

  AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Position? _currentPosition;


  String? datelist(){
    List<String> dateList = [];
    DateTime startDate = DateTime(2022, 1, 1); // Example start date
    DateTime today = DateTime.now();
    for (var i = startDate; i.isBefore(today); i = i.add(Duration(days: 1))) {
      String date = DateFormat('dd-MM-yyyy').format(i);
      dateList.add(date);
    }
  }
  final _officeLocation = LocationData.fromMap({
    "latitude": 22.5525,
    "longitude": 72.9238,
  });

  final _maxDistance = 150000;
  // in meters

  @override
  void initState() {
    super.initState();
    _polygone.add(Polygon(
        polygonId: PolygonId("1"),
        points: points,
        fillColor: AppColors.map,
        geodesic: true,
        strokeWidth: 1,
        strokeColor: AppColors.primary));
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return Future.error('Location Permission Denied');
    }
    setState(() {
      _currentPosition = position;
    });
  }

  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String time = DateFormat.Hms().format(DateTime.now());

  void _markAttendance(String status,String time) async {
    if (_currentPosition != null) {
      // Calculate the distance between the user's location and the office location
      final distance = Geolocator.distanceBetween(
        _officeLocation.latitude!,
        _officeLocation.longitude!,
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      if (distance <= _maxDistance) {
        DatabaseReference ref = FirebaseDatabase.instance.ref().child("attendance");
        ref.child(SessionController().userId.toString()).child(date).set({
            "date": date,
            "inTime": DateFormat.Hms().format(DateTime.now()),
            "status": status,
            "outTime": "",
        }).then((value) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Lottie.asset(
              "assets/animation/check_in.json",
              width: 100,
              height: 250,
              fit: BoxFit.fill,
            ),
            title: Center(
              child: Text(isCheckedIn ? 'User Checked in Successfully' : 'User Checked out Successfully',
                  textAlign: TextAlign.center,
                )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        });
        });
      }
      else {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                  content: Text(
                      "User is not within the allowed distance from the office location"));
            });
      }
    }
  }
  bool isCheckedIn = false;

  void _markInAttendance() {
    setState(() {
      isCheckedIn = true;
    });
    _markAttendance('Check-in',time);
  }
  void _markOutAttendanceUpdate(String status,String time) async {
    // Find the last attendance record for the user in the database
    // and update the "status" field to "out" and the "outTime" field to the current date and time.
    final ref = FirebaseDatabase.instance.ref().child('attendance').child(SessionController().userId.toString()).child(date);
    await ref.update({
      'outTime': time,
      'status': status,
    }).then((value){
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Lottie.asset(
            "assets/animation/check_in.json",
            width: 100,
            height: 250,
            fit: BoxFit.fill,
          ),
          title: Center(
              child: Text(isCheckedIn ? 'User Checked in Successfully' : 'User Checked out Successfully',
                textAlign: TextAlign.center,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      });

    }).onError((error, stackTrace){
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                content: Text(
                    "User is not within the allowed distance from the office location"));
          });
        });
  }
    Future<void> _markOutAttendance() async {
    setState(() {
      isCheckedIn = false;
    });
    _markOutAttendanceUpdate('Check-out',time);

  }

  Set<Polygon> _polygone = HashSet<Polygon>();

//BVM F Block Codinate
  List<LatLng> points = [
    LatLng(22.553809, 72.923633), //Canteen
    LatLng(22.553821, 72.923867), // petpuja
    LatLng(22.553120, 72.923949), //bvm Library
    LatLng(22.553101, 72.923739), //Entrence
    LatLng(22.553809, 72.923633), //Canteen
  ];

  final List<Marker> _markers = const <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(22.553318364891833, 72.92376387994821),
        infoWindow: InfoWindow(title: "BVM Computer Department"))
  ];
  final DatabaseReference ref = FirebaseDatabase.instance.ref("users");

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Mark Attendace".toUpperCase()),
          backgroundColor: AppColors.primary,
          centerTitle: true,
        ),
        body: Column(
                  children: [
                    Container(
                      width: screenWidth,
                      height: screenHeight / 1.5,
                      padding: EdgeInsets.all(5),
                      child: Card(
                        elevation: 10,
                        child: GoogleMap(
                          markers: Set<Marker>.of(_markers),
                          myLocationEnabled: true,
                          initialCameraPosition: const CameraPosition(
                              target: LatLng(22.553146, 72.923719),
                              //Entrence
                              zoom: 19),
                          polygons: _polygone,
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              inOutButton("IN", Colors.green, () {
                                _markInAttendance();
                              }),
                              const Spacer(flex: 30),
                              inOutButton("OUT", Colors.orangeAccent, () {
                                _markOutAttendance();
                              }),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),

              );
  }
}
