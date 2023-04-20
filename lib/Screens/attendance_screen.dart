
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrms/constant/custom_appbar.dart';
import 'package:location/location.dart' hide LocationAccuracy;

import '../constant/app_colors.dart';
import '../constant/in_out_button.dart';


class AttendanceScreen extends StatefulWidget {

  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Position? _currentPosition;



  final _officeLocation = LocationData.fromMap({
    "latitude": 22.5525,
    "longitude": 72.9238,

  }) ;
  final _maxDistance = 1000;
  // in meters
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied)
      {
        permission = await Geolocator.requestPermission();
      }
    if(permission == LocationPermission.denied)
{
  return Future.error('Location Permission Denied');
}
      setState(() {
      _currentPosition = position;
    });
  }

  late User user;


  void _markAttendance(String status) async {
    if (_currentPosition != null) {
      // Calculate the distance between the user's location and the office location
      final distance = Geolocator.distanceBetween(
        _officeLocation.latitude!,
        _officeLocation.longitude!,
        _currentPosition!.latitude!,
        _currentPosition!.longitude,
      );
      if (distance <= _maxDistance) {
        // User is within the allowed distance from the office location
        // Save the attendance data in the database
        //DatabaseReference attendanceRef = FirebaseDatabase.instance.ref().child('attendance');
        //DatabaseReference newAttendanceRef = attendanceRef.push();
        // newAttendanceRef.set({
        //   'inTime': DateTime.now().toString(),
        //   'outTime': '',
        //   'status': 'in',
        //   'latitude': _currentPosition.latitude,
        //   'longitude': _currentPosition.longitude,
        // });
        try{
          final databaseRef = FirebaseDatabase.instance.ref().child("attendance");
          DatabaseReference attendanceRef= databaseRef.push();
          attendanceRef.set({
            'inTime': DateTime.now().toString(),
            'outTime':'',
            'status': 'in',
            'latitude': _currentPosition!.latitude,
            'longitude': _currentPosition!.longitude,
          });


        }
        catch(e){
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content:Text(e.toString()) ,);
        });
        }

      }
      else{
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content:Text("User is not within the allowed distance from the office location"));});
      }
    }
  }
  void _markInAttendance() {
    _markAttendance('in');


  }
  Future<void> _markOutAttendance() async {
    // Find the last attendance record for the user in the database
    // and update the "status" field to "out" and the "outTime" field to the current date and time.

    _markAttendance('out');
  }

  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _addMarker(LatLng(22.529480,72.956372), 'Birla Vishvakarma Mahavidyalaya (BVM)');

  }
  void _addMarker(LatLng position, String title) {
    final marker = Marker(
      markerId: MarkerId(title),
      position: position,
      infoWindow: InfoWindow(title: title),
    );
    setState(() {
      _markers.add(marker);
    });
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(appBar: AppBar(
      title: Text("Mark Attendace".toUpperCase()),
      backgroundColor: AppColors.primary,
      centerTitle: true,),
      body: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight /1.5,
            padding: EdgeInsets.all(5),
            child: Card(
              elevation: 10,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                circles: {
                  Circle(circleId: CircleId("1",),
                    radius: 5000
                  )
                },
                myLocationEnabled: true,

                initialCameraPosition: CameraPosition(
                    target: LatLng(22.529480,72.956372),

                    //target: LatLng(22.5525,72.9238),
                  zoom: 20
                ),
                markers: _markers,
              ),
            ),
          ),
          Container(child:Padding(
            padding: const EdgeInsets.all(30.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  inOutButton("IN", Colors.green, () { _markInAttendance();
                  }),
                  Spacer(flex: 30),
                  inOutButton("OUT", Colors.orangeAccent, () {_markOutAttendance();
                  }),
                ],
              ),
            ),
          ) ,)
        ],
      ),
    );
  }
}
