import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../services/utils.dart';
import 'Session_controller.dart';

class LeaveController with ChangeNotifier{
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("leaveRequest");
  bool _loading =false;
  bool get loading => _loading;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());

  setLoading(bool value){
    _loading =value;
    notifyListeners();
  }
  void leaveRequest(String leaveType,String startDate,String endDate,String dayType,String reason,String mobile) async {
    setLoading(true);
    try {
      ref.child(SessionController().userId.toString()).child(date).set({
        "leaveType": leaveType,
        "startDate": startDate ,
        "endDate": endDate ,
        "dayType": dayType,
        "reason": reason,
        "mobile":mobile,
        "status": "Pending",
      }).then((value) {
        setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    }
    catch(e){
      Utils.toastMessage(e.toString());
    }
  }
}